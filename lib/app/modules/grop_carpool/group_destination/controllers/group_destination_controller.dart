import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:green_pool/app/data/post_ride_model.dart';
import 'package:green_pool/app/modules/find_ride/controllers/find_ride_controller.dart';
import 'package:green_pool/app/modules/home/controllers/home_controller.dart';
import 'package:green_pool/app/services/dio/endpoints.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';

import '../../../../data/google_location_model.dart';
import '../../../../services/storage.dart';
import '../../create_new_event/controllers/create_new_event_controller.dart'; // Import this for CancelableOperation


enum LocationValues {
  origin,
  destination,
  addStop1,
  addStop2,
  findRideOrigin,
  findRideDestination
}

class GroupDestinationController extends GetxController {
  TextEditingController originController = TextEditingController();
  var uuid = const Uuid();
  String? _sessionToken;
  DateTime? _sessionStartTime;
  final int sessionTimeout = 5 * 60; // 5 minutes timeout in seconds

  RxList<dynamic> addressSugestionList = [].obs;
  final debouncer = Debouncer(delay: const Duration(seconds: 1));
  RxBool isLoading = false.obs;
  RxBool isOrigin = false.obs;
  LocationValues locationValues = LocationValues.origin;
  var postRideModel = PostRideModel().obs;

  CancelableOperation? _cancelableOperation;
  RxList<dynamic> findLocationModels = [].obs;
  RxBool hidePrevLoc = false.obs;

  @override
  void onInit() {
    super.onInit();
    // locationValues = Get.arguments;
    _loadLocationNames(locationValues.name);
  }

  void _loadLocationNames(String type) {
    try {
      // Fetch the location data for the specified type
      String? storedLocations =
          Get.find<GetStorageService>().getFindLocationByType(type);

      if (storedLocations != null && storedLocations.isNotEmpty) {
        // Decode the stored JSON into a list of maps
        List<dynamic> locationListMap = jsonDecode(storedLocations);

        // Update the reactive locationModels list
        findLocationModels.value = locationListMap.toList();
      } else {
        // If no data is found, clear the locationModels list
        findLocationModels.clear();
        debugPrint("No locations found for type: $type");
      }
    } catch (e) {
      debugPrint("Error loading location names: $e");
    }
  }

  void setSessionToken() {
    // Check if session has expired or not started
    if (_sessionToken == null || hasSessionExpired()) {
      _sessionToken = uuid.v4();
      _sessionStartTime = DateTime.now(); // Record session start time
    }

    if (originController.text.length > 3) {
      debouncer(() => addressAutoComplete(originController.text));
    }
  }

  bool hasSessionExpired() {
    if (_sessionStartTime == null) return true;
    return DateTime.now().difference(_sessionStartTime!).inSeconds >=
        sessionTimeout;
  }

// Call this when a place is selected to reset session
  void resetSessionToken() {
    if (_sessionToken != null && _sessionStartTime != null) {
      int sessionDuration =
          DateTime.now().difference(_sessionStartTime!).inSeconds;
      debugPrint('Session lasted for $sessionDuration seconds');
    }
    _sessionToken = null;
    _sessionStartTime = null;
  }

  addressAutoComplete(String input) async {
    //from search query to address suggestions
    String apiKey = Endpoints.googleApiKey;
    String lat = Get.find<HomeController>().latitude.value.toString();
    String long = Get.find<HomeController>().longitude.value.toString();

    try {
      isLoading.value = true;
      hidePrevLoc.value = true;

      String baseURL = Endpoints.googleAutocompleteApiUrl;
      String components = 'country:ca';
      String request =
          '$baseURL?input=$input&location=$lat%$long&radius=500&key=$apiKey&sessiontoken=$_sessionToken&components=$components';

      _cancelableOperation = CancelableOperation.fromFuture(
        http.get(Uri.parse(request)),
        onCancel: () {
          debugPrint('Google API call cancelled');
        },
      );

      var response = await _cancelableOperation?.value;

      if (response != null && response.statusCode == 200) {
        final predictions = jsonDecode(response.body.toString())['predictions'];
        addressSugestionList.value = predictions;
        if (predictions.isEmpty) {
          hidePrevLoc.value = false;
        }
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      if (_cancelableOperation?.isCanceled == true) {
        debugPrint('Request was canceled');
      } else {
        throw Exception(e);
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<dynamic>> getLatLong(String placeId) async {
    final storageService = Get.find<GetStorageService>();

    // Check the cache for the placeId
    if (storageService.locationCache.containsKey(placeId)) {
      return storageService.locationCache[placeId]!;
    }

    //if not found in cache then fetch from google api
    String placeApiKey = Endpoints.googleApiKey;
    String baseurl = Endpoints.googlePlaceApiUrl;

    try {
      String request =
          '$baseurl/details/json?place_id=$placeId&key=$placeApiKey';
      var response = await http.get(Uri.parse(request));
      final geometry =
          GoogleLocationModel.fromJson(jsonDecode(response.body)).result;
      double lat = geometry?.geometry?.location?.lat ?? 0.0;
      double long = geometry?.geometry?.location?.lng ?? 0.0;
      String nameOfLocation = geometry?.formattedAddress ?? "";

      // Add the fetched data to the cache
      storageService
          .addToFindLocationCache(placeId, [lat, long, nameOfLocation]);

      return [lat, long, nameOfLocation];
    } catch (e) {
      debugPrint("getLatLong error: $e");
      throw Exception('Failed to load data');
    }
  }

  Future<void> setLocationData(String placeId) async {
    try {
      List<dynamic> fetchLatLong = await getLatLong(placeId);

      setLocationToFindRideController(fetchLatLong);
    } catch (e) {
      log("setLocationData error: $e");
    }
  }

  //TO SET LOCATION FROM CACHE
  Future<void> setLocationFromCache(String type, int index) async {
    try {
      // fetch the serialized JSON string from storage
      String? storedLocation = Get.find<GetStorageService>().getFindLocationByType(type);

      // decode the JSON string
      List<dynamic> decodedList = jsonDecode(storedLocation ?? "");

      // access the specific location in the list
      var location = decodedList[index];

      List<dynamic> fetchLatLong = [
        location["latitude"],
        location["longitude"],
        location["address"]
      ];

      // set the location to the controller
      setLocationToFindRideController(fetchLatLong);
    } catch (e) {
      debugPrint("setLocationFromCache error: $e");
    }
  }
  // FindRideController
  void setLocationToFindRideController(List<dynamic> fetchLatLong) {
      Get.find<CreateNewEventController>().riderOriginLat = fetchLatLong[0];
      Get.find<CreateNewEventController>().riderOriginLong = fetchLatLong[1];
      Get.find<CreateNewEventController>().riderOriginTextController.text =
          fetchLatLong[2];
      _saveLocation(fetchLatLong, "findRideOrigin");
  }

  //TO SAVE LOCATION DATA
  void _saveLocation(List<dynamic> fetchLatLong, String locationType) {
    final getStorageService = Get.find<GetStorageService>();

    // create a new location model
    Map<String, dynamic> newLocationModel = {
      "latitude": fetchLatLong[0],
      "longitude": fetchLatLong[1],
      "address": fetchLatLong[2],
    };

    // retrieve existing locations for the specific type
    String? storedLocations = getStorageService.getLocationByType(locationType);

    if (storedLocations != null && storedLocations.isNotEmpty) {
      findLocationModels.value = jsonDecode(storedLocations);
    }

    // check if the new location is a duplicate
    if (!isDuplicate(newLocationModel, findLocationModels)) {
      findLocationModels.add(newLocationModel);

      // save the updated list back to storage
      getStorageService.setLocationByType(
          locationType, jsonEncode(findLocationModels));

      debugPrint("$locationType saved successfully.");
    } else {
      debugPrint("$locationType already exists in the list.");
    }
    Get.back();
  }

  // Helper function to check if a location is a duplicate
  bool isDuplicate(
      Map<String, dynamic> newLocationModel, List<dynamic> findLocationModels) {
    for (var model in findLocationModels) {
      if (model["latitude"] == newLocationModel["latitude"] &&
          model["longitude"] == newLocationModel["longitude"] &&
          model["address"] == newLocationModel["address"]) {
        return true;
      }
    }
    return false;
  }
}

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/data/find_ride_model.dart';
import 'package:green_pool/app/data/location_model.dart';
import 'package:green_pool/app/modules/home/controllers/home_controller.dart';
import 'package:green_pool/app/services/colors.dart';
import 'package:green_pool/app/services/snackbar.dart';
import 'package:green_pool/generated/locales.g.dart';

import '../../../../routes/app_pages.dart';
import '../../../../services/dialog_helper.dart';
import '../../../../services/storage.dart';
import '../../../../utils/date_utils.dart';
import '../../../origin/controllers/origin_controller.dart';


class CreateNewEventController extends GetxController {
  bool isDriver = false;
  int numberOfSeatAvailable = 1;
  RxBool isActive = false.obs;
  RxBool isPublicPrivate = false.obs;

  void toggleSwitch() {
    isPublicPrivate.value = !isPublicPrivate.value;

  }



  TextEditingController seatAvailable = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController departureDate = TextEditingController();
  TextEditingController selectedTime = TextEditingController();
  TextEditingController descriptionTextController = TextEditingController();
  TextEditingController riderOriginTextController = TextEditingController();
  TextEditingController titleTextController = TextEditingController();

  double riderOriginLat = 0.0;
  double riderOriginLong = 0.0;
  double riderDestinationLat = 0.0;
  double riderDestinationLong = 0.0;

  RxList<LocationModel> locationModelNames = <LocationModel>[].obs;

  RxBool isOriginAdded = false.obs;
  RxBool isDestinationAdded = false.obs;

  @override
  void onInit() {
    super.onInit();
    isDriver = Get.arguments;
    seatAvailable.text = numberOfSeatAvailable.toString();
    _loadLocationNames();
  }

  void _loadLocationNames() {
    try {
      final locationsName = Get.find<GetStorageService>().locationsName;
      if (locationsName.isNotEmpty) {
        List<dynamic> locationListMap = jsonDecode(locationsName);
        locationModelNames.value = locationListMap
            .map((json) => LocationModel.fromJson(json as Map<String, dynamic>))
            .toList();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  moveToSetOrigin() {
    Get.toNamed(Routes.ORIGIN, arguments: LocationValues.findRideOrigin)
        ?.then((v) {
      if (riderOriginTextController.value.text.isNotEmpty) {
        isOriginAdded.value = true;
      } else {
        isOriginAdded.value = false;
      }
      setActiveState();
    });
  }

  moveToSetDestination() {
    Get.toNamed(Routes.GROUP_DESTINATION, arguments: LocationValues.findRideDestination)
        ?.then(
      (value) {
        if (riderOriginTextController.value.text.isNotEmpty) {
          isDestinationAdded.value = true;
        } else {
          isDestinationAdded.value = false;
        }
        setActiveState();
      },
    );
  }


  void moveToMatchingRides() {
    _storePreviousLocations();
    // Get.toNamed(Routes.MATCHING_RIDES, arguments: rideDetails.toJson());
    debugPrint("***********************");
    // Get.toNamed(Routes.EVENT_DETAILS, arguments:false);
  }

  void _storePreviousLocations() {
    if (riderOriginTextController.text.isNotEmpty && titleTextController.text.isNotEmpty) {
      addLocationModel(
        riderOriginLat: riderOriginLat,
        riderOriginLong: riderOriginLong,
        riderOriginTextController: riderOriginTextController,
        riderDestinationLat: riderDestinationLat,
        riderDestinationLong: riderDestinationLong,
        riderDestinationTextController: titleTextController,
      );
    }
  }

  bool isDuplicate(LocationModel newLocationModel) {
    return locationModelNames.any((location) =>
        location.originLocation!.lat == newLocationModel.originLocation!.lat &&
        location.originLocation!.long ==
            newLocationModel.originLocation!.long &&
        location.originLocation!.nameOfLocation ==
            newLocationModel.originLocation!.nameOfLocation &&
        location.destinationLocation!.lat ==
            newLocationModel.destinationLocation!.lat &&
        location.destinationLocation!.long ==
            newLocationModel.destinationLocation!.long &&
        location.destinationLocation!.nameOfLocation ==
            newLocationModel.destinationLocation!.nameOfLocation);
  }

  void addLocationModel({
    required double riderOriginLat,
    required double riderOriginLong,
    required TextEditingController riderOriginTextController,
    required double riderDestinationLat,
    required double riderDestinationLong,
    required TextEditingController riderDestinationTextController,
  }) {
    final newLocationModel = LocationModel(
      originLocation: LocationModelOriginLocation(
        lat: riderOriginLat,
        long: riderOriginLong,
        nameOfLocation: riderOriginTextController.text,
      ),
      destinationLocation: LocationModelDestinationLocation(
        lat: riderDestinationLat,
        long: riderDestinationLong,
        nameOfLocation: riderDestinationTextController.text,
      ),
    );

    if (!isDuplicate(newLocationModel)) {
      locationModelNames.add(newLocationModel);
      Get.find<GetStorageService>().locationsName =
          jsonEncode(locationModelNames);
    } else {
      debugPrint("This location model already exists in the list.");
    }
  }

  void setLocation(int index) {
    final location = locationModelNames[index];
    riderOriginLat = location.originLocation!.lat ?? 0.0;
    riderOriginLong = location.originLocation!.long ?? 0.0;
    riderOriginTextController.text =
        location.originLocation!.nameOfLocation ?? "";

    riderDestinationLat = location.destinationLocation!.lat ?? 0.0;
    riderDestinationLong = location.destinationLocation!.long ?? 0.0;
    titleTextController.text =
        location.destinationLocation!.nameOfLocation ?? "";

    // Update flags
    isOriginAdded.value = riderOriginTextController.text.isNotEmpty;
    isDestinationAdded.value = titleTextController.text.isNotEmpty;

    setActiveState();
  }

  Future<void> setDate(BuildContext context) async {
    DateTime? pickedDate = Platform.isIOS
        ? await DialogHelper.cupertinoDatePicker(context, DateTime.now(),
            DateTime.now().add(const Duration(days: 90)), DateTime.now())
        : await showDatePicker(
            context: context,
            builder: _pickerTheme,
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(const Duration(days: 90)),
            initialDate: DateTime.now(),
          );

    if (pickedDate != null) {
      date.text = pickedDate.toIso8601String();
      departureDate.text = "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
      selectedTime.clear();
      setActiveState();
    }
  }

  Future<void> setTime(BuildContext context) async {
    final now = TimeOfDay.now();
    TimeOfDay? pickedTime = Platform.isIOS
        ? await DialogHelper.cupertinoTimePicker(context)
        : await showTimePicker(
            context: context,
            builder: _pickerTheme,
            initialTime: TimeOfDay(
              hour: (now.hour + 1) % 24,
              minute: now.minute,
            ),
            initialEntryMode: TimePickerEntryMode.dial,
          );
    if (pickedTime != null) {
      final localizations = MaterialLocalizations.of(context);
      final formattedTime = localizations.formatTimeOfDay(pickedTime,
          alwaysUse24HourFormat: false);
      if (date.text.isNotEmpty) {
        if (DateTimeUtils.isToday(DateTime.parse(date.text))) {
          if (DateTimeUtils.isAfterOneHourTime(formattedTime)) {
            selectedTime.text = formattedTime;
          } else {
            showMySnackbar(msg: LocaleKeys.app_select_valid_time.tr);
            selectedTime.clear();
          }
        } else {
          selectedTime.text = formattedTime;
        }
      } else {
        showMySnackbar(msg: LocaleKeys.app_select_valid_date.tr);
      }
    }
    setActiveState();
  }

  void setActiveState() {
    final seatText = seatAvailable.value.text;

    isActive.value = titleTextController.text.isNotEmpty && riderOriginTextController.text.isNotEmpty && selectedTime.text.isNotEmpty && (seatText.isNotEmpty &&
            int.tryParse(seatText) != null &&
            int.parse(seatText) >= 1 &&
            int.parse(seatText) < 101);
  }

  String? seatsValidator(String? value) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.app_pls_enter_value.tr;
    }

    final parsedValue = int.tryParse(value);
    if (parsedValue == null || parsedValue < 1 || parsedValue > 100) {
      return LocaleKeys.app_only_book_up_to_100_seats.tr;
    }
    return null;
  }

  Widget _pickerTheme(BuildContext context, Widget? child) {
    return Theme(
      data: ThemeData(
        primaryColor: Get.find<HomeController>().isPinkModeOn.value
            ? ColorUtil.kPrimaryPinkMode
            : ColorUtil.kPrimary01,
        colorScheme: ColorScheme.light(
          primary: Get.find<HomeController>().isPinkModeOn.value
              ? ColorUtil.kPrimaryPinkMode
              : ColorUtil.kPrimary01,
          surface: Colors.white,
          onPrimary: Colors.white,
          secondary: Get.find<HomeController>().isPinkModeOn.value
              ? ColorUtil.kPrimaryPinkMode
              : ColorUtil.kPrimary01,
        ),
        dialogBackgroundColor: Colors.white,
      ),
      child: child!,
    );
  }

  removeOrigin() {
    riderOriginTextController.clear();
    isOriginAdded.value = false;
    riderOriginLat = 0.0;
    riderOriginLong = 0.0;
  }

  removeDestination() {
    riderOriginTextController.clear();
    isDestinationAdded.value = false;
    riderDestinationLat = 0.0;
    riderDestinationLong = 0.0;
  }



  apiPublishEvent(){



    Map<String,dynamic>   eventBody  = {

        "ridesDetails": {
          "origin": {
            "name": titleTextController.text,
            "longitude": -114.0718831,
            "latitude": 51.04473309999999,
            "originDestinationFair": 324
          },
          "destination": {
            "name": titleTextController.text,
            "longitude": -79.3831843,
            "latitude": 43.653226
          },
          "stops": [
            {
              "name": "",
              "longitude": 0,
              "latitude": 0,
              "originToStopFair": "0",
              "stopToStopFair": "0",
              "stopTodestinationFair": "0"
            },
            {
              "name": "",
              "longitude": 0,
              "latitude": 0,
              "originToStopFair": "0",
              "stopToStopFair": "0",
              "stopTodestinationFair": "0"
            }
          ],
          "recurringTrip": {
            "recurringTripDays": []
          },
          "tripType": "oneTime",
          "date": "2025-06-17",
          "time": "2025-06-17T07:10:00.000Z",
          "description": "",
          "returnTrip": {
            "isReturnTrip": false,
            "returnDate": "",
            "returnTime": ""
          },
          "seatAvailable": 1,
          "preferences": {
            "luggageType": "NO",
            "other": {
              "AppreciatesConversation": false,
              "EnjoysMusic": false,
              "CoolingOrHeating": false,
              "SmokeFree": false,
              "PetFriendly": false,
              "WinterTires": false,
              "BabySeat": false,
              "HeatedSeats": false
            }
          }
      }
    };
  }
}

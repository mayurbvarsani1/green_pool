import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/data/chat_arg.dart';
import 'package:green_pool/app/data/matching_rides_model.dart';
import 'package:green_pool/app/routes/app_pages.dart';
import 'package:green_pool/app/services/snackbar.dart';

import '../../../../generated/locales.g.dart';
import '../../../services/dio/api_service.dart';
import '../../../services/storage.dart';
import '../../../utils/date_utils.dart';

class DriverDetailsController extends GetxController {
  var matchingRidesModelData = MatchingRidesModelData().obs;
  Map<String, dynamic>? rideDetails;
  String driverRideId = '';
  String minStopDistance = '';
  int pricePerSeat = 0;
  RxBool messageBtnLoading = false.obs;
  String date = "";
  String time = "";

  @override
  void onInit() {
    super.onInit();
    pricePerSeat = Get.arguments['pricePerSeat'];
    rideDetails = Get.arguments['rideDetails'];
    rideDetails!['ridesDetails']!['price'] = Get.arguments["price"];
    driverRideId = Get.arguments['driverRideId'];
    matchingRidesModelData.value = Get.arguments['matchingRidesmodel'];
    minStopDistance = Get.arguments['distance'];
    //the date and time of rider with which search was initiated
    date = rideDetails!['ridesDetails']!['date'];
    time = rideDetails!['ridesDetails']!['time'];
    // somethingElseController.addListener(() {
    //   isTextNotEmpty.value = somethingElseController.text.trim().isNotEmpty;
    // });
  }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  @override
  void onClose() {
    rideDetails!['ridesDetails']!['date'] = date;
    rideDetails!['ridesDetails']!['time'] = time;
    super.onClose();
  }

  isUserLoggedIn(String value) {
    if (Get.find<GetStorageService>().isLoggedIn) {
      if (Get.find<GetStorageService>().profileStatus == true) {
        if (value == "chat") {
          chatWithDriver();
        } else {
          moveToPayment();
        }
      } else {
        Get.toNamed(Routes.RIDER_PROFILE_SETUP, arguments: {
          "fromNavBar": false,
          "fullName": Get.find<GetStorageService>().getUserName,
          "findRideModel": rideDetails
        });
      }
    } else {
      Get.toNamed(Routes.CREATE_ACCOUNT, arguments: {
        'isDriver': false,
        'fromNavBar': false,
        'findRideModel': rideDetails,
      });
    }
  }

  void setPendingData() {
    //if rider has not added the data while searching then set the data according to the driver
    rideDetails?["ridesDetails"]["date"] =
        matchingRidesModelData.value.time.toString().split("T").first;
    rideDetails?["ridesDetails"]["time"] = matchingRidesModelData.value.time;
    if (rideDetails?["ridesDetails"]["origin"]["name"] == "") {
      rideDetails?["ridesDetails"]["origin"]["name"] =
          matchingRidesModelData.value.matchedOriginLocation?.name;
      rideDetails?["ridesDetails"]["origin"]["longitude"] =
          matchingRidesModelData
              .value.matchedOriginLocation?.coordinates?.first;
      rideDetails?["ridesDetails"]["origin"]["latitude"] =
          matchingRidesModelData.value.matchedOriginLocation?.coordinates?.last;
    }
    if (rideDetails?["ridesDetails"]["destination"]["name"] == "") {
      rideDetails?["ridesDetails"]["destination"]["name"] =
          matchingRidesModelData.value.matchedDestinationLocation?.name;
      rideDetails?["ridesDetails"]["destination"]["longitude"] =
          matchingRidesModelData
              .value.matchedDestinationLocation?.coordinates?.first;
      rideDetails?["ridesDetails"]["destination"]["latitude"] =
          matchingRidesModelData
              .value.matchedDestinationLocation?.coordinates?.last;
    }
  }

  moveToPayment() {
    setPendingData();

    final Map<String, dynamic> rideData = {
      "ridesDetails": rideDetails!["ridesDetails"],
      "driverRideId": driverRideId,
      "distance": minStopDistance,
    };
    Get.toNamed(Routes.PAYMENT,
        arguments: {"rideData": rideData, "pricePerSeat": pricePerSeat});
  }

  Future<void> chatWithDriver() async {
    setPendingData();
    try {
      messageBtnLoading.value = true;
      final res = await APIManager.postChatRoomId(
          receiverId:
              matchingRidesModelData.value.driverDetails?.first?.Id ?? "",
          body: {
            "driverRideId": driverRideId,
            "seatsRequired": rideDetails!['ridesDetails']!["seatAvailable"],
            "riderRideId": "",
            "ridesDetails": rideDetails!['ridesDetails'],
            "distance": minStopDistance
          });
      Get.toNamed(Routes.CHAT_PAGE,
          arguments: ChatArg(
              chatRoomId: res.data["data"]["chatRoomId"] ?? "",
              deleteUpdateTime: res.data["data"]["deleteUpdateTime"] ?? "",
              id: matchingRidesModelData.value.driverDetails?.first?.Id,
              driverRideId: driverRideId,
              name: matchingRidesModelData.value.driverDetails?.first?.fullName,
              image: matchingRidesModelData
                  .value.driverDetails?.first?.profilePic?.url,
              origin:
                  matchingRidesModelData.value.origin?.name?.split(',').first ??
                      "City",
              destination: matchingRidesModelData.value.destination?.name
                      ?.split(',')
                      .first ??
                  "City",
              date: DateTimeUtils.formatDate(DateTime.parse(
                  matchingRidesModelData.value.date ??
                      LocaleKeys.app_defaultDate.tr))));
      messageBtnLoading.value = false;
    } catch (e) {
      try {
        Get.toNamed(Routes.CHAT_PAGE,
            arguments: ChatArg(
                chatRoomId: "",
                id: matchingRidesModelData.value.driverDetails?.first?.Id,
                deleteUpdateTime: "",
                driverRideId: driverRideId,
                name:
                    matchingRidesModelData.value.driverDetails?.first?.fullName,
                image: matchingRidesModelData
                    .value.driverDetails?.first?.profilePic?.url,
                origin: matchingRidesModelData.value.origin?.name
                        ?.split(',')
                        .first ??
                    "City",
                destination: matchingRidesModelData.value.destination?.name
                        ?.split(',')
                        .first ??
                    "City",
                date: DateTimeUtils.formatDate(DateTime.parse(
                    matchingRidesModelData.value.date ??
                        LocaleKeys.app_defaultDate.tr))));
        messageBtnLoading.value = false;
      } catch (e) {
        debugPrint(e.toString());
      }
    }
  }

  void toPrevRides(MatchingRidesModelDataDriverDetails? driverDetails) {
    Get.toNamed(Routes.PREVIOUS_RIDES, arguments: {
      "driverName": driverDetails?.fullName,
      "driverId": driverDetails?.Id
    });
  }


  /// Block & Report Part
  TextEditingController somethingElseController = TextEditingController();
  TextEditingController explainIssueController = TextEditingController();

  RxBool isTextNotEmpty = false.obs;
initReport(){
  somethingElseController.clear();
  explainIssueController.clear();
  selectedReason = "";
}
  String selectedReason = "";
  List<Map<String, String>> reportReasons = [
    {'label': LocaleKeys.app_abusiveOrOffensive.tr},
    {'label': LocaleKeys.app_spammingOrScamming.tr},
    {'label': LocaleKeys.app_unresponsiveToBookingOrMessages.tr},
    {'label': LocaleKeys.app_requestingOtherPayment.tr},
  ];

  String selectedBlockInformation = "";

  List<Map<String, String>> blockInformationList = [
    {'text': LocaleKeys.app_userNotNotified.tr},
    {'text': LocaleKeys.app_userCantMessageOrBook.tr},
    {'text': LocaleKeys.app_youCanUnblockAnytime.tr},
  ];


  addReportAPI({String? controller}) async {
    try {
      final res = await APIManager.addReportApi(body: {
        "rideId": matchingRidesModelData.value.Id,
        "reason": selectedReason.tr,
        "details": controller
      });
      debugPrint("selectedReason${res.data['status']}");
      debugPrint("res.data['status']=>${res.data['status']}");
      Get.back();
      showMySnackbar(msg: res.data["message"]);

      // if(res.data['status'].toString() == 'true'){
      //   Get.back();
      // }else{
      //   Get.back();
      // }
    }
    catch(e){
      debugPrint(e.toString());
    }
  }



  blockAPI() async {
    try {
      final res = await APIManager.userBlockApi(body: {
        "blockUserId": matchingRidesModelData.value.Id,
        "details": "details",
        "isBlocked": true
        // "isBlocked": true
      });
      Get.back();
      showMySnackbar(msg: res.data["message"]);
      debugPrint("res.data123=>${res.data['status']}");

      // if(res.data['status'].toString() == 'true'){
      //   Get.back();
      //
      // }{
      //   Get.back();
      //
      // }
    }
    catch(e){
      debugPrint(e.toString());
    }
  }
}

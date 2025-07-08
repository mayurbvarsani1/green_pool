import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/data/find_ride_model.dart';
import 'package:green_pool/app/data/location_model.dart';
import 'package:green_pool/app/modules/home/controllers/home_controller.dart';
import 'package:green_pool/app/services/colors.dart';
import 'package:green_pool/app/services/dio/api_service.dart';
import 'package:green_pool/app/services/snackbar.dart';
import 'package:green_pool/generated/locales.g.dart';
import 'package:intl/intl.dart';

import '../../../../data/chat_arg.dart';
import '../../../../data/event_detail_model.dart';
import '../../../../data/rider_send_request_model.dart';
import '../../../../routes/app_pages.dart';
import '../../../../services/dialog_helper.dart';
import '../../../../services/storage.dart';
import '../../../../utils/date_utils.dart';
import '../../../origin/controllers/origin_controller.dart';


class EventDetailsController extends GetxController {
  RxBool isActive = false.obs;


  String formatDateTime(DateTime utcDateTime) {
    return DateFormat("EEEE, MMMM d, y · hh:mm a").format(utcDateTime.toLocal());
  }

  String formatDateAndTime(dynamic date, dynamic time) {
    final parsedTime = time is DateTime ? time : DateTime.parse(time.toString()).toLocal();
    final dateFormatted = DateFormat('dd MMMM yyyy, hh:mm:a').format(parsedTime);
    return dateFormatted;
  }

  @override
  void onInit() {
    super.onInit();
      eventDetailAPI;
  }

  RxBool isLoad = true.obs;
  Rxn<EventDetailsModel> eventDetailsData = Rxn<EventDetailsModel>();

  // EventDetailsModel?  eventDetailsData;
  eventDetailAPI(String eventId) async {
    debugPrint("eventId=>${eventId}");
    if (eventId.isNotEmpty) {

      try {
        eventDetailsData.value  = null;
        isLoad.value = true;
        final response = await APIManager.getEventDetailId(eventId: eventId ?? "");
          eventDetailsData.value = EventDetailsModel.fromJson(response.data);
          if(eventDetailsData.value?.chatRoomId == null){
            final res = await APIManager.sendChatApi(body: {
              "message": "A",
              "eventId": eventId,
            });
            eventDetailsData.value?.chatRoomId = res.data["chatRoomId"];
          }
        isLoad.value = false;
      } catch (e) {
        isLoad.value = false;
        throw Exception(e);
      }
    }
  }


 jointEventAPI(String eventId) async {
    try {
      final res = await APIManager.jointEventApi(body: {"eventId" : eventId});
      showMySnackbar(msg: res.data["message"]);
      if(res.data['status'] = true){
        eventDetailAPI(eventId);

      }
    }
    catch(e){
      debugPrint(e.toString());
    }
  }

  String rideIdFromMyRides = '';

  var riderSendRequestModel = RiderSendRequestModel().obs;

  openMessage(RiderSendRequestModelData data) async {
    try {
      final res = await APIManager.postChatRoomId(
          receiverId: data.driverDetails?[0]?.Id ?? "",
          body: {
            "driverRideId": data.Id,
            "riderRideId": rideIdFromMyRides,
            "seatsRequired":
            riderSendRequestModel.value.riderRideDetails?.seatAvailable
          });
      Get.toNamed(Routes.CHAT_PAGE,
          arguments: ChatArg(
              chatRoomId: res.data["data"]["chatRoomId"] ?? "",
              deleteUpdateTime: res.data["data"]["deleteUpdateTime"] ?? "",
              id: data.driverDetails?[0]?.Id,
              name: data.driverDetails?[0]?.fullName,
              image: data.driverDetails?[0]?.profilePic?.url,
              driverRideId: data.Id,
              riderRideId: rideIdFromMyRides,
              origin: data.origin?.name?.split(',').first ?? "City",
              destination: data.destination?.name?.split(',').first ?? "City",
              date: DateTimeUtils.formatDate(
                  DateTime.parse(data.date ?? LocaleKeys.app_defaultDate.tr))));
    } catch (e) {
      Get.toNamed(Routes.CHAT_PAGE,
          arguments: ChatArg(
              chatRoomId: "",
              deleteUpdateTime: "",
              id: data.driverDetails?[0]?.Id,
              name: data.driverDetails?[0]?.fullName,
              image: data.driverDetails?[0]?.profilePic?.url,
              driverRideId: data.Id,
              riderRideId: rideIdFromMyRides,
              origin: data.origin?.name?.split(',').first ?? "City",
              destination: data.destination?.name?.split(',').first ?? "City",
              date: DateTimeUtils.formatDate(
                  DateTime.parse(data.date ?? LocaleKeys.app_defaultDate.tr))));
    }
  }


}

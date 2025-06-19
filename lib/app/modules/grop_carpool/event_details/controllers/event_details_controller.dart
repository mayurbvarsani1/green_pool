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

import '../../../../data/event_detail_model.dart';
import '../../../../routes/app_pages.dart';
import '../../../../services/dialog_helper.dart';
import '../../../../services/storage.dart';
import '../../../../utils/date_utils.dart';
import '../../../origin/controllers/origin_controller.dart';


class EventDetailsController extends GetxController {
  RxBool isActive = false.obs;


  String formatDateTime(DateTime utcDateTime) {
    DateTime dateTime = utcDateTime.toLocal(); // convert to local time
    return DateFormat("EEEE, MMMM d, y · h:mm a").format(dateTime);
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
         // eventDetailsData  =  eventDetailsModel.data;
        debugPrint("response=>${response.data}");
        debugPrint("responseStatusCode=>${response.statusCode}");
        debugPrint("eventDetailsData=>$eventDetailsData");
        // if (response.data["status"] == true) {
        //
        // } else {
        //   showMySnackbar(msg: response.data["message"].toString());
        // }
        isLoad.value = false;
      } catch (e) {
        throw Exception(e);
      }
    }
  }


}

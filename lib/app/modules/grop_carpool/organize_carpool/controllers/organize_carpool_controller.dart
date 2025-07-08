import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/data/find_ride_model.dart';
import 'package:green_pool/app/data/location_model.dart';
import 'package:green_pool/app/modules/home/controllers/home_controller.dart';
import 'package:green_pool/app/services/colors.dart';
import 'package:green_pool/app/services/snackbar.dart';
import 'package:green_pool/generated/locales.g.dart';
import 'package:intl/intl.dart';

import '../../../../data/event_list_model.dart';
import '../../../../data/message_model.dart';
import '../../../../routes/app_pages.dart';
import '../../../../services/dialog_helper.dart';
import '../../../../services/dio/api_service.dart';
import '../../../../services/storage.dart';
import '../../../../utils/date_utils.dart';
import '../../../origin/controllers/origin_controller.dart';

class OrganizeCarpoolController extends GetxController {
  bool isDriver = false;
  int numberOfSeatAvailable = 1;
  RxBool isActive = false.obs;
  RxString selectedButton = 'request'.obs;

  @override
  void onInit() {
    super.onInit();
    getEventAPI();
  }

  RxBool isSelected = true.obs;

  TextEditingController searchTextController = TextEditingController();

  void moveToMatchingRides() {
    Get.toNamed(Routes.CREATE_NEW_EVENT, arguments: false);
  }

  String formatDateAndTime(dynamic date, dynamic time) {
    final parsedTime = time is DateTime
        ? time.toLocal()
        : DateTime.parse(time.toString()).toLocal();

    final dateFormatted =
        DateFormat('dd MMMM yyyy, hh:mm:a').format(parsedTime);

    return '$dateFormatted';
  }

  final RxBool isLoad = true.obs;

  RxList<Doc> eventData = <Doc>[].obs;

  Future<void> getEventAPI({
    bool isOfferRide = false,
  }) async {
    Map<String, dynamic> queryParameters = {};

    if (searchTextController.text.isNotEmpty) {
      queryParameters["filter"] = searchTextController.text.trim();
    }

    if (isOfferRide) {
      queryParameters["myEvent"] = true;
    }

    try {
      isLoad.value = true;
      final res = await APIManager.eventList(queryParameters: queryParameters);
      final eventListModel = EventListModel.fromJson(res.data);
      eventData.value = eventListModel.data!.docs!;
      isLoad.value = false;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  var searchDebounceTimer;
  var keyboardCloseTimer;

  void onSearchTextChanged(String? value) {
    if (searchDebounceTimer != null) {
      searchDebounceTimer.cancel();
    }

    if (value!.isEmpty || value!.length >= 3) {
      searchDebounceTimer = Timer(Duration(milliseconds: 500), () async {
        await getEventAPI(isOfferRide: selectedButton.value == 'offer');
        FocusManager.instance.primaryFocus?.unfocus();
      });
    }
  }
}

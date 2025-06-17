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


class OrganizeCarpoolController extends GetxController {
  bool isDriver = false;
  int numberOfSeatAvailable = 1;
  RxBool isActive = false.obs;
  RxString selectedButton = 'request'.obs;


  RxBool isSelected = true.obs;

  TextEditingController searchTextController = TextEditingController();


  void moveToMatchingRides() {
    // final rideDetails = _getRideDetails();
    // _storePreviousLocations();
    // Get.toNamed(Routes.MATCHING_RIDES, arguments: rideDetails.toJson());
    Get.toNamed(Routes.CREATE_NEW_EVENT, arguments: false);
  }



}

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


class EventDetailsController extends GetxController {
  RxBool isActive = false.obs;
  final List<String> imageUrls = [
    'https://cdn.pixabay.com/photo/2024/05/22/20/47/doctor-8781659_1280.png',
    'https://images.pexels.com/photos/2379005/pexels-photo-2379005.jpeg',
    'https://images.pexels.com/photos/5378700/pexels-photo-5378700.jpeg',
    'https://images.pexels.com/photos/1516680/pexels-photo-1516680.jpeg',
    'https://cdn.pixabay.com/photo/2024/10/20/08/29/portrait-9134409_1280.png',

  ];

}

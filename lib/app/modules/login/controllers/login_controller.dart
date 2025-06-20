import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/routes/app_pages.dart';
import 'package:green_pool/app/services/auth.dart';

import '../../../data/find_ride_model.dart';
import '../../../data/post_ride_model.dart';
import '../../../services/snackbar.dart';
import '../../home/controllers/home_controller.dart';
import '../../verify/controllers/verify_controller.dart';

class LoginController extends GetxController {
  TextEditingController phoneNumberController = TextEditingController();
  RxBool isVisible = false.obs;
  String countryCode = "+1";
  bool isDriver = false;
  bool fromNavBar = false;
  RxBool isActive = false.obs;
  final Rx<PostRideModel> postRideModel = PostRideModel().obs;
  final Rx<FindRideModel> findRideModel = FindRideModel().obs;
  TextEditingController passwordTextController = TextEditingController();
  GlobalKey<FormState> loginKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    try {
      if (Get.find<HomeController>().findingRide.value) {
        isDriver = Get.arguments['isDriver'];
        fromNavBar = Get.arguments['fromNavBar'];
        findRideModel.value = Get.arguments['findRideModel'];
      } else {
        isDriver = Get.arguments['isDriver'];
        fromNavBar = Get.arguments['fromNavBar'];
        postRideModel.value = Get.arguments['postRideModel'];
      }
    } catch (e) {
      isDriver = Get.arguments['isDriver'];
      fromNavBar = Get.arguments['fromNavBar'];
    }
  }

  setVisible() {
    isVisible.toggle();
  }

  String? passwordValidator(String? value) {
    // Check if the value is empty
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }

    // Check if the password meets the criteria (e.g., length, complexity)
    // For example, let's enforce a minimum length of 8 characters and at least one uppercase letter, one lowercase letter, one digit, and one special character.
    final RegExp upperCaseRegExp = RegExp(r'[A-Z]');
    final RegExp lowerCaseRegExp = RegExp(r'[a-z]');
    final RegExp digitRegExp = RegExp(r'[0-9]');
    final RegExp specialCharacterRegExp = RegExp(r'[!@#\$%^&*(),.?":{}|<>]');

    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }

    if (!upperCaseRegExp.hasMatch(value)) {
      return 'Password must contain at least one uppercase letter';
    }

    if (!lowerCaseRegExp.hasMatch(value)) {
      return 'Password must contain at least one lowercase letter';
    }

    if (!digitRegExp.hasMatch(value)) {
      return 'Password must contain at least one digit';
    }

    if (!specialCharacterRegExp.hasMatch(value)) {
      return 'Password must contain at least one special character';
    }
    return null; // Return null if the value is valid
  }

  checkLogin() async {
    final isValid = loginKey.currentState!.validate();

    if (!isValid) {
      return;
    } else {
      loginKey.currentState!.save();
      await otpAuth();
    }
  }

  otpAuth() async {
    try {
      log("phone number: ${phoneNumberController.text}");
      await Get.find<AuthService>().mobileOtp(phoneno: countryCode + phoneNumberController.text);
      debugPrint("Get.find<HomeController>().findingRide.value=>${Get.find<HomeController>().findingRide.value}");
      log("Get.find<HomeController>().findingRide.value12=>${Get.find<HomeController>().findingRide.value}");
      if (Get.find<HomeController>().findingRide.value) {
        await Get.offNamed(
          Routes.VERIFY,
          arguments: {
            'isDriver': isDriver,
            'phoneNumber': countryCode + " " + phoneNumberController.value.text,
            'fromNavBar': fromNavBar,
            'findRideModel': findRideModel.value
          },
        );
      } else {
        await Get.offNamed(
          Routes.VERIFY,
          arguments: {
            'isDriver': isDriver,
            'phoneNumber': countryCode + " " + phoneNumberController.value.text,
            'fromNavBar': fromNavBar,
            'postRideModel': postRideModel.value
          },
        );
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  String? phoneNumberValidator(String? value) {
    // Check if the value is empty
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    }

    // Check if the value contains exactly 10 digits
    final RegExp phoneExp = RegExp(r'^[0-9]{10}$');
    if (!phoneExp.hasMatch(value)) {
      isActive.value = true;
      return 'Please enter a valid 10-digit phone number';
    }

    return null; // Return null if the value is valid
  }

  moveToCreateAcc() {
    if (Get.find<HomeController>().findingRide.value) {
      Get.offNamed(Routes.CREATE_ACCOUNT, arguments: {
        'isDriver': isDriver,
        'fromNavBar': fromNavBar,
        'findRideModel': findRideModel.value
      });
    } else {
      Get.offNamed(Routes.CREATE_ACCOUNT, arguments: {
        'isDriver': isDriver,
        'fromNavBar': fromNavBar,
        'postRideModel': postRideModel.value
      });
    }
  }

  void googleAuth() async {
    try {
      Get.lazyPut(() => VerifyController());
      bool isStatus = await Get.find<AuthService>().google();
      if (isStatus) {
        await Get.find<VerifyController>().loginAPI();
      }
    } catch (error) {
      log("$error");
    }
  }

  Future<void> appleAuth() async {
    try {
      Get.lazyPut(() => VerifyController());
      bool isStatus = await Get.find<AuthService>().apple();
      if (isStatus) {
        await Get.find<VerifyController>().loginAPI();
      } else {
        Get.back();
        showMySnackbar(
            msg:
                "Unable to connect to Apple services. Please try again later.");
      }
    } catch (error) {
      log("$error");
    }
  }

  Future<void> facebookAuth() async {
    try {
      Get.lazyPut(() => VerifyController());
      bool isStatus = await Get.find<AuthService>().facebook();
      if (isStatus) {
        await Get.find<VerifyController>().loginAPI();
      } else {
        Get.back();
        showMySnackbar(
            msg:
                "Unable to connect to Facebook services. Please try again later.");
      }
    } catch (e) {
      log(e.toString());
    }
  }
}

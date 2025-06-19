import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/data/find_ride_model.dart';
import 'package:green_pool/app/data/post_ride_model.dart';
import 'package:green_pool/app/modules/home/controllers/home_controller.dart';
import 'package:green_pool/app/services/snackbar.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';

import '../../../data/create_acc_data.dart';
import '../../../data/user_info_model.dart';
import '../../../routes/app_pages.dart';
import '../../../services/auth.dart';
import '../../../services/dio/api_service.dart';
import '../../../services/dio/exceptions.dart';
import '../../../services/storage.dart';

class VerifyController extends GetxController {
  final otpController = TextEditingController();
  CreateAccData createAccData = CreateAccData();
  final auth = FirebaseAuthenticationService();
  bool isDriver = false;
  bool fromNavBar = false;
  String fullName = '';
  String phoneNumber = '';
  final Rx<PostRideModel> postRideModel = PostRideModel().obs;
  final Rx<FindRideModel> findRideModel = FindRideModel().obs;
  RxInt seconds = 30.obs;
  RxInt buttonSeconds = 5.obs;
  RxBool isActive = false.obs;
  RxBool isButtonLoading = false.obs;
  late Timer timer;

  @override
  void onInit() {
    super.onInit();
    try {
      if (Get.find<HomeController>().findingRide.value) {
        isDriver = Get.arguments['isDriver'];
        phoneNumber = Get.arguments['phoneNumber'];
        fromNavBar = Get.arguments['fromNavBar'];
        findRideModel.value = Get.arguments['findRideModel'];
        fullName = Get.arguments['fullName'];
      } else {
        isDriver = Get.arguments['isDriver'];
        phoneNumber = Get.arguments['phoneNumber'];
        fromNavBar = Get.arguments['fromNavBar'];
        postRideModel.value = Get.arguments['postRideModel'];
        fullName = Get.arguments['fullName'];
      }
    } catch (e) {
      //when user comes from nav bar
      isDriver = Get.arguments['isDriver'];
      phoneNumber = Get.arguments['phoneNumber'] ?? "";
      fromNavBar = Get.arguments['fromNavBar'];
    }
    startTimer();
    startButtonTimer();
  }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  // @override
  // void onClose() {
  //   super.onClose();
  // }

  verifyOTP() async {
    if (otpController.text.isEmpty || otpController.value.text == "") {
      return showMySnackbar(
          msg: "Please enter the OTP. The field cannot be empty.");
    }
    try {
      isButtonLoading.value = true;
      await Future.delayed(const Duration(seconds: 2));
      bool isStatus = await Get.find<AuthService>()
          .verifyMobileOtp(otp: otpController.text);
      print("isStatus=>$isStatus");
      if (isStatus) {
        await loginAPI();
      } else {
        showMySnackbar(msg: "Error saving user data");
      }
      isButtonLoading.value = false;
    } catch (e) {
      debugPrint('otp error: $e');
    } finally {
      isButtonLoading.value = false;
    }
  }

  otpAuth() async {
    try {
      await Get.find<AuthService>().mobileOtp(phoneno: phoneNumber);
      seconds.value = 30;
      startTimer();
    } catch (e) {
      debugPrint("ERROR: $e");
    }
  }

  startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (seconds.value > 0) {
        seconds.value--;
      } else {
        timer.cancel();
      }
    });
  }

  startButtonTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (buttonSeconds.value > 1) {
        buttonSeconds.value--;
      } else {
        timer.cancel();
        isActive.value = true;
      }
    });
  }

  Future<void> loginAPI() async {
    final storageService = Get.find<GetStorageService>();
    final homeController = Get.find<HomeController>();
    final authService = Get.find<AuthService>();
    if (fullName != '') {
      //USER CREATING NEW ACC
      try {
        final response =
            await APIManager.postRegisterAcc(body: {"fullName": fullName});
        // print("response=>${response}");
        // print("response=>${response.data['status']}");
        // print("response=>${response.statusCode}");
        if (response.data['status'] == true) {
          final userInfo = UserInfoModel.fromJson(response.data);
          _handleNewUser(userInfo, authService, homeController, storageService);
        } else {
          Get.back();
          storageService.profileStatus = false;
          storageService.isLoggedIn = false;
          storageService.encjwToken = "";
          storageService.setFirebaseUid = "";
          storageService.setUserName = "";
          storageService.emailId = "";
          storageService.phoneNumber = "";
          Get.find<AuthService>().logOutUser();
          showMySnackbar(msg: response.data['message'].toString() ?? "");
        }
      } catch (e) {
        _handleError(e);
      }
    } else {
      //USER LOGIN
      try {
        final response = await APIManager.postLogin();
        // print("response=>${response}");
        // print("response=>${response.data['status']}");
        // print("response=>${response.statusCode}");

        if (response.data['status'] == true) {
          final userInfo = UserInfoModel.fromJson(response.data);
          _handleUserLogin(
              userInfo, authService, homeController, storageService);
        } else {
          Get.back();
          storageService.profileStatus = false;
          storageService.isLoggedIn = false;
          storageService.encjwToken = "";
          storageService.setFirebaseUid = "";
          storageService.setUserName = "";
          storageService.emailId = "";
          storageService.phoneNumber = "";
          Get.find<AuthService>().logOutUser();
          showMySnackbar(msg: response.data['message'].toString() ?? "");
        }
      } catch (e) {
        _handleError(e);
      }
    }
  }

  Future<void> _handleNewUser(UserInfoModel userInfo, AuthService authService,
      HomeController homeController, GetStorageService storageService) async {
    //if profile status is true then the user had previously logged in and already has an acc
    if (userInfo.data!.profileStatus!) {
      // Set user information in storage service
      storageService.setUserAppId = userInfo.data?.Id;
      storageService.setUserName = userInfo.data?.fullName ?? "";
      storageService.profilePicUrl = userInfo.data?.profilePic?.url ?? "";
      storageService.isPinkMode = userInfo.data?.pinkMode ?? false;

      // Update UI elements
      homeController.isPinkModeOn.value = userInfo.data?.pinkMode ?? false;

      if (fromNavBar) {
        //if user is coming from nav bar then they should go back to bottom nav page
        storageService.profileStatus = true;
        storageService.isLoggedIn = true;
        Get.offAllNamed(Routes.BOTTOM_NAVIGATION);
        showMySnackbar(msg: "You are now logged in!");
        await homeController.userInfoAPI();
      } else {
        //if the user is trying to post or find a ride then they should be logged in and redirected to respective pages with data
        try {
          if (homeController.findingRide.value) {
            //if the user is finding
            storageService.isLoggedIn = true;
            storageService.profileStatus = true;
            Get.back();
            showMySnackbar(msg: "You are now logged in!");
            await homeController.userInfoAPI();
          } else {
            //if the user is posting
            if (userInfo.data!.vehicleStatus!) {
              //if they have filled then proceed to post ride step 2
              storageService.isLoggedIn = true;
              storageService.profileStatus = true;
              storageService.setDriver = true;
              Get.back();
              // Get.offNamed(Routes.POST_RIDE_STEP_TWO, arguments: postRideModel.value);
              showMySnackbar(msg: "You are now logged in!");
              await homeController.userInfoAPI();
            } else {
              //if not then redirect to vehicle details page
              storageService.isLoggedIn = true;
              storageService.profileStatus = true;
              Get.toNamed(Routes.VEHICLE_SETUP, arguments: postRideModel.value);
              showMySnackbar(msg: "To proceed please fill in vehicle details");
            }
          }
        } catch (e) {
          throw Exception(e.toString());
        }
      }
    } else {
      //check if the user is creating acc from navBar
      if (fromNavBar) {
        //user wont have post/find ride data
        Get.offNamed(Routes.VERIFICATION_DONE, arguments: {
          'fromNavBar': fromNavBar,
          'isDriver': false,
          'fullName': fullName
        });
      } else {
        //user will have post/find ride data which needs to be transferred
        //check if driver or rider
        if (homeController.findingRide.value) {
          //rider
          Get.offNamed(Routes.VERIFICATION_DONE, arguments: {
            'fromNavBar': false,
            'findRideModel': findRideModel.value,
            'isDriver': false,
            'fullName': fullName
          });
        } else {
          //driver
          Get.offNamed(Routes.VERIFICATION_DONE, arguments: {
            'fromNavBar': false,
            'postRideModel': postRideModel.value,
            'isDriver': true,
            'fullName': fullName
          });
        }
      }
    }
  }

  Future<void> _handleUserLogin(UserInfoModel userInfo, AuthService authService,
      HomeController homeController, GetStorageService storageService) async {
    //if profile status is false then this is a new user and needs to create a new acc
    if (userInfo.data!.profileStatus!) {
      // Set user information in storage service
      storageService.setUserAppId = userInfo.data?.Id;
      storageService.setUserName = userInfo.data?.fullName ?? "";
      storageService.profilePicUrl = userInfo.data?.profilePic?.url ?? "";
      storageService.isPinkMode = userInfo.data?.pinkMode ?? false;

      // Update UI elements
      homeController.isPinkModeOn.value = userInfo.data?.pinkMode ?? false;

      //if the user is trying to login from nav bar
      if (fromNavBar) {
        storageService.profileStatus = true;
        storageService.isLoggedIn = true;
        Get.offAllNamed(Routes.BOTTOM_NAVIGATION);
        showMySnackbar(msg: 'Login Successful');
        await homeController.userInfoAPI();
      } else {
        //check if the user is driver or rider
        if (homeController.findingRide.value) {
          //user is rider
          storageService.isLoggedIn = true;
          storageService.profileStatus = true;
          Get.back();
          showMySnackbar(msg: "Successfully logged in");
          await homeController.userInfoAPI();
        } else {
          //user is driver
          //if the user is driver then check if previously they have filled vehicle details
          if (userInfo.data!.vehicleStatus!) {
            //if they have filled then proceed to post ride step 2
            storageService.isLoggedIn = true;
            storageService.profileStatus = true;
            storageService.setDriver = true;
            Get.back();
            // Get.offNamed(Routes.POST_RIDE_STEP_TWO, arguments: postRideModel.value);
            showMySnackbar(msg: "Successfully logged in");
            await homeController.userInfoAPI();
          } else {
            //if not then redirect to vehicle details page
            storageService.isLoggedIn = true;
            storageService.profileStatus = true;
            Get.offNamed(Routes.VEHICLE_SETUP, arguments: postRideModel.value);
            showMySnackbar(msg: "To proceed please fill in vehicle details");
          }
        }
      }
    } else {
      //redirecting to Profile details page
      if (fromNavBar) {
        //user wont have post/find ride data
        Get.offNamed(Routes.VERIFICATION_DONE, arguments: {
          'fromNavBar': fromNavBar,
          'isDriver': false,
          'fullName': fullName
        });
      } else {
        //user will have post/find ride data which needs to be transferred
        //check if driver or rider
        if (homeController.findingRide.value) {
          //rider
          Get.offNamed(Routes.VERIFICATION_DONE, arguments: {
            'fromNavBar': false,
            'findRideModel': findRideModel.value,
            'isDriver': false,
            'fullName': fullName
          });
        } else {
          //driver
          Get.offNamed(Routes.VERIFICATION_DONE, arguments: {
            'fromNavBar': false,
            'postRideModel': postRideModel.value,
            'isDriver': true,
            'fullName': fullName
          });
        }
      }
    }
  }

  Future<void> _handleError(dynamic e) async {
    try {
      final errorMessage =
          DioExceptions.fromDioError(e as DioException).message;

      if (errorMessage == "User doesn't exist. Please create account" ||
          errorMessage == "User doesn't exist anymore") {
        await _navigateToProfileSetup();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> _navigateToProfileSetup() async {
    if (fromNavBar) {
      Get.toNamed(Routes.RIDER_PROFILE_SETUP, arguments: false);
    } else {
      if (Get.find<HomeController>().findingRide.value) {
        Get.toNamed(Routes.RIDER_PROFILE_SETUP, arguments: {
          "fromNavBar": fromNavBar,
          "findRideModel": findRideModel.value,
        });
      } else {
        Get.toNamed(Routes.PROFILE_SETUP, arguments: {
          "fromNavBar": fromNavBar,
          "postRideModel": postRideModel.value,
        });
      }
    }
  }
}

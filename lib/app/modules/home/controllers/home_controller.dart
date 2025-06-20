import 'dart:convert';
import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:green_pool/app/modules/home/views/noti_bottomsheet.dart';
import 'package:green_pool/app/modules/home/views/permissions_location.dart';
import 'package:green_pool/app/services/dialog_helper.dart';
import 'package:green_pool/app/services/location_service.dart';
import 'package:green_pool/app/services/push_notification_service.dart';
import 'package:green_pool/app/services/storage.dart';
import 'package:green_pool/app/services/version_k.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:green_pool/app/constants/image_constant.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../../../../generated/locales.g.dart';
import '../../../data/user_info_model.dart';
import '../../../routes/app_pages.dart';
import '../../../services/colors.dart';
import '../../../services/dio/api_service.dart';
import '../../../services/snackbar.dart';
import '../../../services/text_style_util.dart';

class HomeController extends GetxController with Versionk {
  final RxInt selectedIndex = 0.obs;
  final PageController pageController = PageController();
  final RxBool findingRide = false.obs;
  RxDouble latitude = 0.0.obs;
  RxDouble longitude = 0.0.obs;
  var userInfo = UserInfoModel().obs;
  RxString welcomeText = LocaleKeys.app_welcome.tr.obs;
  RxBool isPinkModeOn = false.obs;
  RxBool canPop = false.obs;
  final RxBool newMsgReceived = false.obs;
  final LocationService locationService = LocationService();
  RxInt reqsCount = 0.obs;
  RxInt totUnreadMsgs = 0.obs;

  void changeTabIndex(int index) {
    debugPrint("---------");
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 1),
      curve: Curves.easeIn,
    );
    selectedIndex.value = index;
  }

  @override
  void onInit() {
    super.onInit();
    initializeData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  Future<void> initializeData() async {
    final storageService = Get.find<GetStorageService>();

    try {
      if (storageService.isLoggedIn) {
        //change this condition after one update because it will always imply c.v->1.0.11
        if (storageService.getUserName != "" ||
            storageService.vehicleImageUrl == "") {
          await userInfoAPI();
        }
        isPinkModeOn.value = storageService.isPinkMode;
        await onChangeLocation();
        await fetchCount();
        await handleNewUpdate();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> onChangeLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      debugPrint("Location permission not granted. Skipping onChangeLocation.");
    } else {
      latitude.value = await locationService.getLatitude();
      longitude.value = await locationService.getLongitude();

      const LocationSettings locationSettings = LocationSettings(
          accuracy: LocationAccuracy.bestForNavigation, distanceFilter: 100);
      Geolocator.getPositionStream(locationSettings: locationSettings)
          .listen((Position? position) async {
        if (position != null) {
          DatabaseReference databaseReference =
              FirebaseDatabase.instance.ref().child('locations');
          databaseReference
              .child(Get.find<GetStorageService>().getUserAppId ?? "")
              .set({
            'latitude': position.latitude,
            'longitude': position.longitude,
            'heading': position.heading
          });
        }
      });
    }
  }

  Future<void> fetchCount() async {
    if (Get.find<GetStorageService>().isLoggedIn) {
      await getReqsCount();
      await getUnreadCount();
    }
  }

  userInfoAPI() async {
    final storageService = Get.find<GetStorageService>();

    if (storageService.isLoggedIn == true) {
      try {
        final response = await APIManager.getUserByID();
        var data = jsonDecode(response.toString());
        userInfo.value = UserInfoModel.fromJson(data);

        // Store values locally
        storageService.assignLocally(userInfo.value);
        storageService.assignVehicleDetails(userInfo.value);

        // Update the pink mode status
        isPinkModeOn.value = storageService.isPinkMode;

        PushNotificationService.subFcm("${userInfo.value.data?.Id}");

        //1. Handle Location Permission First
        if (!Get.find<GetStorageService>().hasTappedAllowLocation) {
          Get.to(() => const PermissionsLocation());
          return Future.error('Location services are disabled.');
        }

        //2. Start location tracking if permission is granted
        onChangeLocation();

        //3. Prompt for Notification Permission (only after location permission is resolved)
        await promptNotificationPermission();

        //4. Setup notifications
        setupMessage();

        debugPrint(storageService.encjwToken);
      } catch (e) {
        debugPrint(e.toString());
      }
      log("User info API called");
    } else {
      log("User not logged in");
    }
  }

  setupMessage() {
    PushNotificationService().setupInteractedMessage();
  }

  Future<void> promptNotificationPermission() async {
    if (!Get.find<GetStorageService>().hasTappedAllowNotification) {
      bool isNotificationDenied = await Permission.notification.isDenied;
      if (isNotificationDenied) {
        Get.bottomSheet(const NotificationBottomSheet());
      }
    }
  }

  Future<Position> determinePosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        await promptNotificationPermission();
        return Future.error('Location permission denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      showMySnackbar(msg: "Please enable location from settings");
      return Future.error(
          'Location permissions are permanently denied, cannot request permissions.');
    }

    await promptNotificationPermission();

    return await Geolocator.getCurrentPosition();
  }

  onTapBottomNavigation(index) {
    final storageService = Get.find<GetStorageService>();

    if (storageService.isLoggedIn) {
      debugPrint("storageService.isLoggedIn=>${storageService.isLoggedIn}");
      debugPrint("storageService.profileStatus${storageService.profileStatus}");
      if (storageService.profileStatus) {
        final isUserSuspended = Get.find<GetStorageService>().accSuspended;
        if (isUserSuspended && (index == 1 || index == 2)) {
          DialogHelper.accSuspendedDialog(() {
            Get.back();
            changeTabIndex(3);
            Get.toNamed(Routes.HELP_SUPPORT);
          });
        } else {
          changeTabIndex(index);
          userInfo.refresh();
        }
      } else {
        if (index != 0) {
          Get.toNamed(Routes.RIDER_PROFILE_SETUP,
              arguments: {"fromNavBar": true, "fullName": ""});
          showMySnackbar(msg: LocaleKeys.app_pleaseCompleteProfileSetup.tr);
        }
      }
    } else {
      if (index != 0) {
        Get.toNamed(Routes.LOGIN,
            arguments: {'isDriver': false, 'fromNavBar': true});
      }
    }
  }

  Future<void> getReqsCount() async {
    try {
      final res = await APIManager.getUnreadCount();
      reqsCount.value = res.data['data']['finalCount'];
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }

  Future<void> getUnreadCount() async {
    var chatList = [].obs;
    try {
      final resp = await APIManager.getChatList();
      chatList.value = resp.data['chatRoomIds'];

      totUnreadMsgs.value = chatList.fold<int>(
        0,
        (sum, item) => sum + (item['unReadCount'] as int? ?? 0),
      );
    } catch (e) {
      debugPrint("Error fetching chat list: ${e.toString()}");
    }
  }

  List<Map<String, dynamic>> get navItemsData => [
        {
          "activeIcon": SvgPicture.asset(
            ImageConstant.svgNavHomeFilled,
            colorFilter: ColorFilter.mode(
              Get.find<GetStorageService>().isPinkMode
                  ? ColorUtil.kPrimary3PinkMode
                  : ColorUtil.kSecondary01,
              BlendMode.srcIn,
            ),
          ),
          "icon": SvgPicture.asset(ImageConstant.svgNavHome),
          "label": LocaleKeys.app_home.tr,
        },
        {
          "activeIcon": Stack(
            alignment: Alignment.topRight,
            children: [
              SvgPicture.asset(
                ImageConstant.svgNavCarFilled,
                colorFilter: ColorFilter.mode(
                  Get.find<GetStorageService>().isPinkMode
                      ? ColorUtil.kPrimary3PinkMode
                      : ColorUtil.kSecondary01,
                  BlendMode.srcIn,
                ),
              ),
              if (reqsCount.value > 0) _buildBadge(reqsCount.value),
            ],
          ),
          "icon": Stack(
            alignment: Alignment.topRight,
            children: [
              SvgPicture.asset(ImageConstant.svgNavCar),
              if (reqsCount.value > 0) _buildBadge(reqsCount.value),
            ],
          ),
          "label": LocaleKeys.app_myRides.tr,
        },
        {
          "activeIcon": Stack(
            alignment: Alignment.topRight,
            children: [
              SvgPicture.asset(
                ImageConstant.svgNavMessagesFilled,
                colorFilter: ColorFilter.mode(
                  Get.find<GetStorageService>().isPinkMode
                      ? ColorUtil.kPrimary3PinkMode
                      : ColorUtil.kSecondary01,
                  BlendMode.srcIn,
                ),
              ),
              if (totUnreadMsgs.value > 0) _buildBadge(totUnreadMsgs.value),
            ],
          ),
          "icon": Stack(
            alignment: Alignment.topRight,
            children: [
              SvgPicture.asset(ImageConstant.svgNavMessages),
              if (totUnreadMsgs.value > 0) _buildBadge(totUnreadMsgs.value),
            ],
          ),
          "label": LocaleKeys.app_messages.tr,
        },
        {
          "activeIcon": SvgPicture.asset(
            ImageConstant.svgNavProfileFilled,
            colorFilter: ColorFilter.mode(
              Get.find<GetStorageService>().isPinkMode
                  ? ColorUtil.kPrimary3PinkMode
                  : ColorUtil.kSecondary01,
              BlendMode.srcIn,
            ),
          ),
          "icon": SvgPicture.asset(ImageConstant.svgNavProfile),
          "label": LocaleKeys.app_profile.tr,
        },
      ];

  Widget _buildBadge(int count) {
    return Container(
      height: 14.kh,
      width: 14.kw,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 1.kh, horizontal: 4.kw),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Get.find<GetStorageService>().isPinkMode
            ? ColorUtil.kSecondaryPinkMode
            : ColorUtil.kPrimary05,
      ),
      child: Text(
        "$count",
        style: TextStyleUtil.k8Semibold(
          color: Get.find<GetStorageService>().isPinkMode
              ? ColorUtil.kPrimary3PinkMode
              : ColorUtil.kSecondary01,
        ),
      ),
    );
  }
}

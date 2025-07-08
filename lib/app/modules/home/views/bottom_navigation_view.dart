import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/modules/home/controllers/home_controller.dart';
import 'package:green_pool/app/modules/home/views/home_view.dart';
import 'package:green_pool/app/modules/messages/views/messages_view.dart';
import 'package:green_pool/app/modules/my_rides_page/views/my_rides_page_view.dart';
import 'package:green_pool/app/modules/profile/views/profile_view.dart';

import '../../../services/colors.dart';
import '../../../services/storage.dart';
import '../../../services/text_style_util.dart';
import 'package:upgrader/upgrader.dart';

class BottomNavigationView extends GetView<HomeController> {
  const BottomNavigationView({super.key});
  @override
  Widget build(BuildContext context) {
    final storageService = Get.find<GetStorageService>();
    return Obx(
      () => PopScope(
        canPop: controller.canPop.value,
        onPopInvokedWithResult: (result, pop) {
          controller.canPop.value = result;
          if (controller.selectedIndex.value == 0) {
            controller.canPop.value = true;
            Get.back();
          } else {
            controller.changeTabIndex(0);
          }
        },
        child: UpgradeAlert(
          // barrierDismissible: false,
          // upgrader: Upgrader(
          //   debugDisplayAlways: true,
          //   debugLogging: true,
          //   // minAppVersion: '1.0.0',
          //   messages: UpgraderMessages(code: "Welcome to Testing"),
          //
          // ),
          dialogStyle: Platform.isAndroid
              ? UpgradeDialogStyle.material
              : UpgradeDialogStyle.cupertino,
          showLater: true,
          showIgnore: true,
          showReleaseNotes: true,

          child: Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              selectedLabelStyle: storageService.isPinkMode
                  ? TextStyleUtil.k12Semibold(color: ColorUtil.kPrimary3PinkMode)
                  : TextStyleUtil.k12Semibold(color: ColorUtil.kSecondary01),
              unselectedLabelStyle:
                  TextStyleUtil.k12Semibold(color: ColorUtil.kBlack05),
              backgroundColor: ColorUtil.kWhiteColor,
              type: BottomNavigationBarType.fixed,
              currentIndex: controller.selectedIndex.value,
              enableFeedback: true,
              unselectedItemColor: ColorUtil.kBlack05,
              selectedItemColor: storageService.isPinkMode
                  ? ColorUtil.kPrimary3PinkMode
                  : ColorUtil.kSecondary01,
              onTap: (index) {
                controller.onTapBottomNavigation(index);
              },
              items: controller.navItemsData.map((item) {
                return BottomNavigationBarItem(
                  activeIcon: item['activeIcon'],
                  icon: item['icon'],
                  label: item['label'],
                );
              }).toList(),
            ),
            body: PageView(
              controller: controller.pageController,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (index) {
                controller.changeTabIndex(index);
              },
              children: const [
                HomeView(),
                MyRidesPageView(),
                MessagesView(),
                ProfileView(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

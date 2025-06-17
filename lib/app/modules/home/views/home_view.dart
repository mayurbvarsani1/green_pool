import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/constants/image_constant.dart';
import 'package:green_pool/app/modules/home/views/welcome_tile.dart';
import 'package:green_pool/app/routes/app_pages.dart';
import 'package:green_pool/app/services/colors.dart';
import 'package:green_pool/app/services/dialog_helper.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import 'package:green_pool/app/services/text_style_util.dart';

import '../../../../generated/locales.g.dart';
import '../../../services/storage.dart';
import '../../profile/controllers/profile_controller.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final storageService = Get.find<GetStorageService>();
    final isUserSuspended = Get.find<GetStorageService>().accSuspended;
    Get.lazyPut(() => ProfileController());
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const WelcomeTile(),
              // Obx(() =>
              GestureDetector(
                onTap: isUserSuspended
                    ? () {
                        DialogHelper.accSuspendedDialog(() {
                          Get.back();
                          controller.changeTabIndex(3);
                          Get.toNamed(Routes.HELP_SUPPORT);
                        });
                      }
                    : () {
                        Get.toNamed(Routes.POST_RIDE_STEP_ONE, arguments: true);
                        controller.findingRide.value = false;
                      },
                child: Container(
                  width: 100.w,
                  height: 149.kh,
                  decoration: BoxDecoration(
                    color: ColorUtil.kWhiteColor,
                    borderRadius: BorderRadius.circular(8.kh),
                    border: Border(
                      right: BorderSide(
                        color: ColorUtil.kSecondary04,
                        width: 0.2.kh,
                      ),
                      bottom: BorderSide(
                        color: ColorUtil.kSecondary04,
                        width: 0.2.kh,
                      ),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                          right: 0,
                          left: storageService.isPinkMode ? 0 : null,
                          top: storageService.isPinkMode ? 0 : null,
                          bottom: 0,
                          child: storageService.isPinkMode
                              ? SvgPicture.asset(ImageConstant.svgPinkPostRide,
                                  fit: BoxFit.fill)
                              : SvgPicture.asset(ImageConstant.svgPostRide)),
                      Positioned(
                        left: 16.kw,
                        top: 48.kh,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(LocaleKeys.app_postRide.tr,
                                    style: TextStyleUtil.k20Heading700())
                                .paddingOnly(bottom: 4.kh),
                            SizedBox(
                              width: 170.kw,
                              child: Text(LocaleKeys.app_offerRideNearby.tr,
                                  style: TextStyleUtil.k14Regular()),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ).paddingOnly(bottom: 24.kh),
              ),
              // ),
              // Obx( () =>
              GestureDetector(
                onTap: isUserSuspended
                    ? () {
                        DialogHelper.accSuspendedDialog(() {
                          Get.back();
                          controller.changeTabIndex(3);
                          Get.toNamed(Routes.HELP_SUPPORT);
                        });
                      }
                    : () {
                        Get.toNamed(Routes.FIND_RIDE, arguments: false);
                        controller.findingRide.value = true;
                      },
                child: Container(
                  width: 100.w,
                  height: 149.kh,
                  decoration: BoxDecoration(
                    color: ColorUtil.kWhiteColor,
                    borderRadius: BorderRadius.circular(8.kh),
                    border: Border(
                      right: BorderSide(
                        color: ColorUtil.kSecondary04,
                        width: 0.2.kh,
                      ),
                      bottom: BorderSide(
                        color: ColorUtil.kSecondary04,
                        width: 0.2.kh,
                      ),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                          right: 0.kw,
                          left: storageService.isPinkMode ? 0 : null,
                          top: storageService.isPinkMode ? 0 : null,
                          bottom: 0.kh,
                          child: storageService.isPinkMode
                              ? SvgPicture.asset(
                                  ImageConstant.svgPinkFindRide,
                                  fit: BoxFit.fill,
                                )
                              : SvgPicture.asset(
                                  ImageConstant.svgFindRide,
                                )),
                      Positioned(
                        left: 16.kw,
                        top: 48.kh,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              LocaleKeys.app_findRide.tr,
                              style: TextStyleUtil.k20Heading700(),
                            ).paddingOnly(bottom: 4.kh),
                            SizedBox(
                              width: 170.kw,
                              child: Text(
                                LocaleKeys.app_takeRidesNearby.tr,
                                style: TextStyleUtil.k14Regular(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ).paddingOnly(bottom: 24.kh),
              ),





              /// TODO group carpool
              GestureDetector(
                onTap: isUserSuspended
                    ? () {
                  DialogHelper.accSuspendedDialog(() {
                    Get.back();
                    controller.changeTabIndex(3);
                    Get.toNamed(Routes.HELP_SUPPORT);
                  });
                }
                    : () {
                  Get.toNamed(Routes.ORGANIZE_CARPOOL, arguments: false);
                  controller.findingRide.value = true;
                },
                child: Container(
                  width: 100.w,
                  height: 149.kh,
                  decoration: BoxDecoration(
                    color: ColorUtil.kWhiteColor,
                    borderRadius: BorderRadius.circular(8.kh),
                    border: Border(
                      right: BorderSide(
                        color: ColorUtil.kSecondary04,
                        width: 0.2.kh,
                      ),
                      bottom: BorderSide(
                        color: ColorUtil.kSecondary04,
                        width: 0.2.kh,
                      ),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                          right: 0.kw,
                          left: storageService.isPinkMode ? 0 : null,
                          top: storageService.isPinkMode ? 0 : null,
                          bottom: 0.kh,
                          child: storageService.isPinkMode
                              ? SvgPicture.asset(
                            ImageConstant.svgPinkFindRide,
                            fit: BoxFit.fill,
                          )
                              : SvgPicture.asset(
                            ImageConstant.svgFindRide,
                          )),
                      Positioned(
                        left: 16.kw,
                        top: 48.kh,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              LocaleKeys.app_groupCarpool.tr,
                              style: TextStyleUtil.k20Heading700(),
                            ).paddingOnly(bottom: 4.kh),
                            // SizedBox(
                            //   width: 170.kw,
                            //   child: Text(
                            //     LocaleKeys.app_takeRidesNearby.tr,
                            //     style: TextStyleUtil.k14Regular(),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),


              // ),
            ],
          ).paddingSymmetric(horizontal: 16.kw),
        ),
      ),
    );
  }
}

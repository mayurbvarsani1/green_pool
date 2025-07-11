import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/components/common_image_view.dart';
import 'package:green_pool/app/components/greenpool_appbar.dart';
import 'package:green_pool/app/constants/image_constant.dart';
import 'package:green_pool/app/modules/report_block/controllers/report_block_controller.dart';
import 'package:green_pool/app/modules/report_block/views/address_list_view.dart';
import 'package:green_pool/app/routes/app_pages.dart';
import 'package:green_pool/app/services/colors.dart';
import 'package:green_pool/app/services/custom_button.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../generated/locales.g.dart';
import '../../../services/text_style_util.dart';
import '../controllers/profile_controller.dart';
import 'profile_container.dart';
import 'rating_bottomsheet.dart';
import 'socials_bottomsheet.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GreenPoolAppBar(
        title: Text(LocaleKeys.app_profile.tr),
        leading: const SizedBox(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Obx(
              () => GestureDetector(
                onTap: () => Get.toNamed(Routes.USER_DETAILS)?.then(
                  (value) => controller.updateInfo(),
                ),
                child: Hero(
                  tag: "profilePic",
                  transitionOnUserGestures: true,
                  child: Container(
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    child: ClipOval(
                        child: SizedBox.fromSize(
                            size: Size.fromRadius(44.kh),
                            child: CommonImageView(
                                height: 44.kh,
                                width: 44.kw,
                                url: controller.profilePic.value))),
                  ).paddingOnly(bottom: 8.kh, top: 16.kh),
                ),
              ),
            ),
            Obx(
              () => SizedBox(
                width: 50.w,
                child: Text(
                  controller.fullName.value ?? LocaleKeys.app_user.tr,
                  style: TextStyleUtil.k16Semibold(fontSize: 16.kh),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ).paddingOnly(bottom: 24.kh),
              ),
            ),
            controller.userInfo.value.data?.gender == "Female"
                ? ProfileContainer(
                    image: ImageConstant.svgProfileShieldPink,
                    text: LocaleKeys.app_activatePinkMode.tr,
                    info: GestureDetector(
                        onTap: () => Get.dialog(
                              useSafeArea: true,
                              Center(
                                child: Container(
                                    padding: EdgeInsets.all(16.kh),
                                    width: 80.w,
                                    decoration: BoxDecoration(
                                      color: ColorUtil.kWhiteColor,
                                      borderRadius: BorderRadius.circular(8.kh),
                                    ),
                                    child: Text(
                                      LocaleKeys.app_travelWithConfidenceWithOurPinkMode.tr,
                                      style: TextStyleUtil.k14Regular(color: ColorUtil.kBlack03),
                                    )),
                              ),
                            ),
                        child: SvgPicture.asset(ImageConstant.svgIconInfo)),
                    child: Obx(
                      () => Switch(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        value: controller.pinkMode.value,
                        onChanged: (value) {
                          controller.toggleSwitch();
                        },
                        inactiveThumbColor: ColorUtil.kNeutral1,
                        inactiveTrackColor: ColorUtil.kSecondaryPinkMode,
                        activeTrackColor: ColorUtil.kPrimary2PinkMode,
                        trackOutlineWidth: const MaterialStatePropertyAll(0),
                        thumbColor: const MaterialStatePropertyAll(
                            ColorUtil.kWhiteColor),
                        trackOutlineColor:
                            const MaterialStatePropertyAll(ColorUtil.kNeutral1),
                      ),
                    ),
                  )
                : const SizedBox(),
            ProfileContainer(
                onTap: () => Get.toNamed(Routes.PROFILE_SETTINGS)?.then(
                      (value) => controller.updateInfo(),
                    ),
                image: ImageConstant.svgProfileSettings,
                text: LocaleKeys.app_profileSettings.tr),
            ProfileContainer(
                onTap: () => Get.toNamed(Routes.PUSH_NOTIFICATIONS),
                image: ImageConstant.svgProfileNoti,
                text: LocaleKeys.app_notifications.tr),
            ProfileContainer(
                    onTap: () => Get.toNamed(Routes.RIDE_HISTORY),
                    image: ImageConstant.svgProfileRideHistory,
                    text: LocaleKeys.app_ridehistory.tr)
                .paddingOnly(bottom: 8.kh),
            ProfileContainer(
                onTap: () => Get.toNamed(Routes.WALLET),
                image: ImageConstant.svgProfileWallet,
                text: LocaleKeys.app_wallet.tr),
            ProfileContainer(
                onTap: () => Get.toNamed(Routes.STUDENT_DISCOUNTS),
                image: ImageConstant.svgProfileDiscount,
                text: LocaleKeys.app_studentDiscount.tr),
            ProfileContainer(
                onTap: () => Get.toNamed(Routes.REFER_FRIENDS),
                image: ImageConstant.svgProfileRefer,
                text: LocaleKeys.app_referAFriend.tr,
            ),
            ProfileContainer(
                // onTap: () => Get.toNamed(Routes.REPORT_BLOCK),
              // onTap: () => Get.to(()=> AddressListView()),
              onTap: () {
                ReportBlockController con = Get.put(ReportBlockController());
                con.initAddress();
                con.addressListGetAPI();
                Get.to(()=> AddressListView());

              },
                image: ImageConstant.reportBlockIcon,
                text: LocaleKeys.app_reportBlock.tr,
            ),



            // Builder(
            //   builder: (tileContext) {
            //     return ProfileContainer(
            //       onTap: () async {
            //         final shareText = Platform.isIOS
            //             ? "Check this cool app! \nhttps://apps.apple.com/in/app/carpooll-com/id6480311009"
            //             : "Check this cool app! \nhttps://play.google.com/store/apps/details?id=com.greenpool.app";
            //
            //         try {
            //           final box = tileContext.findRenderObject() as RenderBox;
            //           await Share.share(
            //             shareText,
            //             sharePositionOrigin:
            //                 box.localToGlobal(Offset.zero) & box.size,
            //           );
            //         } catch (e) {
            //           await Share.share(shareText);
            //         }
            //       },
            //       image: ImageConstant.svgProfileRefer,
            //       text: LocaleKeys.app_referAFriend.tr,
            //     );
            //   },
            // ),
            ProfileContainer(
                    onTap: () {
                      Get.bottomSheet(const RatingBottomSheet(),
                          enableDrag: true,
                          isScrollControlled: true,
                          enterBottomSheetDuration:
                              const Duration(milliseconds: 500),
                          exitBottomSheetDuration:
                              const Duration(milliseconds: 300));
                    },
                    image: ImageConstant.svgProfileStar,
                    text: LocaleKeys.app_rateUs.tr)
                .paddingOnly(bottom: 8.kh),
            ProfileContainer(
              image: ImageConstant.svgProfileAbout,
              text: LocaleKeys.app_aboutUs.tr,
              onTap: () => Get.toNamed(Routes.ABOUT),
            ),
            ProfileContainer(
                onTap: () => Get.toNamed(Routes.FILE_DISPUTE),
                image: ImageConstant.svgProfileFile,
                text: LocaleKeys.app_fileDispute.tr),
            ProfileContainer(
                onTap: () => Get.toNamed(Routes.HELP_SUPPORT),
                image: ImageConstant.svgProfileHelp,
                text: LocaleKeys.app_helpAndSupport.tr),
            ProfileContainer(
                onTap: () => Get.toNamed(Routes.TERMS_CONDITIONS),
                image: ImageConstant.svgProfileTerms,
                text: LocaleKeys.app_termsAmbersentConditions.tr),
            ProfileContainer(
                onTap: () async {
                  Get.bottomSheet(SocialsBottomsheet(),
                      enableDrag: true, isScrollControlled: true);
                },
                image: ImageConstant.svgProfileFollow,
                text: LocaleKeys.app_followUsOnSocialMedia.tr),
            ProfileContainer(
                    onTap: () => Get.toNamed(Routes.REPORT),
                    image: ImageConstant.svgProfileBug,
                    text: LocaleKeys.app_reportABug.tr)
                .paddingOnly(bottom: 8.kh),
            ProfileContainer(
                    onTap: () => Get.toNamed(Routes.LANGUAGE),
                    image: ImageConstant.svgProfileLanguage,
                    text: LocaleKeys.app_language_pref.tr)
                .paddingOnly(bottom: 8.kh),
            ProfileContainer(
              onTap: () => Get.dialog(
                useSafeArea: true,
                Center(
                  child: Container(
                    padding: EdgeInsets.all(16.kh),
                    height: 192.kh,
                    width: 80.w,
                    decoration: BoxDecoration(
                      color: ColorUtil.kWhiteColor,
                      borderRadius: BorderRadius.circular(8.kh),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () => Get.back(),
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: const Icon(Icons.close),
                          ),
                        ),
                        Text(
                          LocaleKeys.app_confirmLogout.tr,
                          style: TextStyleUtil.k18Semibold(),
                          textAlign: TextAlign.center,
                        ).paddingSymmetric(vertical: 4.kh),
                        Text(
                          LocaleKeys.app_sureWantToLogout.tr,
                          style: TextStyleUtil.k14Regular(
                            color: ColorUtil.kBlack04,
                          ),
                          textAlign: TextAlign.center,
                        ).paddingOnly(bottom: 40.kh),
                        Container(
                          alignment: Alignment.centerRight,
                          child: GreenPoolButton(
                            onPressed: () {
                              controller.logoutUser();
                            },
                            height: 40.kh,
                            width: 144.kw,
                            label: LocaleKeys.app_logout.tr,
                            fontSize: 14.kh,
                            padding: const EdgeInsets.all(8),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              image: ImageConstant.svgProfileLogout,
              text: LocaleKeys.app_logout.tr,
              border: Border.all(color: ColorUtil.kWhiteColor),
            ).paddingOnly(bottom: 40.kh),
          ],
        ).paddingSymmetric(horizontal: 16.kw),
      ),
    );
  }
}

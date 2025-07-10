import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/components/common_image_view.dart';
import 'package:green_pool/app/components/greenpool_textfield.dart';
import 'package:green_pool/app/constants/image_constant.dart';
import 'package:green_pool/app/modules/driver_details/controllers/driver_details_controller.dart';
import 'package:green_pool/app/modules/refer_friends/controllers/refer_friend_controller.dart';
import 'package:green_pool/app/services/colors.dart';
import 'package:green_pool/app/services/custom_button.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import 'package:green_pool/app/services/text_style_util.dart';

import '../../../../../generated/locales.g.dart';

class ReportBlockBottomSheet extends GetView<DriverDetailsController> {
  ReportBlockBottomSheet({
    super.key,
  });

  @override
  DriverDetailsController controller = Get.put(DriverDetailsController());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 24.kh, left: 16.kw, right: 16.kw),
      // height: 50.h,
      width: 100.w,
      decoration: BoxDecoration(
          color: ColorUtil.kWhiteColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40.kh),
              topRight: Radius.circular(40.kh))),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10.kh,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  LocaleKeys.why_are_you_reporting.tr,
                  style: TextStyleUtil.k24Semibold(fontWeight: FontWeight.w600),
                ).paddingOnly(bottom: 8.kh),
                InkWell(
                  onTap: () => Get.back(),
                  child: Container(
                    height: 32,
                    width: 32,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: ColorUtil.kNeutral11),
                    child: Icon(
                      Icons.close_outlined,
                      color: ColorUtil.kBlack011,
                    ),
                  ),
                )
              ],
            ).paddingOnly(bottom: 10.kh),
            commonContainer(
              onTap: () {
                Get.back();
                controller.isTextNotEmpty.value = false;
                Get.bottomSheet(ReportBottomSheetScreen(),
                    enableDrag: true, isScrollControlled: true);
              },
              imagePath: ImageConstant.flagIcon,
              title:
                  "${LocaleKeys.app_report.tr} ${controller.matchingRidesModelData.value.driverDetails?[0]?.fullName?.split(" ").first}",
              subTitle: LocaleKeys.app_yourReportIsAnonymousIfYouAreIn.tr,
            ),
            SizedBox(
              height: 15.kh,
            ),
            commonContainer(
              onTap: () {
                Get.back();

                Get.bottomSheet(BlockBottomSheet(),
                    enableDrag: true, isScrollControlled: true);
              },
              imagePath: ImageConstant.closeIcon,
              title:
                  "${LocaleKeys.app_block.tr} ${controller.matchingRidesModelData.value.driverDetails?[0]?.fullName?.split(" ").first}",
              subTitle:
                  "${controller.matchingRidesModelData.value.driverDetails?[0]?.fullName?.split(" ").first} ${LocaleKeys.app_willNotBeNotifiedYouWant.tr}",
            ),
            SizedBox(
              height: 15.kh,
            ),
          ],
        ),
      ),
    );
  }

  commonContainer(
      {VoidCallback? onTap,
      String? imagePath,
      String? title,
      String? subTitle}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 140,
        padding: EdgeInsets.symmetric(horizontal: 3.w),
        width: Get.width,
        decoration: BoxDecoration(
          color: ColorUtil.kWhiteColor,
          borderRadius: BorderRadius.circular(16),
          // border: Border.all(color: ColorUtil.kNeutral12),
          border: Border.all(
            color: ColorUtil.appGray5.withOpacity(0.5),
          ),
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.black.withOpacity(0.05),
          //     spreadRadius: 1,
          //     blurRadius: 5,
          //     offset: const Offset(0, 2),
          //   ),
          // ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                CommonImageView(
                  imagePath: imagePath,
                  height: 25,
                  width: 25,
                ).paddingOnly(right: 1.w),
                Text(
                  title ?? "",
                  style: TextStyleUtil.k16Semibold(
                      fontSize: 16, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.start,
                ),
              ],
            ).paddingOnly(bottom: 10.kh, top: 10.kh),
            Text(
              subTitle ?? "",
              style: TextStyleUtil.k14Semibold(color: ColorUtil.kBlack04),
            ).paddingOnly(bottom: 5.kh),
          ],
        ),
      ),
    );
  }
}

class ReportBottomSheetScreen extends GetView<DriverDetailsController> {
  ReportBottomSheetScreen({
    super.key,
  });

  @override
  DriverDetailsController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: controller.isTextNotEmpty.stream,
        builder: (context, snapshot) {
          return Container(
            padding: EdgeInsets.only(top: 24.kh, left: 16.kw, right: 16.kw),
            // height: 75.h,
            width: 100.w,
            decoration: BoxDecoration(
                color: ColorUtil.kWhiteColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.kh),
                    topRight: Radius.circular(40.kh))),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 10.kh,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        LocaleKeys.app_whatHappened.tr,
                        style: TextStyleUtil.k24Semibold(
                            fontWeight: FontWeight.w600),
                      ).paddingOnly(bottom: 8.kh),
                      InkWell(
                        onTap: () => Get.back(),
                        child: Container(
                          height: 32,
                          width: 32,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: ColorUtil.kNeutral11),
                          child: const Icon(
                            Icons.close_outlined,
                            color: ColorUtil.kBlack011,
                          ),
                        ),
                      )
                    ],
                  ).paddingOnly(bottom: 10.kh),
                  // Text("${controller.matchingRidesModelData.value.driverId}",style: TextStyleUtil.k12Regular(),),
                  // Text("${controller.matchingRidesModelData.value.Id}",style: TextStyleUtil.k12Regular(),),
                  ListView.builder(
                    itemCount: controller.reportReasons.length,
                    physics: const NeverScrollableScrollPhysics(),

                    // padding: EdgeInsets.zero,
                    // padding: EdgeInsets.only(left: 3.w,right: 3.w,bottom: 3.w,top: 3.w),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 62,
                        width: Get.width,
                        margin: EdgeInsets.only(bottom: 8.kh),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: ColorUtil.kWhiteColor,
                          borderRadius: BorderRadius.circular(16),
                          // border: Border.all(color: ColorUtil.kNeutral12),
                          border: Border.all(
                            color: ColorUtil.appGray5.withOpacity(0.5),
                          ),
                          // boxShadow: [
                          //   BoxShadow(
                          //     color: Colors.black.withOpacity(0.05),
                          //     spreadRadius: 1,
                          //     blurRadius: 5,
                          //     offset: const Offset(0, 2),
                          //   ),
                          // ],
                        ),
                        child: ListTile(
                          contentPadding: EdgeInsets.only(
                            left: 3.w,
                          ),
                          title: Text(
                            "${controller.reportReasons[index]['label']}".tr,
                            style: TextStyleUtil.k16Semibold(
                                fontSize: 16,
                                color: ColorUtil.kBlack01,
                                fontWeight: FontWeight.w600),
                          ),
                          trailing: const Icon(
                            Icons.keyboard_arrow_right,
                            color: ColorUtil.kBlack01,
                          ),
                          onTap: () {
                            controller.selectedReason =
                                controller.reportReasons[index]['label']!;
                            debugPrint(
                                "controller.selectedReason=>${controller.selectedReason}");
                            debugPrint(
                                'Selected: ${controller.reportReasons[index]['label']}');
                            Get.back();
                            controller.isTextNotEmpty.value = false;
                            Get.bottomSheet(ReportExplainIssue(),
                                enableDrag: true, isScrollControlled: true);
                          },
                        ).paddingOnly(bottom: 5.kh),
                      );
                    },
                  ),
                  Container(
                      height: 200,
                      padding: EdgeInsets.symmetric(horizontal: 3.w),
                      width: Get.width,
                      decoration: BoxDecoration(
                        color: ColorUtil.kWhiteColor,
                        borderRadius: BorderRadius.circular(16),
                        // border: Border.all(color: ColorUtil.kNeutral12),
                        border: Border.all(
                          color: ColorUtil.appGray5.withOpacity(0.5),
                        ),
                        // boxShadow: [
                        //   BoxShadow(
                        //     color: Colors.black.withOpacity(0.05),
                        //     spreadRadius: 1,
                        //     blurRadius: 5,
                        //     offset: const Offset(0, 2),
                        //   ),
                        // ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10.kh,
                          ),
                          Text(
                            LocaleKeys.app_somethingElse.tr,
                            style: TextStyleUtil.k16Semibold(
                                fontSize: 16,
                                color: ColorUtil.kBlack01,
                                fontWeight: FontWeight.w600),
                          ).paddingOnly(bottom: 10.kh),
                          longDescriptionTextField(
                            controller: controller.somethingElseController,hintText:LocaleKeys.app_explainHere.tr,
                            onchanged: (p0) {
                              if (controller.somethingElseController.text.trim().isNotEmpty) {
                                controller.isTextNotEmpty.value = true;
                              } else {
                                controller.isTextNotEmpty.value = false;
                              }
                            },
                          )
                          // commonTextField(
                          //   controller.somethingElseController,
                          //     (value){
                          //      if(controller.somethingElseController.text.trim().isNotEmpty){
                          //        controller.isTextNotEmpty.value = true;
                          //      }else{
                          //        controller.isTextNotEmpty.value = false;
                          //      }
                          //     }
                          // ),
                        ],
                      )),
                  GreenPoolButton(
                    borderRadius: 50,
                    onPressed: () {
                      controller.selectedReason =
                          LocaleKeys.app_somethingElse.tr;
                      controller.addReportAPI(
                          controller:
                              controller.somethingElseController.text.trim());
                    },
                    label: LocaleKeys.app_done.tr,
                    isActive: controller.isTextNotEmpty.value,
                  ).paddingSymmetric(vertical: 20.kw),
                ],
              ),
            ),
          );
        });
  }
}

class ReportExplainIssue extends GetView<DriverDetailsController> {
  ReportExplainIssue({
    super.key,
  });

  @override
  DriverDetailsController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: controller.isTextNotEmpty.stream,
        builder: (context, snapshot) {
          return Container(
            padding: EdgeInsets.only(top: 24.kh, left: 16.kw, right: 16.kw),
            // height: 50.h,
            width: 100.w,
            decoration: BoxDecoration(
                color: ColorUtil.kWhiteColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.kh),
                    topRight: Radius.circular(40.kh))),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 10.kh,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        LocaleKeys.app_explainYourIssue.tr,
                        style: TextStyleUtil.k24Semibold(
                            fontWeight: FontWeight.w600),
                      ).paddingOnly(bottom: 8.kh),
                      InkWell(
                        onTap: () => Get.back(),
                        child: Container(
                          height: 32,
                          width: 32,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: ColorUtil.kNeutral11),
                          child: const Icon(
                            Icons.close_outlined,
                            color: ColorUtil.kBlack011,
                          ),
                        ),
                      )
                    ],
                  ).paddingOnly(bottom: 3.kh),
                  Text(
                    LocaleKeys.app_informationHelpImprove.tr,
                    style: TextStyleUtil.k14Regular(color: ColorUtil.kBlack03),
                  ).paddingOnly(bottom: 12.kh),
                  longDescriptionTextField(controller: controller.explainIssueController,hintText:LocaleKeys.app_explainHere.tr,onchanged: (p0) {
                    if (controller.explainIssueController.text
                        .trim()
                        .isNotEmpty) {
                      controller.isTextNotEmpty.value = true;
                    } else {
                      controller.isTextNotEmpty.value = false;
                    }
                  },),
                  // commonTextField(controller.explainIssueController, (value) {
                  //   if (controller.explainIssueController.text
                  //       .trim()
                  //       .isNotEmpty) {
                  //     controller.isTextNotEmpty.value = true;
                  //   } else {
                  //     controller.isTextNotEmpty.value = false;
                  //   }
                  // }),
                  GreenPoolButton(
                    borderRadius: 50,
                    onPressed: () {
                      controller.addReportAPI(
                          controller: controller.explainIssueController.text);
                    },
                    label: LocaleKeys.app_report.tr,
                    isActive: controller.isTextNotEmpty.value,
                  ).paddingSymmetric(vertical: 20.kw),
                ],
              ),
            ),
          );
        });
  }
}

class BlockBottomSheet extends GetView<DriverDetailsController> {
  BlockBottomSheet({
    super.key,
  });

  @override
  DriverDetailsController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 24.kh, left: 16.kw, right: 16.kw),
      // height: 50.h,
      width: 100.w,
      decoration: BoxDecoration(
          color: ColorUtil.kWhiteColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40.kh),
              topRight: Radius.circular(40.kh))),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10.kh,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CommonImageView(
                      imagePath: ImageConstant.closeIcon,
                      height: 25,
                      width: 25,
                    ).paddingOnly(right: 1.w),
                    Text(
                      "${LocaleKeys.app_block.tr} ${controller.matchingRidesModelData.value.driverDetails?[0]?.fullName?.split(" ").first}",
                      style: TextStyleUtil.k24Semibold(),
                    ),
                  ],
                ).paddingOnly(bottom: 8.kh),
                InkWell(
                  onTap: () => Get.back(),
                  child: Container(
                    height: 32,
                    width: 32,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: ColorUtil.kNeutral11),
                    child: const Icon(
                      Icons.close_outlined,
                      color: ColorUtil.kBlack011,
                    ),
                  ),
                ),
              ],
            ).paddingOnly(bottom: 10.kh),
            ListView.builder(
              itemCount: controller.blockInformationList.length,
              physics: const NeverScrollableScrollPhysics(),

              // padding: EdgeInsets.zero,
              // padding: EdgeInsets.only(left: 3.w,right: 3.w,bottom: 3.w,top: 3.w),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Container(
                  height: 62,
                  width: Get.width,
                  margin: EdgeInsets.only(bottom: 8.kh),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: ColorUtil.kWhiteColor,
                    borderRadius: BorderRadius.circular(16),
                    // border: Border.all(color: ColorUtil.kNeutral12),
                    border: Border.all(
                      color: ColorUtil.appGray5.withOpacity(0.5),
                    ),
                    // boxShadow: [
                    //   BoxShadow(
                    //     color: Colors.black.withOpacity(0.05),
                    //     spreadRadius: 1,
                    //     blurRadius: 5,
                    //     offset: const Offset(0, 2),
                    //   ),
                    // ],
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.only(
                      left: 3.w,
                    ),
                    title: Text(
                      "${controller.blockInformationList[index]['text']}".tr,
                      style: TextStyleUtil.k16Semibold(
                          fontSize: 16,
                          color: ColorUtil.kBlack01,
                          fontWeight: FontWeight.w600),
                    ),
                  ).paddingOnly(bottom: 5.kh),
                );
              },
            ),
            GreenPoolButton(
              borderRadius: 50,
              onPressed: () {
                controller.blockAPI();
              },
              label: LocaleKeys.app_block.tr,
            ).paddingSymmetric(vertical: 20.kw),
          ],
        ),
      ),
    );
  }
}

// commonTextField(
//     TextEditingController? controller, final Function(String?)? onchanged) {
//   return TextField(
//     controller: controller,
//     maxLines: 5,
//     onChanged: onchanged,
//     decoration: InputDecoration(
//       contentPadding: EdgeInsets.symmetric(vertical: 8.kh, horizontal: 12.kw),
//       hintText: LocaleKeys.app_explainHere.tr,
//       fillColor: ColorUtil.kGreyColor,
//       filled: true,
//       hintStyle: TextStyleUtil.k14Regular(
//         color: ColorUtil.kBlack03,
//       ),
//       enabledBorder: UnderlineInputBorder(
//           borderSide: const BorderSide(color: Colors.transparent),
//           borderRadius: BorderRadius.circular(8.kh)),
//       focusedBorder: UnderlineInputBorder(
//           borderSide: const BorderSide(color: Colors.transparent),
//           borderRadius: BorderRadius.circular(8.kh)),
//       disabledBorder: UnderlineInputBorder(
//           borderSide: const BorderSide(color: Colors.transparent),
//           borderRadius: BorderRadius.circular(8.kh)),
//       errorBorder: OutlineInputBorder(
//         borderSide: const BorderSide(color: ColorUtil.kError2),
//         borderRadius: BorderRadius.circular(8.kh),
//       ),
//       focusedErrorBorder: OutlineInputBorder(
//         borderSide: const BorderSide(color: ColorUtil.kError2),
//         borderRadius: BorderRadius.circular(8.kh),
//       ),
//     ),
//   );
// }

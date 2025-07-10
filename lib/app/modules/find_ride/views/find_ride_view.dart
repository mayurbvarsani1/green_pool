import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/components/greenpool_appbar.dart';
import 'package:green_pool/app/components/richtext_heading.dart';
import 'package:green_pool/app/constants/image_constant.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../../../../generated/locales.g.dart';
import '../../../components/greenpool_textfield.dart';

import '../../../services/colors.dart';
import '../../../services/custom_button.dart';
import '../../../services/text_style_util.dart';
import '../../home/controllers/home_controller.dart';
import '../controllers/find_ride_controller.dart';

class FindRideView extends GetView<FindRideController> {
  const FindRideView({super.key});

  @override
  Widget build(BuildContext context) {
    final isPinkModeOn = Get.find<HomeController>().isPinkModeOn.value;
    // final pickedDate = DateTime.now();
    // controller.date.text = pickedDate.toIso8601String();
    // controller.departureDate.text =
    //     "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
    return Scaffold(
      appBar: GreenPoolAppBar(
        title: Text(LocaleKeys.app_findRide.tr),
      ),
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // RichTextHeading(text: LocaleKeys.app_pickup.tr).paddingOnly(top: 12.kh),
                Text(
                  LocaleKeys.app_pickup.tr,
                  style: TextStyleUtil.k14Semibold(),
                ).paddingOnly(top: 12.kh),
                GreenPoolTextField(
                  textStyle: TextStyleUtil.k14Medium(color: ColorUtil.kBlack01),
                  hintText: LocaleKeys.app_enterOrigin.tr,
                  keyboardType: TextInputType.streetAddress,
                  onchanged: (v) {
                    controller.setActiveState();
                  },
                  onTap: () {
                    controller.moveToSetOrigin();
                  },
                  controller: controller.riderOriginTextController,
                  readOnly: true,
                  prefix: Icon(
                    Icons.location_on,
                    size: 24.kh,
                    color: isPinkModeOn
                        ? ColorUtil.kPrimary3PinkMode
                        : ColorUtil.kSecondary01,
                  ),
                  suffix: controller.isOriginAdded.value
                      ? InkWell(
                          onTap: () => controller.removeOrigin(),
                          child: const Icon(Icons.cancel))
                      : const SizedBox(),
                ).paddingOnly(top: 8.kh, bottom: 28.kh),
                Text(
                  LocaleKeys.app_destination.tr,
                  style: TextStyleUtil.k14Semibold(),
                ),
                GreenPoolTextField(
                  textStyle: TextStyleUtil.k14Medium(color: ColorUtil.kBlack01),
                  hintText: LocaleKeys.app_enterAdestination.tr,
                  keyboardType: TextInputType.streetAddress,
                  onchanged: (v) {
                    controller.setActiveState();
                  },
                  onTap: () {
                    controller.moveToSetDestination();
                  },
                  controller: controller.riderDestinationTextController,
                  prefix: Icon(
                    Icons.location_on,
                    size: 24.kh,
                    color: isPinkModeOn
                        ? ColorUtil.kPrimary3PinkMode
                        : ColorUtil.kSecondary01,
                  ),
                  readOnly: true,
                  suffix: controller.isDestinationAdded.value
                      ? InkWell(
                          onTap: () => controller.removeDestination(),
                          child: const Icon(Icons.cancel))
                      : const SizedBox(),
                ).paddingOnly(top: 8.kh, bottom: 16.kh),
                Row(
                  children: [
                    SizedBox(
                      width: 55.w,
                      child: Text(
                        LocaleKeys.app_departureDate.tr,
                        style: TextStyleUtil.k14Semibold(),
                      ),
                    ),
                    Flexible(
                        child: Text(
                      LocaleKeys.app_time.tr,
                      style: TextStyleUtil.k14Semibold(),
                    ))
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 55.w,
                      child: GreenPoolTextField(
                        textStyle:
                            TextStyleUtil.k14Medium(color: ColorUtil.kBlack01),
                        hintText: LocaleKeys.app_enterDate.tr,
                        controller: controller.departureDate,
                        isSuffixNeeded: false,
                        readOnly: true,
                        onTap: () {
                          controller.setDate(context);
                        },
                        prefix: SvgPicture.asset(
                          ImageConstant.svgIconCalendarClear,
                          colorFilter: ColorFilter.mode(
                              isPinkModeOn
                                  ? ColorUtil.kPrimary3PinkMode
                                  : ColorUtil.kSecondary01,
                              BlendMode.srcIn),
                        ),
                      ).paddingOnly(top: 8.kh, bottom: 16.kh, right: 8.kw),
                    ),
                    Flexible(
                      child: GreenPoolTextField(
                        textStyle:
                            TextStyleUtil.k14Medium(color: ColorUtil.kBlack01),
                        hintText: LocaleKeys.app_time.tr,
                        controller: controller.selectedTime,
                        isSuffixNeeded: false,
                        readOnly: true,
                        onTap: () {
                          controller.setTime(context);
                        },
                        prefix: SvgPicture.asset(
                          ImageConstant.svgIconTime,
                          colorFilter: ColorFilter.mode(
                              isPinkModeOn
                                  ? ColorUtil.kPrimary3PinkMode
                                  : ColorUtil.kSecondary01,
                              BlendMode.srcIn),
                        ),
                      ).paddingOnly(top: 8.kh, bottom: 16.kh),
                    ),
                  ],
                ).paddingOnly(bottom: 8.kh),
                RichTextHeading(text: LocaleKeys.app_seatsNeeded.tr)
                    .paddingOnly(bottom: 8.kh),
                GreenPoolTextField(
                  textStyle: TextStyleUtil.k14Medium(color: ColorUtil.kBlack01),
                  hintText: LocaleKeys.app_enterNumberOfSeats.tr,
                  controller: controller.seatAvailable,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp(r'[0-9]')), // Only allow digits (0-9)
                    FilteringTextInputFormatter.deny(
                        RegExp(r'[^\w\s]')), // Deny all special characters
                  ],
                  keyboardType: TextInputType.number,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) => controller.seatsValidator(value),
                  onchanged: (v) {
                    controller.setActiveState();
                  },
                  prefix: Icon(
                    Icons.time_to_leave,
                    color: isPinkModeOn
                        ? ColorUtil.kPrimary3PinkMode
                        : ColorUtil.kSecondary01,
                  ),
                ).paddingOnly(bottom: 16.kh),
                Obx(
                  () => Visibility(
                    visible: controller.locationModelNames.isNotEmpty,
                    child: Text(
                      LocaleKeys.app_previouslySearched.tr,
                      style: TextStyleUtil.k14Semibold(),
                    ).paddingOnly(bottom: 8.kh),
                  ),
                ),
                Obx(
                  () => Visibility(
                      visible: controller.locationModelNames.isNotEmpty,
                      child: SizedBox(
                        height: 158.kh,
                        child: ListView.builder(
                            itemCount: controller.locationModelNames.length,
                            itemBuilder: (context, index) {
                              return Container(
                                decoration: BoxDecoration(
                                    color: ColorUtil.kNeutral7.withOpacity(0.5),
                                    border: Border(
                                        top: BorderSide.none,
                                        bottom: BorderSide(
                                            width: 1.kh,
                                            color: ColorUtil.kNeutral7)),
                                    borderRadius: BorderRadius.circular(8.kh)),
                                child: ListTile(
                                  leading: const Icon(
                                    Icons.history,
                                    color: ColorUtil.kNeutral4,
                                  ),
                                  title: Text(
                                    "${controller.locationModelNames[index].originLocation?.nameOfLocation.toString().split(",").first} to ${controller.locationModelNames[index].destinationLocation?.nameOfLocation.toString().split(",").first}",
                                    style: TextStyleUtil.k12Bold(),
                                  ),
                                  onTap: () {
                                    controller.setLocation(index);
                                  },
                                ),
                              ).paddingOnly(bottom: 2.kh);
                            }),
                      )),
                ),
                /*Text(
                  LocaleKeys.app_description.tr,
                  style: TextStyleUtil.k14Semibold(),
                ).paddingOnly(bottom: 8.kh),
                GreenPoolTextField(
                textStyle: TextStyleUtil.k14Medium(color: ColorUtil.kBlack01),
                  hintText: LocaleKeys.app_enterTextHere.tr,
                  controller: controller.descriptionTextController,
                  maxLines: 6,
                ),*/
                const Expanded(child: SizedBox()),
                GreenPoolButton(
                  padding: const EdgeInsets.all(0),
                  onPressed: () => controller.moveToMatchingRides(),
                  // isActive: controller.isActive.value,
                  label: LocaleKeys.app_findMatchingRides.tr,
                ).paddingOnly(bottom: 30.kh),
              ],
            ).paddingSymmetric(horizontal: 16.kw),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
                onPressed: () {
                  controller.swapTextFields();
                },
                highlightColor: isPinkModeOn
                    ? ColorUtil.kPrimaryPinkMode
                    : ColorUtil.kPrimary03,
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(isPinkModeOn
                      ? ColorUtil.kPrimary2PinkMode.withOpacity(0.8)
                      : ColorUtil.kPrimary01),
                ),
                padding: EdgeInsets.all(4.kh),
                icon: Icon(
                  Icons.swap_vert_rounded,
                  size: 28.kh,
                  color: ColorUtil.kSecondary01,
                )).paddingOnly(right: 32.kw, top: 96.kh).animate().flip(),
          ),
        ],
      ),
    );
  }
}

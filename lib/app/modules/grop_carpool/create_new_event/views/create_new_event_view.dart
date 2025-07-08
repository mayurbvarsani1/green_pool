import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/components/greenpool_appbar.dart';
import 'package:green_pool/app/components/richtext_heading.dart';
import 'package:green_pool/app/constants/image_constant.dart';
import 'package:green_pool/app/modules/grop_carpool/create_new_event/controllers/create_new_event_controller.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../../../../../generated/locales.g.dart';
import '../../../../components/greenpool_textfield.dart';
import '../../../../services/colors.dart';
import '../../../../services/custom_button.dart';
import '../../../../services/storage.dart';
import '../../../../services/text_style_util.dart';
import '../../../home/controllers/home_controller.dart';



class CreateNewEventView extends GetView<CreateNewEventController> {
  const CreateNewEventView({super.key});

  @override
  Widget build(BuildContext context) {
    final storageService = Get.find<GetStorageService>();

    final isPinkModeOn = Get.find<HomeController>().isPinkModeOn.value;

    return Scaffold(
      appBar: GreenPoolAppBar(
        title: Text(LocaleKeys.app_createNewEvent.tr),
      ),
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

              SizedBox(
              height: 30.kh),
                RichTextHeading(text: LocaleKeys.app_title.tr),
                GreenPoolTextField(
                  textStyle: TextStyleUtil.k14Medium(color: ColorUtil.kBlack01),
                  hintText: LocaleKeys.app_titleHintText.tr,
                  keyboardType: TextInputType.streetAddress,
                  onchanged: (v) {

                  },
                  onTap: () {


                  },
                  controller: controller.titleTextController,
                  // readOnly: true,
                ).paddingOnly(top: 8.kh, bottom: 14.kh),


                RichTextHeading(text: LocaleKeys.app_destinations.tr),
                GreenPoolTextField(
                  textStyle: TextStyleUtil.k14Medium(color: ColorUtil.kBlack01),
                  hintText: LocaleKeys.app_enterADestination.tr,
                  keyboardType: TextInputType.streetAddress,
                  onchanged: (v) {
                    controller.setActiveState();
                  },
                  onTap: () {
                    controller.moveToSetDestination();
                  },
                  controller: controller.riderOriginTextController,

                  prefix: SvgPicture.asset(
                    ImageConstant.location,
                    colorFilter: ColorFilter.mode(
                        isPinkModeOn
                            ? ColorUtil.kPrimary3PinkMode
                            : ColorUtil.kBlack09,
                        BlendMode.srcIn),
                  ),
                  readOnly: true,
                  suffix: controller.isDestinationAdded.value
                      ? InkWell(
                          onTap: () => controller.removeDestination(),
                          child: const Icon(Icons.cancel))
                      : const SizedBox(),
                ).paddingOnly(top: 8.kh, bottom: 16.kh),


                RichTextHeading(text: LocaleKeys.app_dateTime.tr),

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
                                  : ColorUtil.kBlack09,
                              BlendMode.srcIn),
                        ),
                      ).paddingOnly(top: 8.kh, bottom: 16.kh, right: 8.kw),
                    ),
                    Flexible(
                      child: GreenPoolTextField(
                        textStyle: TextStyleUtil.k14Medium(color: ColorUtil.kBlack01),
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
                                  : ColorUtil.kBlack09,
                              BlendMode.srcIn),
                        ),
                      ).paddingOnly(top: 8.kh, bottom: 16.kh),
                    ),
                  ],
                ).paddingOnly(bottom: 8.kh),
                RichTextHeading(text: LocaleKeys.app_expectedAttendees.tr)
                    .paddingOnly(bottom: 8.kh),
                GreenPoolTextField(
                  textStyle: TextStyleUtil.k14Medium(color: ColorUtil.kBlack01),
                  hintText: LocaleKeys.app_enterNumberOfSeats.tr,
                  controller: controller.seatAvailable,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp(r'[0-9]')), // Only allow digits (0-9)
                    FilteringTextInputFormatter.deny(
                        RegExp(r'[^\w\s]')),
                    LengthLimitingTextInputFormatter(3),
                    // Deny all special characters
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

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Row(
                    children: [
                      Text(LocaleKeys.app_publicPrivate.tr,) ,
                        InkWell(
                            child: SvgPicture.asset(ImageConstant.svgIconInfo,color: storageService.isPinkMode
                                ?   ColorUtil.kSecondaryPinkMode  : ColorUtil.kPrimary01,)),
                    ],
                  ),
                    Obx(
                          () => Switch(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        value: controller.isPublicPrivate.value,
                        onChanged: (value) {
                          controller.toggleSwitch();
                        },
                        inactiveThumbColor: ColorUtil.kNeutral1,
                        inactiveTrackColor:  storageService.isPinkMode
                            ?   ColorUtil.kSecondaryPinkMode  :ColorUtil.kPrimary04,
                        activeTrackColor: storageService.isPinkMode
                            ?  ColorUtil.kPrimary2PinkMode  :   ColorUtil.kPrimary01,
                        trackOutlineWidth: const MaterialStatePropertyAll(0),
                        thumbColor: const MaterialStatePropertyAll(
                            ColorUtil.kWhiteColor),
                        trackOutlineColor: const MaterialStatePropertyAll(ColorUtil.kNeutral1),
                      ),
                    ),
                  ],
                ),



               const Expanded(child: SizedBox()),
                GreenPoolButton(
                  padding: const EdgeInsets.all(0),
                  onPressed: () => controller.publishEventApi(),
                  isActive: controller.isActive.value,
                  label: LocaleKeys.app_publishEvent.tr,
                ).paddingOnly(bottom: 30.kh),
              ],
            ).paddingSymmetric(horizontal: 16.kw),
          ),
        ],
      ),
    );
  }
}
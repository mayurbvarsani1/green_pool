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
import '../../../../services/text_style_util.dart';
import '../../../home/controllers/home_controller.dart';



class CreateNewEventView extends GetView<CreateNewEventController> {
  const CreateNewEventView({super.key});

  @override
  Widget build(BuildContext context) {
    final isPinkModeOn = Get.find<HomeController>().isPinkModeOn.value;
    // final pickedDate = DateTime.now();
    // controller.date.text = pickedDate.toIso8601String();
    // controller.departureDate.text =
    //     "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
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
                // RichTextHeading(text: LocaleKeys.app_pickup.tr).paddingOnly(top: 12.kh),
                
                RichTextHeading(text: LocaleKeys.app_title.tr),
                GreenPoolTextField(
                  textStyle: TextStyleUtil.k14Medium(color: ColorUtil.kBlack01),
                  hintText: LocaleKeys.app_titleHintText.tr,
                  keyboardType: TextInputType.streetAddress,
                  onchanged: (v) {

                  },
                  onTap: () {


                  },
                  controller: controller.riderDestinationTextController,
                  // readOnly: true,
                ).paddingOnly(top: 8.kh, bottom: 14.kh),

                // Text(
                //   LocaleKeys.app_destinations.tr,
                //   style: TextStyleUtil.k14Semibold(),
                // ),

                RichTextHeading(text: LocaleKeys.app_destinations.tr),
                GreenPoolTextField(
                  textStyle: TextStyleUtil.k14Medium(color: ColorUtil.kBlack01),
                  hintText: "Enter a destination",
                  keyboardType: TextInputType.streetAddress,
                  onchanged: (v) {
                    controller.setActiveState();
                  },
                  onTap: () {
                    controller.moveToSetDestination();
                  },
                  controller: controller.riderOriginTextController,
                  // prefix: Icon(
                  //   Icons.location_on,
                  //   size: 24.kh,
                  //   color: isPinkModeOn
                  //       ? ColorUtil.kPrimary3PinkMode
                  //       : ColorUtil.kSecondary01,
                  // ),
                  prefix: SvgPicture.asset(
                    ImageConstant.location,
                    // colorFilter: ColorFilter.mode(
                    //     isPinkModeOn
                    //         ? ColorUtil.kPrimary3PinkMode
                    //         : ColorUtil.kBlack09,
                    //     BlendMode.srcIn),
                  ),
                  readOnly: true,
                  suffix: controller.isDestinationAdded.value
                      ? InkWell(
                          onTap: () => controller.removeDestination(),
                          child: const Icon(Icons.cancel))
                      : const SizedBox(),
                ).paddingOnly(top: 8.kh, bottom: 16.kh),
                // Row(
                //   children: [
                //     SizedBox(
                //       width: 55.w,
                //       child: Text(
                //         LocaleKeys.app_departureDate.tr,
                //         style: TextStyleUtil.k14Semibold(),
                //       ),
                //     ),
                //     Flexible(
                //         child: Text(
                //       LocaleKeys.app_time.tr,
                //       style: TextStyleUtil.k14Semibold(),
                //     ))
                //   ],
                // ),

                Text(
                  LocaleKeys.app_dateTime.tr,
                  style: TextStyleUtil.k14Semibold(),
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

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Row(
                    children: [
                      Text(LocaleKeys.app_publicPrivate.tr,) ,
                        InkWell(
                        //     onTap: () => Get.dialog(
                        //   useSafeArea: true,
                        //   Center(
                        //     child: Container(
                        //         padding: EdgeInsets.all(16.kh),
                        //         width: 80.w,
                        //         decoration: BoxDecoration(
                        //           color: ColorUtil.kWhiteColor,
                        //           borderRadius: BorderRadius.circular(8.kh),
                        //         ),
                        //         child: Text(
                        //           "LocaleKeys",
                        //           style: TextStyleUtil.k14Regular(
                        //               color: ColorUtil.kBlack03),
                        //         )),
                        //   ),
                        // )

                            child: SvgPicture.asset(ImageConstant.svgIconInfo,color: ColorUtil.kPrimary01,)),
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
                        inactiveTrackColor: ColorUtil.kPrimary04,
                        activeTrackColor: ColorUtil.kPrimary01,
                        trackOutlineWidth: const MaterialStatePropertyAll(0),
                        thumbColor: const MaterialStatePropertyAll(
                            ColorUtil.kWhiteColor),
                        trackOutlineColor:
                        const MaterialStatePropertyAll(ColorUtil.kNeutral1),
                      ),
                    ),
                  ],
                ),


                // Obx(
                //   () => Visibility(
                //     visible: controller.locationModelNames.isNotEmpty,
                //     child: Text(
                //       LocaleKeys.app_previouslySearched.tr,
                //       style: TextStyleUtil.k14Semibold(),
                //     ).paddingOnly(bottom: 8.kh),
                //   ),
                // ),
                // Obx(
                //   () => Visibility(
                //       visible: controller.locationModelNames.isNotEmpty,
                //       child: SizedBox(
                //         height: 158.kh,
                //         child: ListView.builder(
                //             itemCount: controller.locationModelNames.length,
                //             itemBuilder: (context, index) {
                //               return Container(
                //                 decoration: BoxDecoration(
                //                     color: ColorUtil.kNeutral7.withOpacity(0.5),
                //                     border: Border(
                //                         top: BorderSide.none,
                //                         bottom: BorderSide(
                //                             width: 1.kh,
                //                             color: ColorUtil.kNeutral7)),
                //                     borderRadius: BorderRadius.circular(8.kh)),
                //                 child: ListTile(
                //                   leading: const Icon(
                //                     Icons.history,
                //                     color: ColorUtil.kNeutral4,
                //                   ),
                //                   title: Text(
                //                     "${controller.locationModelNames[index].originLocation?.nameOfLocation.toString().split(",").first} to ${controller.locationModelNames[index].destinationLocation?.nameOfLocation.toString().split(",").first}",
                //                     style: TextStyleUtil.k12Bold(),
                //                   ),
                //                   onTap: () {
                //                     controller.setLocation(index);
                //                   },
                //                 ),
                //               ).paddingOnly(bottom: 2.kh);
                //             }),
                //       )),
                // ),
               const Expanded(child: SizedBox()),
                GreenPoolButton(
                  color:ColorUtil.kPrimary01,
                  padding: const EdgeInsets.all(0),
                  onPressed: () {
                    Get.back();
                  },
                  // isActive: controller.isActive.value,
                  labelColor: Get.find<HomeController>().isPinkModeOn.value
                      ? ColorUtil.kPrimary3PinkMode
                      : ColorUtil.kSecondary01,
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

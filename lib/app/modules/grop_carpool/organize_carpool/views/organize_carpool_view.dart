import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/components/greenpool_appbar.dart';
import 'package:green_pool/app/components/richtext_heading.dart';
import 'package:green_pool/app/constants/image_constant.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../../../../../generated/locales.g.dart';
import '../../../../components/greenpool_textfield.dart';
import '../../../../routes/app_pages.dart';
import '../../../../services/colors.dart';
import '../../../../services/custom_button.dart';
import '../../../../services/storage.dart';
import '../../../../services/text_style_util.dart';
import '../../../home/controllers/home_controller.dart';
import '../controllers/organize_carpool_controller.dart';



class OrganizeCarpoolView extends GetView<OrganizeCarpoolController> {
  const OrganizeCarpoolView({super.key});

  @override
  Widget build(BuildContext context) {
    final isPinkModeOn = Get.find<HomeController>().isPinkModeOn.value;
    final storageService = Get.find<GetStorageService>();

    // final pickedDate = DateTime.now();
    // controller.date.text = pickedDate.toIso8601String();
    // controller.departureDate.text =
    //     "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
    return Scaffold(
      appBar: GreenPoolAppBar(
        title: Text(LocaleKeys.app_organizeCarpool.tr),
      ),
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 12.kh,
                ),
                GreenPoolTextField(
                    hintText: LocaleKeys.app_searchForGroups.tr,
                    controller: controller.searchTextController,
                    onchanged: (v) {

                    },
                    prefix: Icon(
                      Icons.search,
                      color: Get.find<HomeController>().isPinkModeOn.value
                          ? ColorUtil.kPrimary3PinkMode
                          : ColorUtil.kBlack03,
                    ),
                    onPressedSuffix: () {

                    },
                ).paddingOnly(bottom: 22.kh),



                Obx(() =>Row(
                    mainAxisAlignment:    MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: GreenPoolButton(
                          onPressed: () {
                            controller.selectedButton.value = 'request';
                          },
                          label: LocaleKeys.app_requestARide.tr,
                          fontSize: 14.kh,
                          height: 38.kh,
                          // borderColor: Get.find<HomeController>()
                          //     .isPinkModeOn.value
                          //     ? ColorUtil.kPrimary3PinkMode
                          //     : ColorUtil.kSecondary01,
                          // labelColor: Get.find<HomeController>()
                          //     .isPinkModeOn.value
                          //     ? ColorUtil.kPrimary3PinkMode
                          //     : ColorUtil.kSecondary01,
                          color:controller.selectedButton.value == 'request' ? null  : ColorUtil.kBlack08,
                          // borderColor: controller.selectedButton.value == 'request'
                          //     ? (Get.find<HomeController>().isPinkModeOn.value
                          //     ? ColorUtil.kPrimary3PinkMode
                          //     : ColorUtil.kSecondary01)
                          //     : Colors.grey,
                          // labelColor: Get.find<HomeController>()
                          //     .isPinkModeOn.value
                          //     ? ColorUtil.kPrimary3PinkMode
                          //     : ColorUtil.kSecondary01,
                          padding: EdgeInsets.all(0.kh),
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      Expanded(
                        child: GreenPoolButton(
                          height: 40.kh,
                          padding: EdgeInsets.all(8.kh),
                          fontSize: 14.kh,
                          label: LocaleKeys.app_offerARide.tr,
                          onPressed: () async {
                            controller.selectedButton.value = 'offer';

                          },
                          color:controller.selectedButton.value == 'offer' ? null  : ColorUtil.kBlack08,
                          // borderColor: controller.selectedButton.value == 'offer'
                          //     ? ( Get.find<HomeController>().isPinkModeOn.value
                          //     ? ColorUtil.kPrimary3PinkMode
                          //     : ColorUtil.kSecondary01)
                          //     : Colors.grey,
                          // labelColor: Get.find<HomeController>()
                          //     .isPinkModeOn.value
                          //     ? ColorUtil.kPrimary3PinkMode
                          //     : ColorUtil.kSecondary01,
                        ),
                      ),
                    ],
                  ).paddingOnly(bottom: 25.kh),
                ),
                Text(
                  LocaleKeys.app_upcomingEvents.tr,
                  style: TextStyleUtil.k20Heading700(),
                ).paddingOnly(bottom: 4.kh),

                SizedBox(
                  height: 435.kh,
                  child: ListView.builder(
                    shrinkWrap: true,
                    // physics: const NeverScrollableScrollPhysics(),
                    itemCount: 10,
                    itemBuilder: (context, itemsIndex) {
                      return InkWell(
                        onTap: () {
                          Get.toNamed(Routes.EVENT_DETAILS, arguments:false);
                        },
                        child: Container(
                          child: ListTile(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.kh)),
                            minVerticalPadding: 12.kh,
                            title: Text(
                              "Toronto Tech Fest",
                              style: TextStyleUtil.k14Bold(),
                            ),
                            subtitle: Text(
                              "8:00 AM - 9:00 AM",
                              style: TextStyleUtil.k14Regular(color: Color(0xFF6B7582)),
                            ),

                            leading: Container(
                              padding: EdgeInsets.all(16.kh),
                              height: 212.kh,
                              width: 15.w,
                              decoration: BoxDecoration(
                                color: ColorUtil.kBlack08,
                                borderRadius: BorderRadius.circular(8.kh),
                              ),
                              alignment: Alignment.center,
                              child: SvgPicture.asset(
                                ImageConstant.svgProfileCar,
                                // width: 30,
                                // height: 30,
                                colorFilter: ColorFilter.mode(
                                    isPinkModeOn
                                        ? ColorUtil.kPrimary3PinkMode
                                        : ColorUtil.kSecondary01,
                                    BlendMode.srcIn),
                              ),
                            ),
                            trailing:
                            InkWell(onTap: () {

                            },child: SvgPicture.asset(ImageConstant.svgNavMessages)),

                            // trailing:   SvgPicture.asset(
                            //   ImageConstant.svgNavMessagesFilled,
                            //   colorFilter: ColorFilter.mode(
                            //     Get.find<GetStorageService>().isPinkMode
                            //         ? ColorUtil.kPrimary3PinkMode
                            //         : ColorUtil.kSecondary01,
                            //     BlendMode.srcIn,
                            //   ),
                            // ),
                          ).paddingOnly(bottom: 4.kh),
                        ),
                      );
                    },
                  ),
                ),






                const Expanded(child: SizedBox()),
                GreenPoolButton(
                  padding: const EdgeInsets.all(0),
                  fontSize: 18.kh,
                  onPressed: () => controller.moveToMatchingRides(),
                  label: LocaleKeys.app_createNewEvent.tr,
                ).paddingOnly(bottom: 30.kh),
              ],
            ).paddingSymmetric(horizontal: 16.kw),
          ),

        ],
      ),
    );
  }
}

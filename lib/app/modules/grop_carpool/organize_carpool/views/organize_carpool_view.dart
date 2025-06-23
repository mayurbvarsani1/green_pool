import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/components/greenpool_appbar.dart';
import 'package:green_pool/app/components/richtext_heading.dart';
import 'package:green_pool/app/constants/image_constant.dart';
import 'package:green_pool/app/modules/chat_page/views/chat_page_view.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../../../../../generated/locales.g.dart';
import '../../../../components/common_image_view.dart';
import '../../../../components/gp_progress.dart';
import '../../../../components/greenpool_textfield.dart';
import '../../../../data/event_list_model.dart';
import '../../../../routes/app_pages.dart';
import '../../../../services/colors.dart';
import '../../../../services/custom_button.dart';
import '../../../../services/storage.dart';
import '../../../../services/text_style_util.dart';
import '../../../home/controllers/home_controller.dart';
import '../../event_details/controllers/event_details_controller.dart';
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
                    onchanged: (value) {
                        controller.onSearchTextChanged(value);
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
                            controller.searchTextController.clear();
                            controller.selectedButton.value = 'request';
                            controller.getEventAPI();
                            FocusManager.instance.primaryFocus?.unfocus();

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
                            controller.searchTextController.clear();
                            controller.selectedButton.value = 'offer';
                            controller.getEventAPI(isOfferRide: true);
                            FocusManager.instance.primaryFocus?.unfocus();


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
                  controller.selectedButton.value == 'request'  ? LocaleKeys.app_upcomingEvents.tr  : LocaleKeys.app_myEvent.tr ,
                  style: TextStyleUtil.k20Heading700(),
                ).paddingOnly(bottom: 4.kh),
                controller.isLoad.value
                    ? Padding(
                      padding: EdgeInsets.only(top: 200.0.kh),
                      child: const Column(
                        children: [
                          GpProgress(),
                        ],
                      ),
                    )
                    : controller.eventData.isEmpty
                    ? Padding(
                    padding: EdgeInsets.only(top: 25.0.kh),
                    child: Center(
                      child: CommonImageView(
                        fit: BoxFit.fitWidth,
                        width: Get.width,
                        imagePath: ImageConstant.eventNotFound,
                      )
                    ))
                    :
                SizedBox(
                  height: 435.kh,
                  child: ListView.builder(
                    shrinkWrap: true,
                    // physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.eventData.length,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, itemsIndex) {
                      Doc?  eventData  = controller.eventData[itemsIndex];
                      return InkWell(
                        onTap: () {
                          debugPrint("eventData.id=>${eventData.id}");
                          // Get.lazyPut(()=>EventDetailsController().eventDetailAPI(eventData.id ?? ""));
                          EventDetailsController  eventIdController  = Get.put(EventDetailsController());
                          eventIdController.eventDetailAPI(eventData.id ?? "");
                          Get.toNamed(Routes.EVENT_DETAILS, arguments:false);
                        },
                        child: ListTile(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.kh)),
                          minVerticalPadding: 12.kh,
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                            eventData.title?.capitalizeFirst ?? "",
                            style: TextStyleUtil.k18Bold(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Text(
                           controller.formatDateAndTime( eventData.date ?? DateTime.now(),  eventData.time ?? DateTime.now()),
                          style: TextStyleUtil.k16Regular(color: const Color(0xFF6B7582)),
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
                          // trailing:InkWell(onTap: () {
                          //
                          //   debugPrint("/*-/*/*-/-*/*-/*-/*-/*/-*/-");
                          //   // Get.to(()=>ChatPageView());
                          //   Get.toNamed(Routes.GROUP_CHAT, arguments: false);
                          //   debugPrint("*-*-**-*-*-*-*-*-*-*-*");
                          //
                          // },child: SvgPicture.asset(ImageConstant.svgNavMessages)),

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

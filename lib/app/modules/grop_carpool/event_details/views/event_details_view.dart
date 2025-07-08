import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/components/greenpool_appbar.dart';
import 'package:green_pool/app/constants/image_constant.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import '../../../../../generated/locales.g.dart';
import '../../../../components/common_image_view.dart';
import '../../../../components/gp_progress.dart';
import '../../../../data/chat_arg.dart';
import '../../../../routes/app_pages.dart';
import '../../../../services/colors.dart';
import '../../../../services/custom_button.dart';
import '../../../../services/storage.dart';
import '../../../../services/text_style_util.dart';
import '../../../home/controllers/home_controller.dart';
import '../controllers/event_details_controller.dart';

class EventDetailsView extends GetView<EventDetailsController> {
  const EventDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final isPinkModeOn = Get.find<HomeController>().isPinkModeOn.value;
    return Scaffold(
      // backgroundColor: ColorUtil.kWhiteColor,
      appBar: GreenPoolAppBar(
        title: Text(LocaleKeys.app_eventDetails.tr),
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Padding(
            padding: EdgeInsets.all(8.kh),
            child: SvgPicture.asset(
              ImageConstant.svgIconBack30,
              color: ColorUtil.kBlack011,
              height: 24.kh,
              width: 24.kw,
            ),
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(height: 12.kh),
              CommonImageView(
                fit: BoxFit.fitWidth,
                width: Get.width,
                imagePath: ImageConstant.eventGroup,
              ).paddingOnly(bottom: 25.kh),

              Expanded(
                child: Obx(
                  ()=>  controller.isLoad.value
                      ? const GpProgress()
                      :
                      Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.eventDetailsData.value?.data?.event?.title?.capitalizeFirst ?? "",

                        style: TextStyleUtil.k18Bold(),
                      ).paddingOnly(bottom: 8.kh),
                      Text(


                        controller.formatDateTime(controller.eventDetailsData.value?.data?.event?.time ?? DateTime.now()),

                        style:
                            TextStyleUtil.k14Regular(color: ColorUtil.kBlack010),
                      ).paddingOnly(bottom: 15.kh),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.kh)),
                        minVerticalPadding: 12.kh,
                        title: Text(
                          LocaleKeys.app_eventLocation.tr,
                          style: TextStyleUtil.k14Medium(fontSize: 16),
                        ),
                        subtitle: Text(
                          controller.eventDetailsData.value?.data?.event?.destination?.name ?? "",
                          // "Central Park, New York",
                          style: TextStyleUtil.k14Regular(
                              color: ColorUtil.kBlack010),
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
                            ImageConstant.locationRing,
                            // width: 30,
                            // height: 30,
                            colorFilter: ColorFilter.mode(
                                isPinkModeOn? ColorUtil.kPrimary3PinkMode: ColorUtil.kSecondary01,BlendMode.srcIn),
                          ),
                        ),
                      ).paddingOnly(bottom: 4.kh),

                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.kh)),
                        minVerticalPadding: 12.kh,
                        title: Text(
                          LocaleKeys.app_attendees.tr,
                          style: TextStyleUtil.k14Bold(),
                        ),
                        subtitle: Text(
                          "${controller.eventDetailsData.value?.data?.totalUsers ?? ""}/${controller.eventDetailsData.value?.data?.event?.expectedAttendees ?? ""} attendees",
                          style: TextStyleUtil.k14Regular(
                              color: ColorUtil.kBlack010),
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
                            ImageConstant.userRing,

                            colorFilter: ColorFilter.mode(
                                isPinkModeOn
                                    ? ColorUtil.kPrimary3PinkMode
                                    : ColorUtil.kSecondary01,
                                BlendMode.srcIn),
                          ),
                        ),

                        trailing:Visibility(
                          visible: !(controller.eventDetailsData.value?.data?.isAvailable ?? false),
                          child: InkWell(
                              onTap: () {

                            Get.toNamed(Routes.GROUP_CHAT, arguments: {
                                "chatArg": ChatArg(
                                  chatRoomId: controller.eventDetailsData.value?.chatRoomId  ?? "",
                                  id: Get.find<GetStorageService>().getUserAppId,
                                  image: Get.find<GetStorageService>().profilePicUrl,
                                  name: controller.eventDetailsData.value?.data?.event?.title ?? "",
                                  eventId: controller.eventDetailsData.value?.data?.event?.id  ?? "",
                                  deleteUpdateTime: "${controller.eventDetailsData.value?.deleteUpdateTime ?? ""}"  ,

                                ),

                            });
                          },child: SvgPicture.asset(ImageConstant.svgNavMessages)),
                        ),
                      ).paddingOnly(bottom: 4.kh),
                      Text(
                        LocaleKeys.app_going.tr,
                        style: TextStyleUtil.k18Bold(),
                      ).paddingOnly(bottom: 15.kh),
                      SizedBox(
                        height: 52,
                        child: ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.eventDetailsData.value?.data?.users?.length,
                          // itemCount: 100,
                          itemBuilder: (context, index) {
                               var userProfile =   controller.eventDetailsData.value?.data?.users?[index];
                            return Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Container(
                                    width: 50,
                                    height: 50,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: ColorUtil.kBackgroundColor,
                                        borderRadius:
                                            BorderRadius.circular(100))),

                                Positioned(
                                  left: 7,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: CommonImageView(
                                        height: 52,
                                        width: 52,
                                        fit: BoxFit.cover,
                                        alignment: Alignment.topCenter,
                                        url: userProfile?.profilePic?.url ?? ""),
                                  ),
                                )

                              ],
                            );
                          },
                        ),
                      ),


                      const Expanded(child: SizedBox()),

                      Obx(
                        () {
                          final isAvailable = controller.eventDetailsData.value?.data?.isAvailable ?? false;
                          return GreenPoolButton(
                            width: 124.kw,
                            height: 40.kh,
                            padding: const EdgeInsets.all(0),
                            isActive: isAvailable,
                            onPressed: () {
                              controller.jointEventAPI(controller.eventDetailsData.value?.data?.event?.id ?? "");
                            },
                            label: LocaleKeys.app_joinEvent.tr,
                          ).paddingOnly(bottom: 30.kh);
                          }
                      ),
                    ],
                  ).paddingSymmetric(horizontal: 16.kw),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
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
import '../../../../components/common_image_view.dart';
import '../../../../components/greenpool_textfield.dart';
import '../../../../services/colors.dart';
import '../../../../services/custom_button.dart';
import '../../../../services/text_style_util.dart';
import '../../../home/controllers/home_controller.dart';
import '../controllers/event_details_controller.dart';



class EventDetailsView extends GetView<EventDetailsController> {
  const EventDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final isPinkModeOn = Get.find<HomeController>().isPinkModeOn.value;
    // final pickedDate = DateTime.now();
    // controller.date.text = pickedDate.toIso8601String();
    // controller.departureDate.text =
    //     "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
    return Scaffold(
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
              // RichTextHeading(text: LocaleKeys.app_pickup.tr).paddingOnly(top: 12.kh),
              CommonImageView(
                 fit: BoxFit.fitWidth,
                width: Get.width,
                imagePath: ImageConstant.eventUserLogo,
              ).paddingOnly(bottom: 25.kh),
              Text(
                "Toronto Tech Fest",
                style: TextStyleUtil.k18Bold(),
              ).paddingOnly(bottom: 8.kh),

              Text(
                'Saturday, July 15, 2023 · 12:00 PM',
                style: TextStyleUtil.k14Regular(color: ColorUtil.kBlack010),
              ).paddingOnly(bottom: 15.kh),

        ListTile(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.kh)),
          minVerticalPadding: 12.kh,
          title: Text(
            LocaleKeys.app_eventLocation.tr,
            style: TextStyleUtil.k14Medium(fontSize: 16),
          ),
          subtitle: Text(
            "Central Park, New York",
            style: TextStyleUtil.k14Regular(color: ColorUtil.kBlack010),

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
                  isPinkModeOn
                      ? ColorUtil.kPrimary3PinkMode
                      : ColorUtil.kSecondary01,
                  BlendMode.srcIn),
            ),
          ),
        ).paddingOnly(bottom: 4.kh),

        ListTile(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.kh)),
          minVerticalPadding: 12.kh,
          title: Text(
            LocaleKeys.app_attendees.tr,
            style: TextStyleUtil.k14Bold(),
          ),
          subtitle: Text(
            "150+ attendees",
            style: TextStyleUtil.k14Regular(color: ColorUtil.kBlack010),
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
              // width: 30,
              // height: 30,
              colorFilter: ColorFilter.mode(
                  isPinkModeOn
                      ? ColorUtil.kPrimary3PinkMode
                      : ColorUtil.kSecondary01,
                  BlendMode.srcIn),
            ),
          ),
        ).paddingOnly(bottom: 4.kh),


              Text(
                LocaleKeys.app_going.tr,

                style: TextStyleUtil.k18Bold(),
              ).paddingOnly(bottom: 8.kh),






              const Expanded(child: SizedBox()),
              GreenPoolButton(
                width: 124.kw,
                height: 40.kh,
                padding: const EdgeInsets.all(0),
                onPressed: () {

                },
                // isActive: controller.isActive.value,
                label: LocaleKeys.app_joinEvent.tr,
              ).paddingOnly(bottom: 30.kh),
            ],
          ).paddingSymmetric(horizontal: 16.kw),
        ],
      ),
    );
  }
}

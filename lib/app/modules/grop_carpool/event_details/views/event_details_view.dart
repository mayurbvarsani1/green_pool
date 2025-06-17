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
        title: Text(LocaleKeys.app_findRide.tr),
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
              ),
              Text(
                LocaleKeys.app_pickup.tr,
                style: TextStyleUtil.k14Semibold(),
              ).paddingOnly(top: 12.kh),

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

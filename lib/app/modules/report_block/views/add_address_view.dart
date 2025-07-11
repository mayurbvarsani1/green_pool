import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/components/greenpool_appbar.dart';
import 'package:green_pool/app/constants/image_constant.dart';
import 'package:green_pool/app/modules/report_block/controllers/report_block_controller.dart';
import 'package:green_pool/app/services/custom_button.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import '../../../../generated/locales.g.dart';
import '../../../components/greenpool_textfield.dart';
import '../../../services/colors.dart';
import '../../../services/text_style_util.dart';
import '../../home/controllers/home_controller.dart';


class AddAddressView extends GetView<ReportBlockController> {
  AddAddressView({super.key});
  ReportBlockController   controller  = Get.put(ReportBlockController());
  @override
  Widget build(BuildContext context) {
    final isPinkModeOn = Get.find<HomeController>().isPinkModeOn.value;
    return Scaffold(
      appBar: GreenPoolAppBar(
        title: Text(LocaleKeys.app_addressInfo.tr),
        actions: [
          GestureDetector(
            onTap: () {

            },
            child: Text(LocaleKeys.app_remove,style: TextStyleUtil.k14Medium(color: ColorUtil.kError6,))
                .paddingOnly(right: 16.kw),
          ),
        ],
      ),
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Obx(
                () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // app_remove
                SizedBox(height: 12.kh,),
                 Text(LocaleKeys.app_addressLabel.tr,style: TextStyleUtil.k16Semibold(fontWeight: FontWeight.w600, fontSize: 16)),

                GreenPoolTextField(
                  textStyle: TextStyleUtil.k14Medium(color: ColorUtil.kBlack01),
                  hintText: LocaleKeys.app_alexsHome.tr,
                  keyboardType: TextInputType.streetAddress,
                  onchanged: (v) {
                    controller.setActiveState();
                  },
                  onTap: () {
                    controller.moveToSetOrigin();
                  },
                  controller: controller.riderOriginTextController,
                  suffix: controller.isOriginAdded.value
                      ? InkWell(
                      onTap: () => controller.removeOrigin(),
                      child: const Icon(Icons.cancel))
                      : const SizedBox(),
                ).paddingOnly(top: 8.kh, bottom: 20.kh),
                Text(
                  LocaleKeys.app_address.tr,
                  style: TextStyleUtil.k16Semibold(fontWeight: FontWeight.w600, fontSize: 16),
                ),
                GreenPoolTextField(
                  textStyle: TextStyleUtil.k14Medium(color: ColorUtil.kBlack01),
                  hintText: LocaleKeys.app_enterAddressDestination.tr,
                  keyboardType: TextInputType.streetAddress,
                  onchanged: (v) {
                    controller.setActiveState();
                  },
                  onTap: () {
                    controller.moveToSetOrigin();
                  },
                  controller: controller.riderOriginTextController,

                  prefix: SvgPicture.asset(
                    ImageConstant.location,
                    // width: 30,
                    // height: 30,
                    colorFilter: ColorFilter.mode(
                        isPinkModeOn? ColorUtil.kPrimary3PinkMode: ColorUtil.kSecondary01,BlendMode.srcIn),
                  ),
                  // prefix: Icon(
                  //   Icons.location_on,
                  //   size: 24.kh,
                  //   color: isPinkModeOn ? ColorUtil.kPrimary3PinkMode : ColorUtil.kSecondary01,
                  // ),
                  suffix: controller.isOriginAdded.value
                      ? InkWell(
                      onTap: () => controller.removeOrigin(),
                      child: const Icon(Icons.cancel))
                      : const SizedBox(),
                ).paddingOnly(top: 8.kh, bottom: 20.kh),

                const Expanded(child: SizedBox()),
                GreenPoolButton(
                  padding: const EdgeInsets.all(0),
                  onPressed: () {

                  },
                  // isActive: controller.isActive.value,
                  label: LocaleKeys.app_saveAndContinue.tr,
                ).paddingOnly(bottom: 30.kh),

              ],
            ).paddingSymmetric(horizontal: 16.kw),
          ),
        ],
      ),
    );
  }
}

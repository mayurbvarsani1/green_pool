import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/components/common_image_view.dart';
import 'package:green_pool/app/components/gp_progress.dart';
import 'package:green_pool/app/constants/image_constant.dart';
import 'package:green_pool/app/modules/home/controllers/home_controller.dart';
import 'package:green_pool/app/services/colors.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import 'package:green_pool/app/services/text_style_util.dart';

import '../../../../generated/locales.g.dart';
import '../../../components/greenpool_appbar.dart';
import '../../../res/strings.dart';
import '../controllers/wallet_controller.dart';

class WalletView extends GetView<WalletController> {
  const WalletView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: GreenPoolAppBar(
          title: Text(LocaleKeys.app_wallet.tr),
        ),
        body: Obx(
          () => controller.isLoad.value
              ? const GpProgress()
              : Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.kw, vertical: 24.kh),
                      width: 100.w,
                      height: 188.kh,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.kh),
                          gradient:
                              Get.find<HomeController>().isPinkModeOn.value
                                  ? const LinearGradient(colors: [
                                      ColorUtil.kSecondaryPinkMode,
                                      ColorUtil.kPrimaryPinkMode
                                    ])
                                  : const LinearGradient(colors: [
                                      ColorUtil.kPrimary04,
                                      ColorUtil.kPrimary01
                                    ])),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            LocaleKeys.app_carpoollCash.tr,
                            style: TextStyleUtil.k18Heading600(),
                          ).paddingOnly(bottom: 16.kh),
                          Text(
                            "${LocaleKeys.app_dollar.tr} ${controller.walletBalance.value}",
                            style: TextStyleUtil.k32Heading700(
                                color: ColorUtil.kSecondary01),
                          ).paddingOnly(bottom: 20.kh),
                          /*Container(
                            width: 126.kw,
                            padding: EdgeInsets.symmetric(
                                horizontal: 24.kw, vertical: 8.kh),
                            decoration: BoxDecoration(
                                color: Get.find<HomeController>()
                                        .isPinkModeOn
                                        .value
                                    ? ColorUtil.kPrimary2PinkMode
                                    : ColorUtil.kSecondary01,
                                borderRadius: BorderRadius.circular(80.kh)),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.add,
                                  color: Get.find<HomeController>()
                                          .isPinkModeOn
                                          .value
                                      ? ColorUtil.kSecondary01
                                      : ColorUtil.kWhiteColor,
                                  size: 16.kh,
                                ).paddingOnly(right: 3.kw),
                                Text(
                                  LocaleKeys.app_giftCard.tr,
                                  style: TextStyleUtil.k14Semibold(
                                      color: Get.find<HomeController>()
                                              .isPinkModeOn
                                              .value
                                          ? ColorUtil.kSecondary01
                                          : ColorUtil.kWhiteColor),
                                )
                              ],
                            ),
                          ),*/

                        ],
                      ),
                    ).paddingOnly(top: 32.kh, bottom: 24.kh),
                    WalletTile(
                      title: LocaleKeys.app_addMoneyToWallet.tr,
                      path: ImageConstant.svgAddMoney,
                      onTap: () => controller.addMoney(),
                    ).paddingOnly(bottom: 8.kh),
                    WalletTile(
                      title: LocaleKeys.app_payout.tr,
                      path: ImageConstant.svgSendMoney,
                      onTap: () => controller.sendMoney(),
                    ).paddingOnly(bottom: 8.kh),
                    WalletTile(
                      title: LocaleKeys.app_transactionHistory.tr,
                      path: ImageConstant.svgTransactionHistory,
                      onTap: () => controller.history(),
                    ),
                  ],
                ).paddingSymmetric(horizontal: 16.kw),
        ));
  }
}

class WalletTile extends StatelessWidget {
  final String title, path;
  final Function() onTap;

  const WalletTile({
    super.key,
    required this.title,
    required this.path,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 68.kh,
      child: ListTile(
        tileColor: ColorUtil.kWhiteColor,
        onTap: onTap,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.kh)),
        title: Text(
          title,
          style: TextStyleUtil.k14Semibold(),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 24.kw, vertical: 8.kh),
        leading: Container(
          height: 48.kh,
          width: 48.kw,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: ColorUtil.kBlack07,
              borderRadius: BorderRadius.circular(12.kh)),
          child: SvgPicture.asset(
            path,
            height: 24.kh,
            colorFilter: ColorFilter.mode(
                Get.find<HomeController>().isPinkModeOn.value
                    ? ColorUtil.kPrimary3PinkMode
                    : ColorUtil.kSecondary01,
                BlendMode.srcIn),
          ),
        ),
        trailing: CommonImageView(svgPath: ImageConstant.svgIconRightArrow),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/components/common_image_view.dart';
import 'package:green_pool/app/components/greenpool_appbar.dart';
import 'package:green_pool/app/components/greenpool_textfield.dart';
import 'package:green_pool/app/modules/home/controllers/home_controller.dart';
import 'package:green_pool/app/modules/my_rides_one_time/views/my_rides_one_time_view.dart';
import 'package:green_pool/app/modules/report_block/views/report_details_view.dart';
import 'package:green_pool/app/services/colors.dart';
import 'package:green_pool/app/services/custom_button.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import 'package:green_pool/app/services/text_style_util.dart';
import '../../../../generated/locales.g.dart';
import '../../../constants/image_constant.dart';
import '../controllers/report_block_controller.dart';

class ReportBlockView extends GetView<ReportBlockController> {
  const ReportBlockView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: GreenPoolAppBar(
          title: Text(LocaleKeys.app_reportBlock.tr),
        ),
        resizeToAvoidBottomInset: false,
        body: SafeArea(
            child: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              TabBar(
                  onTap: (index) async {
                    if (index == 0) {
                      // await Get.find<MyRidesOneTimeController>()
                      //     .myRidesAPI(isRecurring: true);
                    } else {
                      // await Get.find<MyRidesOneTimeController>()
                      //     .myRidesAPI();
                    }
                  },
                  indicatorSize: TabBarIndicatorSize.tab,
                  splashBorderRadius: BorderRadius.circular(4.kh),
                  unselectedLabelStyle:
                      TextStyleUtil.k14Semibold(color: ColorUtil.kSecondary01),
                  labelStyle: TextStyleUtil.k14Semibold(
                    color: Get.find<HomeController>().isPinkModeOn.value
                        ? ColorUtil.kPrimary3PinkMode
                        : ColorUtil.kSecondary01,
                  ),
                  overlayColor: MaterialStatePropertyAll(
                      ColorUtil.kSecondary01.withOpacity(0.05)),
                  indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(
                        color: Get.find<HomeController>().isPinkModeOn.value
                            ? ColorUtil.kPrimary3PinkMode
                            : ColorUtil.kSecondary01,
                        width: 2.kh),
                  ),
                  isScrollable: false,
                  labelColor: Get.find<HomeController>().isPinkModeOn.value
                      ? ColorUtil.kPrimary3PinkMode
                      : ColorUtil.kSecondary01,
                  tabs: [
                    Tab(
                      child: Text(
                        LocaleKeys.app_report.tr,
                      ),
                    ),
                    Tab(
                      child: Text(
                        LocaleKeys.app_block.tr,
                      ),
                    ),

                  ]).paddingSymmetric(horizontal: 16.kw),
              Expanded(
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    ReportScreen(type: LocaleKeys.app_booked.tr),
                    SizedBox(),
                    // MyRidesOneTimeView(type: LocaleKeys.app_published.tr),
                  ],
                ),
              ),
            ],
          ),
        )));
  }
}

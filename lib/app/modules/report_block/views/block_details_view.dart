import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/components/common_image_view.dart';
import 'package:green_pool/app/constants/image_constant.dart';
import 'package:green_pool/app/data/block_list_model.dart';
import 'package:green_pool/app/data/report_list_model.dart';
import 'package:green_pool/app/modules/my_rides_one_time/views/driver_tile.dart';
import 'package:green_pool/app/modules/my_rides_one_time/views/recurring_tile.dart';
import 'package:green_pool/app/modules/my_rides_one_time/views/rider_tile.dart';
import 'package:green_pool/app/modules/report_block/controllers/report_block_controller.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import '../../../../generated/assets.dart';
import '../../../../generated/locales.g.dart';
import '../../../components/gp_progress.dart';
import '../../../services/colors.dart';
import '../../../services/text_style_util.dart';
import '../../home/controllers/home_controller.dart';


class blockUserScreen extends GetView<ReportBlockController> {

  blockUserScreen({super.key,});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ReportBlockController());
    return Scaffold(
      body: SafeArea(
        child: Obx(
              () => controller.isLoad.value
              ? const GpProgress()
              : RefreshIndicator(
            backgroundColor: ColorUtil.kWhiteColor,
            color: Get.find<HomeController>().isPinkModeOn.value
                ? ColorUtil.kPrimary3PinkMode
                : ColorUtil.kPrimary01,
            onRefresh: () async {
              await controller.getBlockListApi();
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [

                   // Visibility(
                   //    visible:
                   //    controller.decideNoRidesVisibilty(type),
                   //    child: SizedBox(
                   //      height: MediaQuery.of(context).size.height -
                   //          200,
                   //      child: const Center(
                   //        child: noBlockFoundScreen(),
                   //      ),
                   //    ),
                   //  )

                      ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: controller.getBlockList.length,
                      itemBuilder: (context, index) {
                        BlockDocList?  blockData =     controller.getBlockList[index];
                        debugPrint("blockData=>$blockData");
                       return Column(
                         children: [
                           Text(blockData?.details ?? "",style: TextStyleUtil.k14Medium(),),
                         ],
                       );
                      },
                    ).paddingOnly(top: 32.kh),

                ],
              ).paddingSymmetric(horizontal: 16.kw),
            ),
          ),
        ),
      ),
    );
  }
}

class noBlockFoundScreen extends StatelessWidget {
  const noBlockFoundScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
            child: Get.find<HomeController>().isPinkModeOn.value
                ? CommonImageView(svgPath: Assets.svgPinkModegirl)
                : SvgPicture.asset(ImageConstant.svgNoRides)),
        20.kheightBox,
        Text(
          LocaleKeys.app_noBlockRecordFound.tr,
          style: TextStyleUtil.k24Heading600(),
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}

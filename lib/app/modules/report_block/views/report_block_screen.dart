import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/components/common_image_view.dart';
import 'package:green_pool/app/components/gp_progress.dart';
import 'package:green_pool/app/components/greenpool_appbar.dart';
import 'package:green_pool/app/constants/image_constant.dart';
import 'package:green_pool/app/data/block_list_model.dart';
import 'package:green_pool/app/modules/home/controllers/home_controller.dart';
import 'package:green_pool/app/services/colors.dart';
import 'package:green_pool/app/services/custom_button.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import 'package:green_pool/app/services/text_style_util.dart';
import 'package:green_pool/generated/assets.dart';
import 'package:intl/intl.dart';
import '../../../../generated/locales.g.dart';
import '../controllers/block_controller.dart';




class ReportListView extends GetView<BlockUserController> {

  ReportListView({super.key,});
  BlockUserController  controller = Get.put(BlockUserController());
  @override
  Widget build(BuildContext context) {
    final isPinkModeOn = Get.find<HomeController>().isPinkModeOn.value;
    return Scaffold(
      appBar: GreenPoolAppBar(
        title: Text(LocaleKeys.app_blocked.tr),
      ),
      resizeToAvoidBottomInset: false,
      body: Obx(
            () =>
            controller.isLoad.value
            ? const GpProgress()
            :
            SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [

                  Visibility(
                     visible:
                     controller.getBlockList.isEmpty,
                     child: SizedBox(
                       height: MediaQuery.of(context).size.height -
                           200,
                       child: const Center(
                         child: noBlockFoundScreen(),
                       ),
                     ),
                   ),

                  ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: controller.getBlockList.length ?? 0,
                    itemBuilder: (context, index) {
                      BlockDocList?  blockData =  controller.getBlockList[index];
                      debugPrint("blockData=>$blockData");
                      return ListTile(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.kh)),
                        minVerticalPadding: 12.kh,
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          blockData?.blockedUser?.fullName?.capitalizeFirst ?? "",
                          style: TextStyleUtil.k16Bold(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text(
                          DateFormat('dd-MM-yyyy').format(blockData?.createdAt ?? DateTime.now()),
                          style: TextStyleUtil.k14Regular(color: const Color(0xFF6B7582),fontWeight: FontWeight.w400),
                        ),
                        leading: Container(
                          // padding: EdgeInsets.all(16.kh),
                          height: 180.kh,
                          width: 12.w,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,color: ColorUtil.kBlack08,
                          ),
                          alignment: Alignment.center,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: CommonImageView(
                                url: "${blockData?.blockedUser?.profilePic?.url}"),
                          ),

                        ),

                        trailing: GreenPoolButton(
                          borderRadius: 10,
                          padding:  EdgeInsets.symmetric(vertical: 0.kh),
                          height: 35.kh,
                          width: 80.kw,
                          onPressed: () {
                            debugPrint("blockDataId=>${blockData?.blockedUser?.id ?? ""}");
                            controller.unblockApi(blockData?.blockedUser?.id ?? "");
                          },
                          label: LocaleKeys.app_unblock.tr,
                            labelColor: ColorUtil.kSecondary01,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.kh,
                          // isActive: controller.isActive.value,
                        ),
                      ).paddingOnly(bottom: 4.kh);
                    },
                  ),

                ],
              ).paddingSymmetric(horizontal: 16.kw,vertical: 10.kw),
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

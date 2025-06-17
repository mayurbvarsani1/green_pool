import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../../../../generated/locales.g.dart';
import '../../../components/common_image_view.dart';
import '../../../components/gp_progress.dart';
import '../../../components/greenpool_textfield.dart';
import '../../../constants/image_constant.dart';
import '../../../services/colors.dart';
import '../../../utils/date_utils.dart';
import '../../../services/storage.dart';
import '../../../services/text_style_util.dart';
import '../../home/controllers/home_controller.dart';
import '../controllers/chat_with_experts_controller.dart';

class ChatWithExpertsView extends GetView<ChatWithExpertsController> {
  const ChatWithExpertsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    controller.getChat();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Get.find<HomeController>().isPinkModeOn.value
            ? ColorUtil.kPrimaryPinkMode
            : ColorUtil.kPrimary01,
        surfaceTintColor: Get.find<HomeController>().isPinkModeOn.value
            ? ColorUtil.kPrimaryPinkMode
            : ColorUtil.kPrimary01,
        elevation: 1,
        toolbarHeight: 64.kh,
        title: Text(
          LocaleKeys.app_helpAndSupport.tr,
          style: TextStyleUtil.k16Bold(),
        ),
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: SvgPicture.asset(
            ImageConstant.svgIconBack,
          ).paddingAll(14.kh),
        ),
      ),
      body: Obx(
        () => controller.isLoad.value
            ? const GpProgress()
            : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: controller.messages.length,
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      controller: controller.scrollController,
                      itemBuilder: (context, index) {
                        final message = controller.messages[index];
                        debugPrint("messages=>${controller.messages.length}");
                        final isSender = message.senderId == Get.find<GetStorageService>().getUserAppId;
                        debugPrint("senderId=>${message.senderId}");
                        final isPinkModeOn = Get.find<HomeController>().isPinkModeOn.value;
                        debugPrint("isPinkModeOn=>$isPinkModeOn");
                        debugPrint("message123=>$message");

                        return Container(
                          padding: EdgeInsets.only(
                              left: 2.kw,
                              right: 2.kw,
                              top: 10.kh,
                              bottom: 10.kh),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: isSender
                                          ? CrossAxisAlignment.end
                                          : CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 60.w,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              bottomLeft:
                                                  Radius.circular(15.kh),
                                              bottomRight:
                                                  Radius.circular(15.kh),
                                              topLeft: Radius.circular(
                                                  isSender ? 15.kh : 0.kh),
                                              topRight: Radius.circular(
                                                  isSender ? 0.kh : 15.kh),
                                            ),
                                            color: isSender
                                                ? isPinkModeOn
                                                    ? ColorUtil
                                                        .kPrimary5PinkMode
                                                    : ColorUtil.kPrimary01
                                                : isPinkModeOn
                                                    ? ColorUtil
                                                        .kPrimary4PinkMode
                                                    : ColorUtil.kSecondary01,
                                          ),
                                          padding: EdgeInsets.symmetric(
                                              vertical: 8.kh,
                                              horizontal: 12.kw),
                                          child: Column(
                                            crossAxisAlignment: isSender
                                                ? CrossAxisAlignment.end
                                                : CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      message.message ?? "",
                                                      style: TextStyleUtil
                                                          .k14Regular(
                                                        color: isSender
                                                            ? isPinkModeOn
                                                                ? ColorUtil
                                                                    .kBlack01
                                                                : ColorUtil
                                                                    .kSecondary01
                                                            : isPinkModeOn
                                                                ? ColorUtil
                                                                    .kBlack01
                                                                : ColorUtil
                                                                    .kPrimary01,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              4.kheightBox, // Add some space between message and time
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    DateTimeUtils.formatTime(message
                                                        .timestamp), // Replace with actual time
                                                    style: TextStyleUtil
                                                        .k10Regular(
                                                      color: isSender
                                                          ? isPinkModeOn
                                                              ? ColorUtil
                                                                  .kBlack03
                                                              : ColorUtil
                                                                  .kSecondary01
                                                          : isPinkModeOn
                                                              ? ColorUtil
                                                                  .kBlack03
                                                              : ColorUtil
                                                                  .kWhiteColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (isSender)
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100.kh),
                                        child: CommonImageView(
                                          url: Get.find<GetStorageService>()
                                              .profilePicUrl,
                                          height: 32.kh,
                                          width: 32.kh,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              if (index == 0 && !controller.isChatStarted.value)
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Visibility(
                                    visible: true,
                                    child: Container(
                                      alignment: Alignment.topLeft,
                                      width: 60.w,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SuggestionsChip(
                                            index: 0,
                                            topic: LocaleKeys.app_wallet.tr,
                                            controller: controller,
                                          ),
                                          SuggestionsChip(
                                            index: 1,
                                            topic: LocaleKeys.app_refund.tr,
                                            controller: controller,
                                          ),
                                          SuggestionsChip(
                                            index: 2,
                                            topic:
                                                LocaleKeys.app_rideRelated.tr,
                                            controller: controller,
                                          ),
                                          SuggestionsChip(
                                            index: 3,
                                            topic: LocaleKeys.app_accRelated.tr,
                                            controller: controller,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ).paddingSymmetric(vertical: 8.kh),
                                ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Obx(
                    () => GreenPoolTextField(
                      controller: controller.eMsg,
                      hintText: LocaleKeys.app_writeMsg.tr,
                      readOnly: !controller.isChatStarted.value,
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.sentences,
                      suffix: InkWell(
                          onTap: () {
                            controller.sendMsg();
                          },
                          child: SvgPicture.asset(ImageConstant.svgIconSend)),
                    ).paddingOnly(bottom: 40.kh, top: 5.kh),
                  )
                ],
              ).paddingSymmetric(horizontal: 16.kw),
      ),
    );
  }
}

class SuggestionsChip extends StatelessWidget {
  final String topic;
  final int index;
  final ChatWithExpertsController controller;
  const SuggestionsChip({
    super.key,
    required this.index,
    required this.topic,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: controller.isChatStarted.value
          ? () {}
          : () {
              controller.chipIndex = index;
              controller.eMsg.text = topic;
            },
      child: IntrinsicWidth(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8.kh, horizontal: 32.kw),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              border: Border.all(
                  color: Get.find<HomeController>().isPinkModeOn.value
                      ? ColorUtil.kPrimaryPinkMode
                      : ColorUtil.kPrimary01),
              borderRadius: BorderRadius.circular(40.kh)),
          child: Text(
            topic,
            style: TextStyleUtil.k14Regular(),
          ),
        ).paddingOnly(bottom: 8.kh),
      ),
    );
  }
}

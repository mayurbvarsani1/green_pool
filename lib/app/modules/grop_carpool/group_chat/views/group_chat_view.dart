import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/components/common_image_view.dart';
import 'package:green_pool/app/components/greenpool_textfield.dart';
import 'package:green_pool/app/constants/image_constant.dart';
import 'package:green_pool/app/services/colors.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import 'package:green_pool/app/services/storage.dart';
import 'package:green_pool/app/services/text_style_util.dart';
import '../../../../../generated/locales.g.dart';
import '../../../../components/gp_progress.dart';
import '../../../../utils/date_utils.dart';
import '../../../chat_page/controllers/chat_page_controller.dart';
import '../../../home/controllers/home_controller.dart';
import '../controllers/group_chat_controller.dart';

class GroupChatView extends GetView<GroupChatController> {
  const GroupChatView({super.key});

  @override
  Widget build(BuildContext context) {
    final isPinkModeOn = Get.find<HomeController>().isPinkModeOn.value;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: isPinkModeOn ? ColorUtil.kPrimaryPinkMode : ColorUtil.kPrimary01,
        surfaceTintColor: isPinkModeOn ? ColorUtil.kPrimaryPinkMode : ColorUtil.kPrimary01,
        elevation: 1,
        toolbarHeight: 64.kh,
        title: Obx(
          () => Row(
            mainAxisSize: MainAxisSize.min,
            children: [

              Icon(Icons.group ,color: ColorUtil.kNeutral5,size: 28.kh,),
              12.kwidthBox,
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.chatArg.value.name ?? "User",

                      style: TextStyleUtil.k14Bold(),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: SvgPicture.asset(
            ImageConstant.svgIconBack,
          ).paddingAll(14.kh),
        ),
        actions: [
          GestureDetector(
            onTap: () => controller.deleteChat(),
            child: const Icon(
              Icons.delete_forever,
              color: ColorUtil.kBlack01,
            ).paddingOnly(right: 14.kh),
          ),
        ],
      ),
      body: Obx(
        () => controller.isLoad.value
            ? const GpProgress()
            : Column(
                children: [

                  Expanded(
                    child: ListView.separated(
                      itemCount: controller.messages.length,
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      controller: controller.scrollController,
                      itemBuilder: (context, index) {
                        final message = controller.messages[index];
                        final isSender = message.senderId == Get.find<GetStorageService>().getUserAppId;

                        return Container(
                          padding: EdgeInsets.only(left: 2.kw, right: 2.kw, top: 10.kh, bottom: 10.kh),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (!isSender)
                                    Padding(
                                      padding: const EdgeInsets.only(right: 8.0),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(100.kh),
                                        child: CommonImageView(
                                          url: message.senderProfilePic,
                                          height: 32.kh,
                                          width: 32.kh,
                                        ),
                                      ),
                                    ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: isSender ? CrossAxisAlignment.end  : CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 60.w,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(15.kh),
                                              bottomRight: Radius.circular(15.kh),topLeft: Radius.circular(isSender ? 15.kh : 0.kh),topRight: Radius.circular(isSender ? 0.kh : 15.kh),),
                                            color: isSender
                                                ? isPinkModeOn? ColorUtil.kPrimary5PinkMode: ColorUtil.kPrimary01: isPinkModeOn
                                                    ? ColorUtil.kPrimary4PinkMode: ColorUtil.kSecondary01,),
                                          padding: EdgeInsets.symmetric(
                                              vertical: 8.kh,
                                              horizontal: 12.kw),
                                          child: Column(
                                            crossAxisAlignment: isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                                            children: [
                                              if(!isSender)
                                              Text( message.senderName?.capitalizeFirst ?? "",style:TextStyleUtil
                                                  .k12Bold(color: ColorUtil.kNeutral1)),

                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Expanded(child: Text(message.message ?? "",
                                                    style: TextStyleUtil.k14Regular(color: isSender? isPinkModeOn? ColorUtil.kBlack01:
                                                    ColorUtil.kSecondary01 : isPinkModeOn? ColorUtil.kBlack01: ColorUtil.kPrimary01,),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              4.kheightBox,

                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    DateTimeUtils.formatTime(message.timestamp),

                                                    style: TextStyleUtil.k10Regular(
                                                      color: isSender ? isPinkModeOn ? ColorUtil.kBlack03 : ColorUtil.kSecondary01
                                                          : isPinkModeOn ? ColorUtil.kBlack03 : ColorUtil.kWhiteColor,
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
                                        borderRadius: BorderRadius.circular(100.kh),
                                        child: CommonImageView(
                                          url: Get.find<GetStorageService>().profilePicUrl,
                                          height: 32.kh,
                                          width: 32.kh,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        final message = controller.messages[index];
                        final messageDate = DateTime(
                          message.timestamp.year,
                          message.timestamp.month,
                          message.timestamp.day,
                        );

                        bool showDate = true;
                        final nextMessage = controller.messages[index + 1];
                        if (index < controller.messages.length - 1) {

                          final nextMessageDate = DateTime(
                            nextMessage.timestamp.year,
                            nextMessage.timestamp.month,
                            nextMessage.timestamp.day,
                          );

                          if (messageDate.isAtSameMomentAs(nextMessageDate)) {
                            showDate = false;
                          }
                        }
                        return Column(
                          children: [
                            if (showDate)
                              Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      DateTimeUtils.isToday(nextMessage.timestamp) ? LocaleKeys.app_today.tr : DateFormat.E().format(nextMessage.timestamp),
                                      style: TextStyleUtil.k14Regular(),
                                    ),
                                    Text(
                                      DateTimeUtils.formatDateddMMMyyyy(nextMessage.timestamp.toString()),
                                      style: TextStyleUtil.k12Regular(color: ColorUtil.kBlack04),
                                    ),
                                  ],
                                ).paddingOnly(top: 8.kh),
                              ),
                          ],
                        );
                      },
                    ),
                  ),
                  // Visibility(
                  //   visible: controller.isWarningVisible.value,
                  //   child: WarningMsg(
                  //       controller: controller, isPinkModeOn: isPinkModeOn),
                  // ),
                  GreenPoolTextField(
                    controller: controller.eMsg,
                    hintText: LocaleKeys.app_writeMsg.tr,
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.sentences,
                    suffix: InkWell(
                        onTap: () => controller.sendMsg(),
                        // onTap: () => controller.sendChatAPI(),
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        child: SvgPicture.asset(ImageConstant.svgIconSend)),
                  ).paddingOnly(bottom: 20.kh, top: 5.kh)
                ],
              ).paddingSymmetric(horizontal: 16.kw),
      ),
    );
  }
}

class PayNowBtn extends StatelessWidget {
  const PayNowBtn({
    super.key,
    required this.controller,
    required this.isPinkModeOn,
  });

  final ChatPageController controller;
  final bool isPinkModeOn;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        controller.moveToPaymentFromConfirmSection();
      },
      child: Container(
        padding: EdgeInsets.all(16.kh),
        decoration: BoxDecoration(
            color: isPinkModeOn
                ? ColorUtil.kPrimaryPinkMode.withOpacity(0.8)
                : ColorUtil.kSecondary07,
            borderRadius: BorderRadius.circular(8.kh)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${LocaleKeys.app_payNow.tr}!",
              style: TextStyleUtil.k14Semibold(),
            ),
            CommonImageView(
              svgPath: ImageConstant.svgIconRightArrow,
            )
          ],
        ),
      ).paddingOnly(top: 16.kh),
    );
  }
}

class WarningMsg extends StatelessWidget {
  const WarningMsg({
    super.key,
    required this.controller,
    required this.isPinkModeOn,
  });

  final ChatPageController controller;
  final bool isPinkModeOn;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
            padding: EdgeInsets.all(16.kh),
            decoration: BoxDecoration(
                color: isPinkModeOn
                    ? ColorUtil.kPrimary5PinkMode
                    : ColorUtil.kSecondary07,
                borderRadius: BorderRadius.circular(8.kh)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.warning_amber_rounded)
                    .paddingOnly(right: 8.kw),
                Expanded(
                  child: Text(
                    LocaleKeys.app_payNowWarning.tr,
                    style: TextStyleUtil.k14Regular(),
                  ),
                )
              ],
            )),
        // )).paddingOnly(top: 16.kh),
        Obx(() {
          return LinearProgressIndicator(
            value: controller.progress.value,
            minHeight: 4.0,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8.kh),
                bottomRight: Radius.circular(8.kh)),
            color: isPinkModeOn
                ? ColorUtil.kPrimary3PinkMode
                : ColorUtil.kSecondary01,
            backgroundColor: isPinkModeOn
                ? ColorUtil.kPrimary5PinkMode
                : ColorUtil.kSecondary07,
          );
        }),
      ],
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
//
// import 'package:get/get.dart';
// import 'package:green_pool/app/modules/home/controllers/home_controller.dart';
// import 'package:green_pool/app/services/colors.dart';
// import 'package:green_pool/app/services/custom_button.dart';
// import 'package:green_pool/app/services/responsive_size.dart';
// import 'package:green_pool/app/services/text_style_util.dart';
//
// import '../../../../generated/locales.g.dart';
// import '../../../components/common_image_view.dart';
// import '../../../components/greenpool_appbar.dart';
// import '../../../utils/date_utils.dart';
// import '../controllers/messages_controller.dart';
//
// class MessagesView extends GetView<MessagesController> {
//   const MessagesView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     Get.lazyPut(() => MessagesController());
//     controller.getMessageListAPI();
//     return Scaffold(
//         appBar: GreenPoolAppBar(
//           title: Text(LocaleKeys.app_messages.tr),
//           leading: const SizedBox(),
//           actions: [
//             GreenPoolButton(
//               onPressed: () {
//                 controller.moveToUnarchive();
//               },
//               isBorder: true,
//               label: LocaleKeys.app_archived.tr,
//               height: 24.kh,
//               width: 76.kw,
//               fontSize: 12.kh,
//               padding: const EdgeInsets.all(0),
//               borderColor: Get.find<HomeController>().isPinkModeOn.value
//                   ? ColorUtil.kPrimary3PinkMode
//                   : ColorUtil.kSecondary01,
//               labelColor: Get.find<HomeController>().isPinkModeOn.value
//                   ? ColorUtil.kPrimary3PinkMode
//                   : ColorUtil.kSecondary01,
//             ).paddingOnly(right: 16.kw)
//           ],
//         ),
//         body: Obx(
//           () => RefreshIndicator(
//             backgroundColor: ColorUtil.kWhiteColor,
//             color: Get.find<HomeController>().isPinkModeOn.value
//                 ? ColorUtil.kPrimary3PinkMode
//                 : ColorUtil.kPrimary01,
//             key: controller.refreshIndicatorKey,
//             onRefresh: () async {
//               await controller.refreshMessageListAPI();
//             },
//             child: controller.isLoading.value
//                 ? const LoadingWidget()
//                     .paddingOnly(left: 16.kw, right: 16.kw, top: 8.kh)
//                 : controller.messagesModel.value.chatRoomIds?.isEmpty ?? true
//                     ? Center(
//                         child: Text(
//                           //implement a text button to see archived msgs
//                           LocaleKeys.app_yourFutureMsgsWillApearHere.tr,
//                           style: TextStyleUtil.k24Heading600(),
//                           textAlign: TextAlign.center,
//                         ),
//                       ).paddingSymmetric(horizontal: 16.kw)
//                     : ListView.builder(
//                         itemCount:
//                             controller.messagesModel.value.chatRoomIds!.length,
//                         itemBuilder: (context, index) {
//                           final message = controller
//                               .messagesModel.value.chatRoomIds?[index];
//                           final isPinkModeOn =
//                               Get.find<HomeController>().isPinkModeOn.value;
//                           final messageRead = controller.messagesModel.value
//                                       .chatRoomIds?[index]?.unReadCount ==
//                                   0 ||
//                               controller.messagesModel.value.chatRoomIds?[index]
//                                       ?.unReadCount ==
//                                   null;
//                           return Slidable(
//                             startActionPane: ActionPane(
//                                 motion: const DrawerMotion(),
//                                 children: [
//                                   IconTheme(
//                                     data: IconThemeData(
//                                       color: isPinkModeOn
//                                           ? ColorUtil.kPrimary4PinkMode
//                                           : ColorUtil.kPrimary01,
//                                     ),
//                                     child: SlidableAction(
//                                       onPressed: (context) {
//                                         controller.archiveMsgAPI(
//                                             message?.chatRoomId ?? "");
//                                       },
//                                       icon: Icons.archive,
//                                       autoClose: true,
//                                       label: LocaleKeys.app_archive.tr,
//                                       backgroundColor: isPinkModeOn
//                                           ? ColorUtil.kPrimary3PinkMode
//                                           : ColorUtil.kSecondary01,
//                                       foregroundColor: isPinkModeOn
//                                           ? ColorUtil.kPrimary4PinkMode
//                                           : ColorUtil.kPrimary01,
//                                     ),
//                                   )
//                                 ]),
//                             child: MessageTile(
//                               onTap: () {
//                                 controller.getToChatPage(message, controller.refreshIndicatorKey);
//                               },
//                               tileColor: messageRead
//                                   ? ColorUtil.kWhiteColor
//                                   : isPinkModeOn
//                                       ? ColorUtil.kPrimary5PinkMode
//                                           .withOpacity(0.3)
//                                       : ColorUtil.kSecondary07.withOpacity(0.3),
//                               borderSide: messageRead
//                                   ? BorderSide.none
//                                   : BorderSide(
//                                       color: isPinkModeOn
//                                           ? ColorUtil.kPrimary5PinkMode
//                                           : ColorUtil.kSecondary07),
//                               title: message?.reciver?.fullName
//                                       ?.split(" ")
//                                       .first ??
//                                   "User",
//                               paymentStatus:
//                                   message?.paymentStatus ?? "Inquiry",
//                               titleColor: message?.paymentStatus == "Inquiry"
//                                   ? Colors.orange : message?.paymentStatus == "Confirmed"
//                                       ? Colors.green : Colors.red,
//                               path: message?.reciver?.profilePic?.url ?? "",
//                               subtitle: "${message?.ridesDetails?.origin?.name?.split(",").first ?? "City"} to ${message?.ridesDetails?.destination?.name?.split(",").first ?? "City"}, ${DateTimeUtils.formatDate(DateTime.parse(message?.ridesDetails?.date ?? LocaleKeys.app_defaultDate.tr))}",
//                               lastMsg: message?.lastMessage ?? "...",
//                               lastMsgStyle: messageRead
//                                   ? TextStyleUtil.k12Regular(
//                                       color: ColorUtil.kBlack03)
//                                   : TextStyleUtil.k12Bold(
//                                       color: isPinkModeOn ? ColorUtil.kPrimary3PinkMode : ColorUtil.kSecondary03),
//                               trailing: PopupMenuButton(
//                                 itemBuilder: (context) {
//                                   return [
//                                     PopupMenuItem(
//                                       onTap: () {
//                                         controller.archiveMsgAPI(
//                                             message?.chatRoomId ?? "");
//                                       },
//                                       value: 0,
//                                       height: 45.kh,
//                                       textStyle: TextStyleUtil.k12Medium(),
//                                       child: Text(
//                                           LocaleKeys.app_moveToArchive.tr,
//                                           style: TextStyleUtil.k14Regular()),
//                                     ),
//                                   ];
//                                 },
//                                 color: ColorUtil.kWhiteColor,
//                                 icon: const Icon(Icons.more_vert),
//                                 iconSize: 28.kh,
//                                 enableFeedback: true,
//                                 menuPadding: EdgeInsets.all(0.h),
//                                 shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(8.kh)),
//                               ),
//                             ).paddingOnly(top: 8.kh),
//                           );
//                         },
//                       ).paddingOnly(left: 16.kw, right: 16.kw, top: 8.kh),
//           ),
//         ));
//   }
// }
//
// class LoadingWidget extends StatelessWidget {
//   const LoadingWidget({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: 5,
//       itemBuilder: (context, index) {
//         return SizedBox(
//           // height: 78.kh,
//           child: ListTile(
//             tileColor: ColorUtil.kWhiteColor,
//             onTap: () {},
//             shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(8.kh)),
//             title: SizedBox(
//               height: 10.kh,
//               width: 100.w,
//               child: const LinearProgressIndicator(
//                 color: ColorUtil.kGreyColor,
//               ),
//             ),
//             subtitle: SizedBox(
//               height: 10.kh,
//               width: 100.w,
//               child: const LinearProgressIndicator(
//                 color: ColorUtil.kGreyColor,
//               ),
//             ),
//             contentPadding:
//                 EdgeInsets.symmetric(horizontal: 24.kw, vertical: 8.kh),
//             leading: SizedBox(
//               height: 40.kh,
//               width: 40.kw,
//               child: ClipRRect(
//                   borderRadius: BorderRadius.circular(8.kh),
//                   child: const LinearProgressIndicator(
//                     color: ColorUtil.kGreyColor,
//                   )),
//             ),
//             trailing: const Icon(Icons.more_vert),
//           ),
//         ).paddingOnly(top: 8.kh);
//       },
//     );
//   }
// }
//
// class MessageTile extends StatelessWidget {
//   final String title, path, subtitle, lastMsg, paymentStatus;
//   final Widget trailing;
//   final TextStyle? subtitleStyle, lastMsgStyle;
//   final Function() onTap;
//   final Color? tileColor, titleColor;
//   final BorderSide borderSide;
//
//   const MessageTile({
//     super.key,
//     required this.title,
//     required this.paymentStatus,
//     required this.path,
//     required this.onTap,
//     required this.subtitle,
//     required this.trailing,
//     this.subtitleStyle,
//     this.tileColor,
//     this.titleColor,
//     this.borderSide = BorderSide.none,
//     required this.lastMsg,
//     this.lastMsgStyle,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 97.kh,
//       child: ListTile(
//         tileColor: tileColor,
//         onTap: onTap,
//         shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(8.kh), side: borderSide),
//         // title: Text(
//         //   title,
//         //   style: TextStyleUtil.k14Semibold(
//         //     color: titleColor ?? ColorUtil.kBlack01,
//         //   ),
//         // ),
//         title: RichText(
//           text: TextSpan(children: [
//             TextSpan(
//               text: "$title • ",
//               style: TextStyleUtil.k14Semibold(),
//             ),
//             TextSpan(
//               text: paymentStatus,
//               style: TextStyleUtil.k14Semibold(
//                 color: titleColor ?? ColorUtil.kBlack01,
//               ),
//             ),
//           ]),
//         ),
//         subtitle: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text(
//               subtitle,
//               style: subtitleStyle ??
//                   TextStyleUtil.k14Regular(color: ColorUtil.kBlack03),
//               overflow: TextOverflow.ellipsis,
//             ),
//             2.kheightBox,
//             Text(
//               lastMsg,
//               style: lastMsgStyle ??
//                   TextStyleUtil.k12Regular(color: ColorUtil.kBlack03),
//               overflow: TextOverflow.ellipsis,
//             ),
//           ],
//         ),
//         isThreeLine: true,
//         titleAlignment: ListTileTitleAlignment.titleHeight,
//         contentPadding: EdgeInsets.symmetric(horizontal: 24.kw, vertical: 8.kh),
//         leading: SizedBox(
//           height: 40.kh,
//           width: 40.kw,
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(8.kh),
//             child: CommonImageView(
//               url: path,
//             ),
//           ),
//         ),
//         trailing: trailing,
//       ),
//     );
//   }
// }
//
//

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/modules/home/controllers/home_controller.dart';
import 'package:green_pool/app/services/colors.dart';
import 'package:green_pool/app/services/custom_button.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import 'package:green_pool/app/services/storage.dart';
import 'package:green_pool/app/services/text_style_util.dart';

import '../../../../generated/locales.g.dart';
import '../../../components/common_image_view.dart';
import '../../../components/greenpool_appbar.dart';
import '../../../data/chat_arg.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/date_utils.dart';
import '../controllers/messages_controller.dart';

class MessagesView extends GetView<MessagesController> {
  const MessagesView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => MessagesController());
    controller.getChatRoomAPI();
    return Scaffold(
        appBar: GreenPoolAppBar(
          title: Text(LocaleKeys.app_messages.tr),
          leading: const SizedBox(),

        ),
        body: Obx(
              () => RefreshIndicator(
            backgroundColor: ColorUtil.kWhiteColor,
            color: Get.find<HomeController>().isPinkModeOn.value
                ? ColorUtil.kPrimary3PinkMode
                : ColorUtil.kPrimary01,
            key: controller.refreshIndicatorKey,
            onRefresh: () async {

            await controller.getChatRoomAPI();
            },
            child: controller.isLoading.value
                ? const LoadingWidget()
                .paddingOnly(left: 16.kw, right: 16.kw, top: 8.kh)
                : controller.chatRoomList.value.chatRooms?.isEmpty ?? true
                ? Center(
              child: Text(

                LocaleKeys.app_yourFutureMsgsWillApearHere.tr,
                style: TextStyleUtil.k24Heading600(),
                textAlign: TextAlign.center,
              ),
            ).paddingSymmetric(horizontal: 16.kw)
                : ListView.builder(
              itemCount:
              controller.chatRoomList.value.chatRooms!.length,
              itemBuilder: (context, index) {
                final message = controller
                    .chatRoomList.value.chatRooms?[index];
                final isPinkModeOn =
                    Get.find<HomeController>().isPinkModeOn.value;
                final messageRead = controller.chatRoomList.value.chatRooms?[index].user1UnreadCount ==
                    0 ||
                    controller.chatRoomList.value.chatRooms?[index]
                        ?.user2UnreadCount ==
                        null;
                return MessageTile(
                  onTap: () {

                    Get.toNamed(Routes.GROUP_CHAT, arguments: {
                      "chatArg": ChatArg(
                        chatRoomId: message?.chatRoomId  ?? "",
                        id: Get.find<GetStorageService>().getUserAppId,
                        image: Get.find<GetStorageService>().profilePicUrl,
                        name: message?.eventId?.title ?? "",
                        eventId: message?.eventId?.id ?? "",
                        deleteUpdateTime: "${message?.deleteUpdateTime ?? ""}"  ,

                      ),
                      // "ridePostId": message?.ridePostId ?? "",
                    });
                    // controller.getToChatPage(message, controller.refreshIndicatorKey);
                  },
                  tileColor: messageRead
                      ? ColorUtil.kWhiteColor
                      : isPinkModeOn
                      ? ColorUtil.kPrimary5PinkMode
                      .withOpacity(0.3)
                      : ColorUtil.kSecondary07.withOpacity(0.3),
                  borderSide: messageRead
                      ? BorderSide.none
                      : BorderSide(
                      color: isPinkModeOn
                          ? ColorUtil.kPrimary5PinkMode
                          : ColorUtil.kSecondary07),
                  title: message?.eventId?.title ?? "User",
                  paymentStatus: message?.paymentStatus ?? "",

                  path: "message?.reciver?.profilePic?.url ??",
                  subtitle: controller.formatDate(message?.createdAt ?? DateTime.now()),
                  lastMsg: message?.lastMessage ?? "...",
                  lastMsgStyle: messageRead
                      ? TextStyleUtil.k12Regular(color: ColorUtil.kBlack03)
                      : TextStyleUtil.k12Bold(color: isPinkModeOn ? ColorUtil.kPrimary3PinkMode : ColorUtil.kSecondary03),
                  trailing: const Text(""),

                ).paddingOnly(top: 8.kh);
              },
            ).paddingOnly(left: 16.kw, right: 16.kw, top: 8.kh),
          ),
        ));
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return SizedBox(
          // height: 78.kh,
          child: ListTile(
            tileColor: ColorUtil.kWhiteColor,
            onTap: () {},
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.kh)),
            title: SizedBox(
              height: 10.kh,
              width: 100.w,
              child: const LinearProgressIndicator(
                color: ColorUtil.kGreyColor,
              ),
            ),
            subtitle: SizedBox(
              height: 10.kh,
              width: 100.w,
              child: const LinearProgressIndicator(
                color: ColorUtil.kGreyColor,
              ),
            ),
            contentPadding:
            EdgeInsets.symmetric(horizontal: 24.kw, vertical: 8.kh),
            leading: SizedBox(
              height: 40.kh,
              width: 40.kw,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.kh),
                  child: const LinearProgressIndicator(
                    color: ColorUtil.kGreyColor,
                  )),
            ),
            trailing: const Icon(Icons.more_vert),
          ),
        ).paddingOnly(top: 8.kh);
      },
    );
  }
}

class MessageTile extends StatelessWidget {
  final String title, path, subtitle, lastMsg, paymentStatus;
  final Widget trailing;
  final TextStyle? subtitleStyle, lastMsgStyle;
  final Function() onTap;
  final Color? tileColor, titleColor;
  final BorderSide borderSide;

  const MessageTile({
    super.key,
    required this.title,
    required this.paymentStatus,
    required this.path,
    required this.onTap,
    required this.subtitle,
    required this.trailing,
    this.subtitleStyle,
    this.tileColor,
    this.titleColor,
    this.borderSide = BorderSide.none,
    required this.lastMsg,
    this.lastMsgStyle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 97.kh,
      child: ListTile(
        tileColor: tileColor,
        onTap: onTap,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.kh), side: borderSide),

        title: RichText(
          text: TextSpan(children: [
            TextSpan(
              text: title,
              style: TextStyleUtil.k14Semibold(),
            ),

          ]),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              subtitle,
              style: subtitleStyle ??
                  TextStyleUtil.k14Regular(color: ColorUtil.kBlack03),
              overflow: TextOverflow.ellipsis,
            ),
            2.kheightBox,
            Text(
              lastMsg,
              style: lastMsgStyle ??
                  TextStyleUtil.k12Regular(color: ColorUtil.kBlack03),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        isThreeLine: true,
        titleAlignment: ListTileTitleAlignment.titleHeight,
        contentPadding: EdgeInsets.symmetric(horizontal: 24.kw, vertical: 8.kh),
        leading: SizedBox(
          height: 40.kh,
          width: 40.kw,
          child: Container(decoration: BoxDecoration(
            color: ColorUtil.kPrimary01,borderRadius: BorderRadius.circular(6)
          ),child: Icon(Icons.group ,color: ColorUtil.kBlack011,size: 28.kh,)),
        ),
        trailing: trailing,
      ),
    );
  }
}
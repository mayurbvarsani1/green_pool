import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/data/message_list_model.dart';
import 'package:green_pool/app/modules/home/controllers/home_controller.dart';
import 'package:green_pool/app/services/dio/api_service.dart';

import '../../../../generated/locales.g.dart';
import '../../../data/chat_arg.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/date_utils.dart';

class MessagesController extends GetxController {
  RxBool refreshPage = true.obs;
  RxBool isLoading = false.obs;
  final Rx<MessageListModel> messagesModel = MessageListModel().obs;
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  void onInit() {
    super.onInit();
    showLoadingMessages();
  }

  Future<void> showLoadingMessages() async {
    isLoading.value = true;
    await getMessageListAPI();
    isLoading.value = false;
  }

  getMessageListAPI() async {
    try {
      final resp = await APIManager.getChatList();
      var data = jsonDecode(resp.toString());
      messagesModel.value = MessageListModel.fromJson(data);
      messagesModel.refresh();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  refreshMessageListAPI() async {
    try {
      final resp = await APIManager.getChatList();
      var data = jsonDecode(resp.toString());
      messagesModel.value = MessageListModel.fromJson(data);
      messagesModel.refresh();
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      Get.find<HomeController>().getUnreadCount();
    }
  }

  Future<void> getToChatPage(
      message, GlobalKey<RefreshIndicatorState> refreshIndicatorKey) async {
    Get.toNamed(Routes.CHAT_PAGE, arguments: {
      "chatArg": ChatArg(
        chatRoomId: message?.chatRoomId ?? "",
        id: message?.reciver?.Id ?? "",
        driverRideId: message.driverRideId ?? "",
        riderRideId: message.riderRideId ?? "",
        image: message?.reciver?.profilePic?.url,
        deleteUpdateTime: message?.deleteUpdateTime ?? "",
        name: message?.reciver?.fullName,
        origin: message?.ridesDetails?.origin?.name?.split(",").first,
        destination: message?.ridesDetails?.destination?.name?.split(",").first,
        date: DateTimeUtils.formatDate(DateTime.parse(message?.ridesDetails?.date ?? LocaleKeys.app_defaultDate.tr)),
      ),
      "ridePostId": message?.ridePostId ?? "",
    })!
        .then((value) async {
      if (value != true) {
        Future.delayed(const Duration(milliseconds: 100), () {
          refreshIndicatorKey.currentState?.show();
        });
        messagesModel.refresh();
      } else {
        showLoadingMessages();
      }
    });
  }

  Future<void> archiveMsgAPI(String chatRoomId) async {
    try {
      final res = await APIManager.patchArchiveMsg(chatRoomId: chatRoomId);
      refreshMessageListAPI();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void moveToUnarchive() {
    Get.toNamed(Routes.ARCHIVED)?.then((value) async {
      getMessageListAPI();
    });
  }
}
/*messagesModel.value?.chatRoomIds?.sort((a, b) {
        final dateTimeA =
            DateTime.parse(a!.updatedAt ?? "2024-01-01T00:00:00.000Z");
        final dateTimeB =
            DateTime.parse(b!.updatedAt ?? "2024-01-01T00:00:00.000Z");

        if (dateTimeA == null && dateTimeB == null) {
          return 0;
        } else if (dateTimeA == null) {
          return 1;
        } else if (dateTimeB == null) {
          return -1;
        } else {
          return dateTimeB.compareTo(dateTimeA);
        }
      });*/

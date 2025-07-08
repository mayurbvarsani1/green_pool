import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/data/message_model.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import 'package:green_pool/app/services/storage.dart';
import 'package:green_pool/app/services/text_style_util.dart';

import '../../../../../generated/locales.g.dart';
import '../../../../data/chat_arg.dart';
import '../../../../data/group_get_chat_model.dart';
import '../../../../routes/app_pages.dart';
import '../../../../services/colors.dart';
import '../../../../services/custom_button.dart';
import '../../../../services/dio/api_service.dart';
import '../../../home/controllers/home_controller.dart';
import '../../../messages/controllers/messages_controller.dart';
import '../../event_details/controllers/event_details_controller.dart';

class GroupChatController extends GetxController {
  final Rx<ChatArg> chatArg = ChatArg().obs;
  final RxBool isLoad = true.obs;
  final RxBool sendingMsg = false.obs;
  final TextEditingController eMsg = TextEditingController();
  final RxList<MessageModel> messages = <MessageModel>[].obs;
  late ScrollController scrollController;
  StreamSubscription<DatabaseEvent>? _chatSubscription;
  bool isSubscribed = false;
  bool rideCreated = false;
  RxBool isPayBtnVisible = false.obs;
  RxBool isWarningVisible = true.obs;
  RxBool confirmByDriver = true.obs;
  final progress = 0.0.obs;
  String ridePostId = "";



  @override
  void onInit() {
    super.onInit();
    scrollController = ScrollController();
    try {
      chatArg.value = Get.arguments["chatArg"];


      if (chatArg.value.chatRoomId != null) {
        getChat();
      }
    } catch (e) {
      chatArg.value = Get.arguments;
      if (chatArg.value.chatRoomId != null) {
        getChat();
      }
    }


    isLoad.value = false;
    startProgress();
  }


  String? eventId;
  String? chatRoomId;
  String? groupName;


  RxList<Message> messageList = <Message>[].obs;
  chatListGetAPI(String chatRoomId) async {
    if (chatRoomId.isNotEmpty) {
      try {
        isLoad.value = true;
        final response =
            await APIManager.getChatDetails(chatRoomId: chatRoomId ?? "");
        final groupChatData = GroupGetChatListModel.fromJson(response.data);
        messageList.value = groupChatData.messages ?? [];
        isLoad.value = false;
      } catch (e) {
        throw Exception(e);
      }
    }
  }

  void readMsg() async {
    try {
      await APIManager.postChatRoomId(
          receiverId: chatArg.value.id!,
          body: {"driverRideId": chatArg.value.driverRideId});
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  checkForPayBtn() async {
    try {
      final response = await APIManager.getCheckForPayBtn(
          driverRideId: chatArg.value.driverRideId ?? "");
      isPayBtnVisible.value = response.data["riderCheck"] == false &&
          response.data["driver"] == false;
      confirmByDriver.value =
          response.data["requestByDriver"];
      rideCreated = response.data["rideRequested"] ==
          true;
    } catch (e) {
      debugPrint("$e");
    }
  }

  void getChat() async {
    if (!isClosed && !isSubscribed) {
      isSubscribed = true;

      _chatSubscription?.cancel();
      _chatSubscription = null;


      _chatSubscription = FirebaseDatabase.instance
          .ref()
          .child('chats')
          .child(chatArg.value.chatRoomId ?? "")
          .child("messages")
          .onValue
          .listen((event) async {
        var data = event.snapshot.value;


        if (data is Map) {
          final liveLocation =
              DataMsgModel.fromMap(Map<String, dynamic>.from(data));


          messages.value = liveLocation.messages;
          messages.value.sort((a, b) => a.timestamp!.compareTo(b.timestamp!));
          try {
            if (chatArg.value.deleteUpdateTime != null ||
                chatArg.value.deleteUpdateTime != "") {
              messages.value.removeWhere((item) => item.timestamp.isBefore(
                  DateTime.parse(chatArg.value.deleteUpdateTime ?? "")));
            }


          } catch (e) {
            debugPrint(e.toString());
          }
          WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
        }
        // readMsg();
      }, onError: (Object error) {
        debugPrint("Error: $error");
      });
    }
  }

  void _scrollToBottom() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
    );
  }

  sendMsg() async {
    if (eMsg.text.trim().isEmpty) {
      return;
    } else {
      await setMessageInApi();
    }
  }

  Future<void> setMessageInApi() async {
    String msg = eMsg.text;
    eMsg.clear();
    final timestamp = DateTime.now().toUtc();
    final senderId = Get.find<GetStorageService>().getUserAppId;
    try {
      messages.value.add(MessageModel(
          id: chatArg.value.chatRoomId ?? "",
          message: msg,
          senderId: senderId ?? "",
          timestamp: timestamp));
      messages.refresh();
      WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
      final res = await APIManager.sendChatApi(body: {
        "message": msg,
        // "receiverId": chatArg.value.id,
        "chatRoomId": chatArg.value.chatRoomId,
        "eventId": chatArg.value.eventId,
      });
      chatArg.value.chatRoomId = res.data["chatRoomId"];
      MessagesController  messagesController = Get.find();
      messagesController.getChatRoomAPI();
      getChat();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  deleteChat() {
    Get.dialog(
      useSafeArea: true,
      Center(
        child: Container(
          padding: EdgeInsets.all(16.kh),
          height: 212.kh,
          width: 80.w,
          decoration: BoxDecoration(
            color: ColorUtil.kWhiteColor,
            borderRadius: BorderRadius.circular(8.kh),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  alignment: Alignment.centerRight,
                  child: const Icon(Icons.close),
                ),
              ),
              Text(
                LocaleKeys.app_delete.tr,
                style: TextStyleUtil.k18Semibold(),
                textAlign: TextAlign.left,
              ).paddingSymmetric(vertical: 4.kh),
              Text(
                LocaleKeys.app_areYouSureYouWantToDeleteThisChat.tr,
                style: TextStyleUtil.k14Regular(
                  color: ColorUtil.kBlack04,
                ),
                textAlign: TextAlign.left,
              ).paddingOnly(bottom: 40.kh),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GreenPoolButton(
                    onPressed: () {
                      Get.back();
                    },
                    isBorder: true,
                    height: 40.kh,
                    width: 124.kw,
                    label: LocaleKeys.app_cancel.tr,
                    fontSize: 14.kh,
                    padding: const EdgeInsets.all(8),
                    borderColor: Get.find<HomeController>().isPinkModeOn.value
                        ? ColorUtil.kPrimary3PinkMode
                        : ColorUtil.kSecondary01,
                    labelColor: Get.find<HomeController>().isPinkModeOn.value
                        ? ColorUtil.kPrimary3PinkMode
                        : ColorUtil.kSecondary01,
                  ),
                  GreenPoolButton(
                    onPressed: () {
                      Get.back();
                      deleteChatApi();
                    },
                    height: 40.kh,
                    width: 124.kw,
                    label: LocaleKeys.app_delete.tr,
                    fontSize: 14.kh,
                    padding: const EdgeInsets.all(8),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> deleteChatApi() async {
    try {
     var res =  await APIManager.deleteGroupChat(eventId: chatArg.value.eventId ?? "");
      Get.back(result: true);
     EventDetailsController  eventDetailsController  = Get.put(EventDetailsController());
     eventDetailsController.eventDetailAPI(chatArg.value.eventId  ?? "");
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  call() {

  }

  @override
  void onClose() {
    if (_chatSubscription != null) {
      _chatSubscription!.cancel();
      _chatSubscription = null;
    }

    if (scrollController.hasClients || !scrollController.hasClients) {
      scrollController.dispose();
    }

    super.onClose();
  }

  void startProgress() {
    progress.value = 0.0; // Reset progress
    const duration = Duration(seconds: 8);
    const interval = Duration(milliseconds: 1); // Adjust for smoother progress
    int ticks = 0;


    Timer.periodic(interval, (timer) {
      ticks++;
      progress.value =
          ticks / (duration.inMilliseconds / interval.inMilliseconds);

      if (progress.value >= 1.0) {
        timer.cancel(); // Stop timer when complete
        isWarningVisible.value = false;
      }
    });
  }

}

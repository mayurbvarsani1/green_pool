import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/data/message_model.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import 'package:green_pool/app/services/storage.dart';
import 'package:green_pool/app/services/text_style_util.dart';

import '../../../../generated/locales.g.dart';
import '../../../data/chat_arg.dart';
import '../../../routes/app_pages.dart';
import '../../../services/colors.dart';
import '../../../services/custom_button.dart';
import '../../../services/dio/api_service.dart';
import '../../home/controllers/home_controller.dart';

class ChatPageController extends GetxController {
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
      ridePostId = Get.arguments["ridePostId"];
      if (chatArg.value.chatRoomId != null) {
        getChat();
      }
    } catch (e) {
      chatArg.value = Get.arguments;
      if (chatArg.value.chatRoomId != null) {
        getChat();
      }
    }

    checkForPayBtn();

    isLoad.value = false;
    startProgress();
  }

  void readMsg() async {
    try {
      await APIManager.postChatRoomId(
          receiverId: chatArg.value.id!,
          body: {"driverRideId": chatArg.value.driverRideId});
      print(
          "++++++++++++++++++++++++++++++++READ MESSAGE API CALLED+++++++++++++++++++++++++++++++++++++");
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  checkForPayBtn() async {
    try {
      final response = await APIManager.getCheckForPayBtn(
          driverRideId: chatArg.value.driverRideId ?? "");
      isPayBtnVisible.value = response.data["riderCheck"] == false &&
          response.data["driver"] == false; //to show pay button
      confirmByDriver.value =
          response.data["requestByDriver"]; //if driver has requested the rider
      rideCreated = response.data["rideRequested"] ==
          true; //if false then rider has not requested ride so we need to create a riderRide
    } catch (e) {
      debugPrint("check for pay btn error: $e");
    }
  }

  void getChat() async {
    if (!isClosed && !isSubscribed) {
      isSubscribed = true;

      _chatSubscription?.cancel();
      _chatSubscription = null;
      debugPrint('New subscription is being created');

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
          WidgetsBinding.instance
              .addPostFrameCallback((_) => _scrollToBottom());
        }
        readMsg();
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
    /*final RegExp phoneRegex = RegExp(
      r'(?<!\w)'
      r'('
      r'(\+?(\d|zero|one|two|three|four|five|six|seven|eight|nine|oh|eye|won){1,3})?[\s\-\.]?'
      r'\(?([\dOIl]|zero|one|two|three|four|five|six|seven|eight|nine|oh|eye|won){1,4}\)?[\s\-\.]?'
      r'([\dOIl]|zero|one|two|three|four|five|six|seven|eight|nine|oh|eye|won){1,4}[\s\-\.]?'
      r'([\dOIl]|zero|one|two|three|four|five|six|seven|eight|nine|oh|eye|won){1,4}'
      r'([\s\-\.]?([\dOIl]|zero|one|two|three|four|five|six|seven|eight|nine|oh|eye|won){1,9})?'
      r'|'
      r'(\+?(zero|one|two|three|four|five|six|seven|eight|nine|oh|eye|won){1,3})?[\s\-\.]?\(?'
      r'(zero|one|two|three|four|five|six|seven|eight|nine|oh|eye|won|\d){1,4}\)?[\s\-\.]?'
      r'(zero|one|two|three|four|five|six|seven|eight|nine|oh|eye|won|\d){1,4}[\s\-\.]?'
      r'(zero|one|two|three|four|five|six|seven|eight|nine|oh|eye|won|\d){1,4}'
      r'([\s\-\.]?(zero|one|two|three|four|five|six|seven|eight|nine|oh|eye|won|\d){1,9})?'
      r')'
      r'([\s\-\.]?(ext|x|extension)[\s\-\.]?\d{1,5})?'
      r'(?!\w)',
      caseSensitive: false,
    );
    msg = msg.replaceAll(phoneRegex, '(Phone Number Hidden)');*/
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
      final res = await APIManager.sendMessage(body: {
        "message": msg,
        "receiverId": chatArg.value.id,
        "chatRoomId": chatArg.value.chatRoomId
      });
      chatArg.value.chatRoomId = res.data["chatRoomId"];
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
      await APIManager.deleteChat(chatRoomId: chatArg.value.chatRoomId ?? "");
      Get.back(result: true);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  call() {
    // launchUrl(Uri.parse("tel:${chatArg.value.phone}"));
  }

  @override
  void onClose() {
    if (_chatSubscription != null) {
      _chatSubscription!.cancel();
      _chatSubscription = null;
      debugPrint('Subscription cancelled');
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

    // Timer to increment progress
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

  void moveToPaymentFromConfirmSection() {
    try {
      Get.toNamed(Routes.PAYNOW, arguments: {
        //rider ride id for payment
        "chatArg": chatArg.value,
        //rider has created a ride?
        "rideCreated": rideCreated,
        //true if driver has requested the rider
        "confirmByDriver": confirmByDriver.value,
        //ride post id to implement "accept drivers request api" (if driver has requested rider)
        "ridePostId": ridePostId,
      });
    } catch (e) {
      Get.toNamed(Routes.PAYNOW, arguments: {
        //rider ride id for payment
        "chatArg": chatArg.value,
        //rider has created a ride?
        "rideCreated": rideCreated,
        //true if driver has requested the rider
        "confirmByDriver": confirmByDriver.value,
      });
    }
  }
}

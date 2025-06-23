import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/data/find_ride_model.dart';
import 'package:green_pool/app/data/location_model.dart';
import 'package:green_pool/app/modules/home/controllers/home_controller.dart';
import 'package:green_pool/app/services/colors.dart';
import 'package:green_pool/app/services/snackbar.dart';
import 'package:green_pool/generated/locales.g.dart';
import 'package:intl/intl.dart';

import '../../../../data/event_list_model.dart';
import '../../../../data/message_model.dart';
import '../../../../routes/app_pages.dart';
import '../../../../services/dialog_helper.dart';
import '../../../../services/dio/api_service.dart';
import '../../../../services/storage.dart';
import '../../../../utils/date_utils.dart';
import '../../../origin/controllers/origin_controller.dart';


class OrganizeCarpoolController extends GetxController {
  bool isDriver = false;
  int numberOfSeatAvailable = 1;
  RxBool isActive = false.obs;
  RxString selectedButton = 'request'.obs;

  @override
  void onInit() {
    super.onInit();
    getEventAPI();
  }
  RxBool isSelected = true.obs;

  TextEditingController searchTextController = TextEditingController();


  void moveToMatchingRides() {
    // final rideDetails = _getRideDetails();
    // _storePreviousLocations();
    // Get.toNamed(Routes.MATCHING_RIDES, arguments: rideDetails.toJson());
    Get.toNamed(Routes.CREATE_NEW_EVENT, arguments: false);
  }


  String formatDateAndTime(dynamic date, dynamic time) {
    // final parsedDate = date is DateTime ? date : DateTime.parse(date.toString());
    final parsedTime = time is DateTime ? time.toLocal() : DateTime.parse(time.toString()).toLocal();

    final dateFormatted = DateFormat('dd MMMM yyyy, hh:mm:a').format(parsedTime);

    return '$dateFormatted';
  }

  final RxBool isLoad = true.obs;
  // final RxList<eventListModelFromJson> transactions =
  //     <eventListModelFromJson>[].obs;

  RxList<Doc>  eventData  = <Doc>[].obs;



  Future<void> getEventAPI({bool isOfferRide = false,}) async {
    Map<String, dynamic> queryParameters = {};

    if (searchTextController.text.isNotEmpty ) {
      queryParameters["filter"] = searchTextController.text.trim();
    }


    if (isOfferRide) {
      queryParameters["myEvent"] = true;
    }

    try {
      isLoad.value = true;
      final res = await APIManager.eventList(queryParameters: queryParameters);
      debugPrint("eventList=>${res.statusCode}");
      debugPrint("eventList=>${res.data}");
      final eventListModel = EventListModel.fromJson(res.data);
      debugPrint("eventListModel=>$eventListModel");
      eventData.value = eventListModel.data!.docs!;
      debugPrint("eventData=>$eventData");
      debugPrint("eventData=>${eventData.value}");

      // Remove the last transaction if the list is not empty
      // if (transactions.isNotEmpty) {
      //   transactions.removeLast();


      isLoad.value = false;
    } catch (e) {
      debugPrint(e.toString());
    }

  }

  var searchDebounceTimer;
  var keyboardCloseTimer;

  void onSearchTextChanged(String? value) {

    if (searchDebounceTimer != null) {
      searchDebounceTimer.cancel();
    }

    if (value!.isEmpty || value!.length >= 3) {
      searchDebounceTimer = Timer(Duration(milliseconds: 500), () async {
         await getEventAPI(isOfferRide: selectedButton.value == 'offer' );
         FocusManager.instance.primaryFocus?.unfocus();

      });
      // keyboardCloseTimer = Timer(Duration(seconds: 3), () {
      //   if (FocusManager.instance.primaryFocus != null) {
      //     FocusManager.instance.primaryFocus?.unfocus();
      //   }
      // });
    }
  }









  final ScrollController scrollController = ScrollController();

  final RxBool isChatStarted = true.obs;
  String chatRoomId = "";

  final RxList<MessageModel> messages = <MessageModel>[].obs;
  final TextEditingController eMsg = TextEditingController();

  Future<void> setMessageInApi() async {
    final msg = "";
    eMsg.clear();
    final timestamp = DateTime.now().toUtc();
    try {
      if (!isChatStarted.value) {
        messages.value.add(MessageModel(
            id: chatRoomId,
            message: msg,
            senderId: Get.find<GetStorageService>().getUserAppId ?? "",
            timestamp: timestamp));
        messages.refresh();
        final res =
        await APIManager.userSupportFirstMessage(body: {"issueType": msg});
        if (res.data["message"] == "Chat message written successfully.") {
          chatRoomId = res.data["chatRoomId"];
          Get.find<GetStorageService>().setSupportChatRoomId =
          res.data["chatRoomId"];
        } else {
          showMySnackbar(msg: res.data["message"]);
        }
        isChatStarted.value = true;
      } else {
        messages.value.add(MessageModel(
            id: chatRoomId,
            message: msg,
            senderId: Get.find<GetStorageService>().getUserAppId ?? "",
            timestamp: timestamp));
        messages.refresh();
        WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
        final res = await APIManager.userSupportSendMessage(
            body: {"message": msg, "chatRoomId": chatRoomId});
        chatRoomId = res.data["chatRoomId"];
        Get.find<GetStorageService>().setSupportChatRoomId =
        res.data["chatRoomId"];
        //clear the id from storage when Resolved is coming in response
      }
      getChat();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void _scrollToBottom() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
    );
  }

  getChat() {
    FirebaseDatabase.instance
        .ref()
        .child('userSupportChat')
        .child(chatRoomId)
        .child("messages")
        .onValue
        .listen((event) async {
      var data = event.snapshot.value;
      if (data is Map) {
        final liveLocation =
        DataMsgModel.fromMap(Map<String, dynamic>.from(data));
        messages.value = liveLocation.messages;
        messages.value.sort((a, b) => a.timestamp!.compareTo(b.timestamp!));
        messages.value.insert(
          0,
          MessageModel(
            id: "admin",
            senderId: "admin",
            message: LocaleKeys.app_default_support_msg.tr,
            timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
          ),
        );
        // WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
      }
    }, onError: (Object error) {
      debugPrint("Error: $error");
    });
  }
}
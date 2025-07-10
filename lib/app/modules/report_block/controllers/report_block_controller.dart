import 'dart:convert';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:green_pool/app/data/report_list_model.dart';
import 'package:green_pool/app/data/school_list_model.dart';
import 'package:green_pool/app/services/dio/api_service.dart';
import 'package:green_pool/generated/locales.g.dart';

import '../../../services/snackbar.dart';

class ReportBlockController extends GetxController {


  final RxBool isLoad = true.obs;


  myRidesAPI(){

  }

  // RxList<ReportList?> getReportList = <ReportList>[].obs;
  //
  // bool smallLoader = false;
  // int totalPage = 0;
  // int itemsPerPage = 0;
  //
  // getReportListApi() async {
  //   isLoad.value = true;
  //
  //   totalPage = 0;
  //   itemsPerPage = 0;
  //   getReportList
  //   await patientsApiDataResponse();
  //   isLoad.value = false;
  //
  // }
  //
  // patientScrollPagination() async {
  //   if (totalPage > itemsPerPage && !smallLoader) {
  //     itemsPerPage = itemsPerPage + 1;
  //     smallLoader = true;
  //
  //     await patientsApiDataResponse(page: itemsPerPage);
  //     debugPrint("itemsPerPage=>$itemsPerPage");
  //     smallLoader = false;
  //
  //   }
  // }
  //
  // patientsApiDataResponse({int page = 0}) async {
  //   final response = await APIManager.getReportList(pagination: "?page=1&limit=10");
  //   getReportList.addAll(response.data?.items ?? []);
  //   debugPrint("getReportList=>$getReportList");
  //   totalPage = model?.data?.totalPage ?? 0;
  //   debugPrint("page=>$page");
  //   isLoad.value = false;
  //
  // }
  //
  //
  //
  // RxList<Message> messageList = <Message>[].obs;
  // chatListGetAPI(String chatRoomId) async {
  //   if (chatRoomId.isNotEmpty) {
  //     try {
  //       isLoad.value = true;
  //       final response =
  //       await APIManager.getChatDetails(chatRoomId: chatRoomId ?? "");
  //       final groupChatData = GroupGetChatListModel.fromJson(response.data);
  //       messageList.value = groupChatData.messages ?? [];
  //       isLoad.value = false;
  //     } catch (e) {
  //       throw Exception(e);
  //     }
  //   }
  // }
  //

}

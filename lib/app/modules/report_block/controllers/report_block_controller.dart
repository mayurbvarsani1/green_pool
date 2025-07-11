import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/data/block_list_model.dart';
import 'package:green_pool/app/data/report_list_model.dart';
import 'package:green_pool/app/data/user_address_list_model.dart';
import 'package:green_pool/app/routes/app_pages.dart';
import 'package:green_pool/app/services/dio/api_service.dart';
import '../../../services/snackbar.dart';
import '../../grop_carpool/group_destination/controllers/group_destination_controller.dart';

class ReportBlockController extends GetxController {


  final RxBool isLoad = true.obs;


  //
  // @override
  // void onInit() {
  //   // TODO: implement onInit
  //   super.onInit();
  //   getReportListApi();
  //   getBlockListApi();
  // }


  RxList<ReportDataDocsList?> getReportList = <ReportDataDocsList>[].obs;

  bool smallLoader = false;
  int totalPage = 0;
  int itemsPerPage = 0;

  getReportListApi() async {
    isLoad.value = true;
    totalPage = 0;
    itemsPerPage = 0;
    getReportList = <ReportDataDocsList>[].obs;
    await reportApiDataResponse();
    isLoad.value = false;

  }

  reportScrollPagination() async {
    if (totalPage > itemsPerPage && !smallLoader) {
      itemsPerPage = itemsPerPage + 1;
      smallLoader = true;

      await reportApiDataResponse(page: itemsPerPage);
      debugPrint("itemsPerPage=>$itemsPerPage");
      smallLoader = false;

    }
  }

  reportApiDataResponse({int page = 0}) async {
    final response = await APIManager.getReportList(pagination: "?page=1&limit=10");
    final getReportDataList = ReportListModel.fromJson(response.data);
    debugPrint("response123456=>$response");
    getReportList.addAll(getReportDataList.data?.docs ?? []);
    // getReportList.addAll(getReportDataList.data ?? []);
    // getReportList.add(getReportDataList.data);
    // if (getReportDataList.data != null) {
    //   getReportList.add(getReportDataList.data);
    // }
    debugPrint("getReportList=>$getReportList");
    totalPage = getReportDataList.data?.totalPages ?? 0;
    debugPrint("totalPage=>$totalPage");
    debugPrint("page=>$page");
    isLoad.value = false;
  }






  RxList<BlockDocList?> getBlockList = <BlockDocList>[].obs;

  bool blockSmallLoader = false;
  int blockTotalPage = 0;
  int blockItemsPerPage = 0;

  getBlockListApi() async {
    isLoad.value = true;
    blockTotalPage = 0;
    blockItemsPerPage = 0;
    getBlockList = <BlockDocList>[].obs;
    await blockApiDataResponse();
    isLoad.value = false;

  }

  blockScrollPagination() async {
    if (blockTotalPage > blockItemsPerPage && !blockSmallLoader) {
      blockItemsPerPage = blockItemsPerPage + 1;
      blockSmallLoader = true;

      await blockApiDataResponse(page: blockItemsPerPage);
      debugPrint("blockItemsPerPage=>$blockItemsPerPage");
      blockSmallLoader = false;

    }
  }

  blockApiDataResponse({int page = 0}) async {
    final response = await APIManager.getBlockList(pagination: "?page=1&limit=10");
    final getBlockDataList = BlockListModel.fromJson(response.data);
    debugPrint("response56=>$response");
    debugPrint("getBlockDataList=>$getBlockDataList");
    getBlockList.addAll(getBlockDataList.data?.docs ?? []);
    // getBlockList.addAll(getBlockDataList.data ?? []);
    // getBlockList.add(getBlockDataList.data);
    // if (getBlockDataList.data != null) {
    //   getBlockList.add(getBlockDataList.data);
    // }
    debugPrint("getBlockList=>$getBlockList");
    blockTotalPage = getBlockDataList.data?.totalPages ?? 0;
    debugPrint("totalPage12=>$totalPage");
    debugPrint("page32=>$page");
    isLoad.value = false;
  }





  /// TODO : address list screen

  TextEditingController riderOriginTextController = TextEditingController();
  RxBool isOriginAdded = false.obs;
  double riderOriginLat = 0.0;

  double riderOriginLong = 0.0;

  double riderDestinationLat = 0.0;

  double riderDestinationLong = 0.0;
  RxBool isActive = false.obs;



  removeOrigin() {
    riderOriginTextController.clear();
    isOriginAdded.value = false;
    riderOriginLat = 0.0;
    riderOriginLong = 0.0;
  }

  moveToSetOrigin() {
    // Get.toNamed(Routes.ORIGIN, arguments: LocationValues.findRideOrigin)
    //     ?.then((v) {
    //   if (riderOriginTextController.value.text.isNotEmpty) {
    //     isOriginAdded.value = true;
    //   } else {
    //     isOriginAdded.value = false;
    //   }
    //   setActiveState();
    // });
  }
  void setActiveState() {


    isActive.value = (riderOriginTextController.text.isNotEmpty ) ;
  }

initAddress(){
  addressDataList = null;
}
  UserAddreesListData? addressDataList;

  addressListGetAPI() async {

        isLoad.value = true;
        final response = await APIManager.getUserAddress();
        debugPrint("response=>$response");
        final addressData = UserAddressListModel.fromJson(response.data);
        debugPrint("addressData=>${addressData}");
        debugPrint("addressData=>${addressData.data}");
        addressDataList = addressData.data;
        isLoad.value = false;

  }



}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/data/block_list_model.dart';
import 'package:green_pool/app/services/dio/api_service.dart';
import 'package:green_pool/app/services/snackbar.dart';

class BlockUserController extends GetxController {


  final RxBool isLoad = true.obs;


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getBlockListApi();
  }

  unblockApi(String? id) async {
    debugPrint("id=>$id");
    isLoad.value = true;
    final res = await APIManager.userBlockApi(body: {
      "blockUserId": id,
      "isBlocked": false,
    });
    showMySnackbar(msg: res.data["message"]);
    debugPrint("response=>${res.data['status']}");
    if(res.data["status"] == true){

     getBlockListApi();
     debugPrint("*****************");
    }
    else{
      isLoad.value = false;
    }
  }

  RxList<BlockDocList?> getBlockList = <BlockDocList>[].obs;

  getBlockListApi() async {
    isLoad.value = true;
    getBlockList = <BlockDocList>[].obs;
    await blockApiDataResponse();
    isLoad.value = false;
  }


  blockApiDataResponse() async {
    final response = await APIManager.getBlockList();
    final getBlockDataList = BlockListModel.fromJson(response.data);
    debugPrint("response56=>$response");
    debugPrint("getBlockDataList=>$getBlockDataList");
    getBlockList.value = getBlockDataList.data?.docs ?? [];
    debugPrint("getBlockList=>$getBlockList");
    isLoad.value = false;
  }




}

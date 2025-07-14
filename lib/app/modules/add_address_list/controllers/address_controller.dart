import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/data/block_list_model.dart';
import 'package:green_pool/app/data/user_address_list_model.dart';
import 'package:green_pool/app/routes/app_pages.dart';
import 'package:green_pool/app/services/dio/api_service.dart';
import 'package:green_pool/app/services/snackbar.dart';

import '../../grop_carpool/group_destination/controllers/group_destination_controller.dart' show LocationValues;

class AddressesController extends GetxController {


  final RxBool isLoad = true.obs;


  initAddress(){
    addressDataList = null;
  }


  UserAddreesListData? addressDataList;


  addressListGetAPI() async {
    isLoad.value = true;
    final response = await APIManager.getUserAddress();
    debugPrint("response=>$response");
    final addressData = UserAddressListModel.fromJson(response.data);
    debugPrint("addressData=>$addressData");
    debugPrint("addressData=>${addressData.data}");
    addressDataList = addressData.data;
    isLoad.value = false;

  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    addressListGetAPI();
  }



  TextEditingController addressLabelController = TextEditingController();
  TextEditingController riderOriginTextController = TextEditingController();
  RxBool isOriginAdded = false.obs;
  double riderOriginLat = 0.0;

  double riderOriginLong = 0.0;

  double riderDestinationLat = 0.0;

  double riderDestinationLong = 0.0;
  RxBool isActive = false.obs;


  removeDestination() {
    riderOriginTextController.clear();
    isDestinationAdded.value = false;
    riderOriginLat = 0.0;
    riderOriginLong = 0.0;
    setActiveState();
  }

  removeOrigin() {
    addressLabelController.clear();
    riderOriginTextController.clear();
    isOriginAdded.value = false;
    riderOriginLat = 0.0;
    riderOriginLong = 0.0;
  }

  void setActiveState() {
    isActive.value =  addressLabelController.text.isNotEmpty &&  riderOriginTextController.text.isNotEmpty;
  }

  RxBool isDestinationAdded = false.obs;

  moveToSetDestination() {
    Get.toNamed(Routes.ADDRESS_DESTINATION, arguments: LocationValues.findRideDestination)
        ?.then(
          (value) {
        if (riderOriginTextController.value.text.isNotEmpty) {
          isDestinationAdded.value = true;
        } else {
          isDestinationAdded.value = false;
        }
        setActiveState();
      },
    );
  }




}

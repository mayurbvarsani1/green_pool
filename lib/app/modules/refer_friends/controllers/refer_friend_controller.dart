import 'dart:convert';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:green_pool/app/data/school_list_model.dart';
import 'package:green_pool/app/services/dio/api_service.dart';
import 'package:green_pool/generated/locales.g.dart';

import '../../../services/snackbar.dart';

class ReferFriendsController extends GetxController {
  TextEditingController emailTextController = TextEditingController();
  RxBool isLoading = false.obs;
  RxBool requestSent = false.obs;
  RxBool isActive = false.obs;
  RxBool isSelected = true.obs;
  RxList<SchoolListModelData> schoolSugestionList = <SchoolListModelData>[].obs;
  final debouncer = Debouncer(delay: const Duration(seconds: 1));
  TextEditingController searchTextController = TextEditingController();
  var schoolListModel = SchoolListModel().obs;
  final confettiController = ConfettiController();
  String emailPostFix = "";

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  searchMethod() {
    debouncer(() => schoolListAPI(searchTextController.value.text));
  }

  schoolListAPI(String input) async {
    if (input.isNotEmpty) {
      try {
        isLoading.value = true;
        isSelected.value = false;
        final response = await APIManager.getAllSchools(schoolName: input);
        if (response.data["status"]) {
          var data = jsonDecode(response.toString());
          schoolListModel.value = SchoolListModel.fromJson(data);
          if (schoolListModel.value.data!.isNotEmpty) {
            schoolSugestionList.value = schoolListModel.value.data!;
          }
        } else {
          showMySnackbar(msg: response.data["message"].toString());
        }
        isLoading.value = false;
      } catch (e) {
        throw Exception(e);
      }
    }
  }

  studentDiscountAPI() async {
    try {
      final response = await APIManager.postStudentDiscount(body: {
        "email": emailTextController.value.text,
        "school": searchTextController.text,
      });
      if (response.data['status']) {
        requestSent.value = true;
        confettiController.play();
      } else {
        showMySnackbar(msg: response.data['message'].toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  toggleButton() {
    if (isSelected.value == true && emailTextController.value.text.isNotEmpty) {
      isActive.value = true;
    } else {
      return showMySnackbar(msg: "please fill in the required information");
    }
  }

  void checkEmailPostFix() {
    final postFixValue = emailTextController.value.text.split("@").last;
    if (emailPostFix == postFixValue) {
      studentDiscountAPI();
    } else {
      showMySnackbar(
          msg:
              "The provided email does not match the registered university email address.");
    }
  }


  /// Block & Report Part
  TextEditingController somethingElseController = TextEditingController();
  TextEditingController explainIssueController = TextEditingController();



  List<Map<String, String>> reportReasons = [
    {'label': LocaleKeys.app_abusiveOrOffensive},
    {'label': LocaleKeys.app_spammingOrScamming},
    {'label': LocaleKeys.app_unresponsiveToBookingOrMessages},
    {'label': LocaleKeys.app_requestingOtherPayment},
  ];


  List<Map<String, String>> blockInformationList = [
    {'text': LocaleKeys.app_userNotNotified},
    {'text': LocaleKeys.app_userCantMessageOrBook},
    {'text': LocaleKeys.app_youCanUnblockAnytime},
  ];


  jointEventAPI() async {
    try {

      final res = await APIManager.addReportApi(body: {
          "rideId": "677b87bfb36ce54a40944819",
          "reason": "reason",
          "details": "details"
      });
      showMySnackbar(msg: res.data["message"]);
      if(res.data['status'] = true){


      }
    }
    catch(e){
      debugPrint(e.toString());
    }
  }

}

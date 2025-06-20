import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/data/find_ride_model.dart';
import 'package:green_pool/app/modules/home/controllers/home_controller.dart';
import 'package:green_pool/app/modules/rider_profile_setup/views/rider_review_pic.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../generated/locales.g.dart';
import '../../../routes/app_pages.dart';
import '../../../services/auth.dart';
import '../../../services/colors.dart';
import '../../../services/dialog_helper.dart';
import '../../../services/dio/api_service.dart';
import '../../../utils/image_util.dart';
import '../../../services/snackbar.dart';
import '../../../services/storage.dart';
import 'package:path/path.dart' as path;
import 'package:dio/dio.dart' as dio;

import 'city_list.dart';

class RiderProfileSetupController extends GetxController {
  RxBool isPicked = false.obs;
  RxBool isBtnLoading = false.obs;
  bool fromNavBar = false;
  bool readOnlyEmail = false;
  RxList<String> cityNames = <String>[].obs;
  Rx<File?> selectedProfileImagePath = Rx<File?>(null);
  RxBool isProfileImagePicked = false.obs;
  RxBool isProfileImagePickedCheck = false.obs;
  TextEditingController fullName = TextEditingController(
      text: Get.find<AuthService>().auth.currentUser?.displayName);
  TextEditingController email = TextEditingController(
      text: Get.find<AuthService>().auth.currentUser?.email);
  TextEditingController phoneNumber = TextEditingController(
      text: Get.find<GetStorageService>().phoneNumber.toString().split("+1").last ??"");
  TextEditingController gender = TextEditingController();
  RxBool isGenderListExpanded = false.obs;
  RxList<String> genderList =
      <String>["Male", "Female", "Prefer not to say"].obs;

  TextEditingController dateOfBirth = TextEditingController();
  TextEditingController formattedDateOfBirth = TextEditingController();
  TextEditingController city = TextEditingController();
  RxBool isCityListExpanded = false.obs;
String prefix = "+1";
  GlobalKey<FormState> userFormKey = GlobalKey<FormState>();

  final Rx<FindRideModel> findRideModel = FindRideModel().obs;

  ScrollController scrollController = ScrollController();

  //focus node
  FocusNode nameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode phoneFocusNode = FocusNode();
  FocusNode genderFocusNode = FocusNode();
  FocusNode cityFocusNode = FocusNode();

  @override
  void onInit() {
    super.onInit();
    try {
      fromNavBar = Get.arguments['fromNavBar'];
      findRideModel.value = Get.arguments['findRideModel'];
      fullName.text = Get.arguments['fullName'];
      debugPrint("fromNavBar=?$fromNavBar");
      debugPrint("123=?${Get.find<GetStorageService>().phoneNumber}");
      if(Get.find<GetStorageService>().phoneNumber.startsWith("+91")){
        phoneNumber = TextEditingController(text: Get.find<GetStorageService>().phoneNumber.toString().split("+91").last);
        prefix = "+91";
      }else{
        phoneNumber = TextEditingController(text: Get.find<GetStorageService>().phoneNumber.toString().split("+1").last);
        prefix = "+1";
      }
    } catch (e) {
      fromNavBar = Get.arguments['fromNavBar'];
      fullName.text = Get.arguments['fullName'];
      if(Get.find<GetStorageService>().phoneNumber.startsWith("+91")){
        phoneNumber = TextEditingController(text: Get.find<GetStorageService>().phoneNumber.toString().split("+91").last);
        prefix = "+91";
      }else{
        phoneNumber = TextEditingController(text: Get.find<GetStorageService>().phoneNumber.toString().split("+1").last);
        prefix = "+1";
      }
      debugPrint("fromNavBar1=?$fromNavBar");
      debugPrint("phoneNumber1=?${Get.find<GetStorageService>().phoneNumber}");
    }
    if (Get.find<GetStorageService>().emailId != "") {
      readOnlyEmail = true;
    } else {
      readOnlyEmail = false;
    }
  }

  // void updateSelectedCity(String city) {
  //   selectedCity.value = city;
  // }

  Future<void> setDate(BuildContext context) async {
    DateTime lastDate = DateTime.now()
        .subtract(const Duration(days: 18 * 365)); // Subtracting 18 years

    DateTime initialDate =
        DateTime.now().isAfter(lastDate) ? lastDate : DateTime.now();

    DateTime? pickedDate = Platform.isIOS
        ? await DialogHelper.cupertinoDatePicker(
            context, DateTime(1950), lastDate, initialDate)
        : await showDatePicker(
            context: context,
            firstDate: DateTime(1950),
            lastDate: lastDate,
            initialDate: initialDate,
            builder: (BuildContext context, Widget? child) {
              return Theme(
                // Define the custom theme for the date picker
                data: ThemeData(
                  // Define the primary color
                  primaryColor: Get.find<HomeController>().isPinkModeOn.value
                      ? ColorUtil.kPrimaryPinkMode
                      : ColorUtil.kPrimary01,
                  // Define the color scheme for the date picker
                  colorScheme: ColorScheme.light(
                    // Define the primary color for the date picker
                    primary: Get.find<HomeController>().isPinkModeOn.value
                        ? ColorUtil.kPrimaryPinkMode
                        : ColorUtil.kPrimary01,
                    // Define the background color for the date picker
                    surface: ColorUtil.kWhiteColor,
                    // Define the on-primary color for the date picker
                    onPrimary: ColorUtil.kBlack01,
                    secondary: Get.find<HomeController>().isPinkModeOn.value
                        ? ColorUtil.kPrimaryPinkMode
                        : ColorUtil.kPrimary01,
                  ),
                ),
                // Apply the custom theme to the child widget
                child: child!,
              );
            },
          );

    if (pickedDate != null) {
      String formattedDate = pickedDate.toString().split(" ")[0];
      dateOfBirth.text = formattedDate;
      formattedDateOfBirth.text =
          "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
    }
  }

  getProfileImage(ImageSource imageSource) async {
    XFile? pickedFile = await ImageUtil.squareCropCompressImage(
        cropAspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        imageSource: imageSource);
    if (pickedFile != null) {
      selectedProfileImagePath.value = File(pickedFile.path);
      update();
      Get.to(() => RiderReviewPictureView(
            imagePath: selectedProfileImagePath.value!,
          ));
    } else {
      showMySnackbar(msg: LocaleKeys.app_no_img_selected.tr);
    }
  }

  //
  Future<void> userDetailsAPI() async {
    isBtnLoading.value = true;
    final storageService = Get.find<GetStorageService>();
    final File pickedImageFile =
        File(selectedProfileImagePath.value?.path ?? "");
    String extension = pickedImageFile.path.split('.').last;
    String mediaType;

    if (extension == 'jpg' || extension == 'jpeg') {
      mediaType = 'image/jpeg';
    } else if (extension == 'png') {
      mediaType = 'image/png';
    } else {
      mediaType = 'application/octet-stream';
    }
    String genderValue = "";
    if (gender.text == "Prefer not to say") {
      genderValue = "Other";
    } else {
      genderValue = gender.value.text;
    }

    final userData = dio.FormData.fromMap({
      'fullName': fullName.text,
      if (email.value.text.isNotEmpty) 'email': email.text,
      'phone': "+1${phoneNumber.text}",
      'gender': genderValue,
      'city': city.value.text,
      if (dateOfBirth.value.text.isNotEmpty) 'dob': dateOfBirth.text,
      'profilePic': await dio.MultipartFile.fromFile(
        pickedImageFile.path,
        contentType: MediaType.parse(mediaType),
        filename: path.basename(pickedImageFile.path),
      ),
    });

    try {
      final response = await APIManager.userDetails(body: userData);
      if (response.data['status'] == true) {
        storageService.setUserName = fullName.text;
        storageService.isLoggedIn = true;
        storageService.profileStatus = true;
        decideRoutingAfterSignUp();
        /*Get.offNamed(Routes.EMERGENCY_CONTACTS,
            arguments: {'fromNavBar': fromNavBar, 'isDriver': false},
            parameters: {"profileType": "user"});*/
        showMySnackbar(msg: "Data saved succesfully.");
        isBtnLoading.value = false;
        Get.find<HomeController>().userInfoAPI();
      } else {
        showMySnackbar(msg: response.data['message'].toString());
        isBtnLoading.value = false;
      }
    } catch (e) {
      isBtnLoading.value = false;
      throw Exception(e);
    }
  }

  Future<void> decideRoutingAfterSignUp() async {
    if (fromNavBar) {
      Get.offAllNamed(Routes.BOTTOM_NAVIGATION);
      await Future.delayed(const Duration(seconds: 1))
          .then((value) => Get.find<HomeController>().changeTabIndex(0));
      Get.find<HomeController>().userInfoAPI();
    } else {
      // Get.until((route) => Get.currentRoute == Routes.FIND_RIDE);
      Get.back();
    }
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    } else if (!GetUtils.isEmail(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? nameValidator(String? value) {
    // Check if the value is empty
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }

    // Check if the value contains only letters (and optionally spaces)
    final RegExp nameExp = RegExp(r'^[a-zA-Z\s]+$');
    if (!nameExp.hasMatch(value)) {
      return 'Please enter a valid name';
    }

    return null; // Return null if the value is valid
  }

  String? phoneNumberValidator(String? value) {
    // Check if the value is empty
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    }

    // Check if the value contains exactly 10 digits
    final RegExp phoneExp = RegExp(r'^[0-9]{10}$');
    if (!phoneExp.hasMatch(value)) {
      return 'Please enter a valid 10-digit phone number';
    }

    return null; // Return null if the value is valid
  }

  String? validateGender(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select your gender';
    }
    return null;
  }

  String? validateCity(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select your city';
    }
    return null;
  }

  String? validateDOB(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select your Date of birth';
    }
    return null;
  }

  Future<void> checkUserValidations() async {
    final isValid = userFormKey.currentState!.validate();

    if (!isValid) {
      isProfileImagePickedCheck.value = true;

      if (!isProfileImagePicked.value) {
        _scrollToTop();
        return showMySnackbar(msg: 'Please upload your profile image');
      }

      if (_isFieldEmpty(
        fullName.text,
        nameFocusNode,
        'Please enter your name',
      )) return;

      if (!_isValidEmail(
        email.text,
        emailFocusNode,
        'Please enter a valid email address',
      )) return;

      if (readOnlyEmail &&
          _isFieldEmpty(
            phoneNumber.text,
            phoneFocusNode,
            'Please enter your phone number',
          )) return;

      if (_isFieldEmpty(
        gender.text,
        genderFocusNode,
        'Please select your gender',
      )) {
        isGenderListExpanded.value = true;
        return;
      }

      if (_isFieldEmpty(
        city.text,
        cityFocusNode,
        'Please select your city province',
      )) return;

      return showMySnackbar(msg: 'Please fill in all the details');
    }

    // Handle valid form case
    if (!isProfileImagePicked.value) {
      isProfileImagePickedCheck.value = true;
      _scrollToTop();
      return showMySnackbar(msg: 'Please upload your profile image');
    }

    // Save form and make API call
    userFormKey.currentState!.save();
    await userDetailsAPI();
  }

  void _scrollToTop() {
    scrollController.animateTo(
      0.0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  bool _isFieldEmpty(
      String fieldValue, FocusNode focusNode, String errorMessage) {
    if (fieldValue.isEmpty) {
      focusNode.requestFocus();
      showMySnackbar(msg: errorMessage);
      return true;
    }
    return false;
  }

  bool _isValidEmail(
      String emailValue, FocusNode focusNode, String errorMessage) {
    if (emailValue.isNotEmpty && !GetUtils.isEmail(emailValue)) {
      focusNode.requestFocus();
      showMySnackbar(msg: errorMessage);
      return false;
    }
    return true;
  }

  void addCityNames(String value) {
    if (value.isEmpty || value == "") {
      cityNames.value = CityList.cityNames;
    } else {
      isCityListExpanded.value = true;
      cityNames.value = CityList.cityNames.where((city) {
        return city.toLowerCase().contains(value.toLowerCase());
      }).toList();
    }
  }
}

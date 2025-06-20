import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/components/common_image_view.dart';
import 'package:green_pool/app/components/greenpool_appbar.dart';
import 'package:green_pool/app/res/strings.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../generated/locales.g.dart';
import '../../../components/greenpool_textfield.dart';
import '../../../components/opt_heading_text.dart';
import '../../../components/richtext_heading.dart';
import '../../../components/upload_id.dart';
import '../../../constants/image_constant.dart';
import '../../../services/colors.dart';
import '../../../services/custom_button.dart';
import '../../../services/text_style_util.dart';
import '../../../components/upload_add_picture.dart';
import '../controllers/rider_profile_setup_controller.dart';

class RiderProfileSetupView extends GetView<RiderProfileSetupController> {
  const RiderProfileSetupView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => RiderProfileSetupController());
    return Scaffold(
      appBar: GreenPoolAppBar(
        leading: const SizedBox(),
        appBarSize: 8.kh,
      ),
      body: SingleChildScrollView(
        controller: controller.scrollController,
        child: Form(
          key: controller.userFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocaleKeys.app_profileSetup.tr,
                style: TextStyleUtil.k32Heading700(),
              ).paddingOnly(bottom: 4.kh, top: 16.kh),
              Text(
                LocaleKeys.app_editProfileDetails.tr,
                style: TextStyleUtil.k16Regular(color: ColorUtil.kBlack04),
              ).paddingOnly(bottom: 40.kh),
              Center(
                child: ProfileImage(controller: controller),
              ).paddingOnly(bottom: 40.kh),
              RichTextHeading(text: LocaleKeys.app_fullName.tr).paddingOnly(bottom: 8.kh),
              GreenPoolTextField(
                hintText: LocaleKeys.app_enterName.tr,
                controller: controller.fullName,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp(r'[a-zA-Z\s]')), // Allow only alphabets and spaces
                ],
                validator: (value) => controller.nameValidator(value),
                focusNode: controller.nameFocusNode,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                suffix: SvgPicture.asset(ImageConstant.svgProfileEditPen),
              ).paddingOnly(bottom: 16.kh),
              OptFieldHeading(heading: LocaleKeys.app_emailAddress.tr)
                  .paddingOnly(bottom: 8.kh),
              GreenPoolTextField(
                hintText: LocaleKeys.app_enterEmailId.tr,
                controller: controller.email,
                keyboardType: TextInputType.emailAddress,
                suffix: controller.readOnlyEmail
                    ? const SizedBox()
                    : SvgPicture.asset(ImageConstant.svgProfileEditPen),
                readOnly: controller.readOnlyEmail,
              ).paddingOnly(bottom: 16.kh),
              RichTextHeading(text: LocaleKeys.app_phoneNumber.tr)
                  .paddingOnly(bottom: 8.kh),
              GreenPoolTextField(
                hintText: LocaleKeys.app_enterPhoneNumber.tr,
                controller: controller.phoneNumber,
                prefix: Text(
                  controller.prefix,
                  style: TextStyleUtil.k14Regular(
                    color: ColorUtil.kBlack03,
                  ),
                ),
                focusNode: controller.phoneFocusNode,
                keyboardType: TextInputType.number,
                validator: (value) => controller.phoneNumberValidator(value),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                readOnly: !controller.readOnlyEmail,
              ).paddingOnly(bottom: 16.kh),
              RichTextHeading(text: LocaleKeys.app_gender.tr).paddingOnly(bottom: 8.kh),
              Obx(
                () => GreenPoolTextField(
                  hintText: LocaleKeys.app_selectGender.tr,
                  controller: controller.gender,
                  validator: (value) => controller.validateGender(value),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  focusNode: controller.genderFocusNode,
                  readOnly: true,
                  suffix: controller.isGenderListExpanded.value
                      ? const Icon(Icons.arrow_drop_up)
                      : const Icon(Icons.arrow_drop_down),
                  onTap: () {
                    controller.isGenderListExpanded.toggle();
                  },
                ).paddingOnly(
                    bottom: controller.isGenderListExpanded.value ? 0 : 16.kh),
              ),
              Obx(
                () => Visibility(
                  visible: controller.isGenderListExpanded.value,
                  child: SizedBox(
                    child: Card(
                      elevation: 4.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(8.kh),
                            bottomRight: Radius.circular(8.kh)),
                      ),
                      color: ColorUtil.kGreyColor,
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: controller.genderList.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 1.kh,
                                          color: ColorUtil.kNeutral7)),
                                  borderRadius: BorderRadius.circular(8.kh)),
                              child: RadioListTile<String>(
                                  title: Text(controller.genderList[index]),
                                  value: controller.genderList[index],
                                  groupValue: controller.gender.text,
                                  fillColor: const WidgetStatePropertyAll(
                                      ColorUtil.kSecondary01),
                                  onChanged: (value) {
                                    if (value != null) {
                                      controller.gender.text = value;
                                      controller.isGenderListExpanded.value =
                                          false;
                                    }
                                  }));
                        },
                      ),
                    ),
                  ).paddingOnly(bottom: 16.kh),
                ),
              ),
              RichTextHeading(text: LocaleKeys.app_cityProvince.tr)
                  .paddingOnly(bottom: 8.kh),
              Obx(
                () => GreenPoolTextField(
                  hintText: LocaleKeys.app_selectCity.tr,
                  controller: controller.city,
                  focusNode: controller.cityFocusNode,
                  validator: (value) => controller.validateCity(value),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  suffix: controller.isCityListExpanded.value
                      ? const Icon(Icons.arrow_drop_up)
                      : const Icon(Icons.arrow_drop_down),
                  onPressedSuffix: () {
                    controller.isCityListExpanded.toggle();
                    controller.addCityNames("");
                  },
                  onchanged: (value) {
                    controller.addCityNames(value ?? "");
                  },
                ).paddingOnly(
                    bottom: controller.isCityListExpanded.value ? 0 : 16.kh),
              ),
              Obx(
                () => Visibility(
                  visible: controller.isCityListExpanded.value,
                  child: SizedBox(
                      height: controller.cityNames.length == 1
                          ? 70.kh
                          : (controller.cityNames.length * 70.kh)
                              .clamp(70.kh, 240.kh),
                      child: Card(
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(8.kh),
                              bottomRight: Radius.circular(8.kh)),
                        ),
                        color: ColorUtil.kGreyColor,
                        child: ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: controller.cityNames.length ?? 0,
                            itemBuilder: (context, index) {
                              return Container(
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            width: 1.kh,
                                            color: ColorUtil.kNeutral7)),
                                    borderRadius: BorderRadius.circular(8.kh)),
                                child: RadioListTile<String>(
                                    title: Text(controller.cityNames[index]),
                                    groupValue: controller.city.text,
                                    value: controller.cityNames[index],
                                    fillColor: const WidgetStatePropertyAll(
                                        ColorUtil.kSecondary01),
                                    onChanged: (value) {
                                      if (value != null) {
                                        controller.city.text =
                                            controller.cityNames[index];
                                        controller.isCityListExpanded.value =
                                            false;
                                      }
                                    }),
                              );
                            }),
                      )).paddingOnly(bottom: 16.kh),
                ),
              ),
              OptFieldHeading(heading: LocaleKeys.app_dateOfBirth.tr)
                  .paddingOnly(bottom: 8.kh),
              GreenPoolTextField(
                hintText: LocaleKeys.app_enterDateOfBirth.tr,
                controller: controller.formattedDateOfBirth,
                readOnly: true,
                onTap: () => controller.setDate(context),
                suffix: SvgPicture.asset(ImageConstant.svgIconCalendar),
              ),
              /*OptFieldHeading(heading: LocaleKeys.app_idVerification.tr)
                  .paddingOnly(bottom: 8.kh),
              GestureDetector(
                onTap: () => Get.to(() => UploadIDView(
                      onPressedGallery: () {
                        controller.getIDImage(ImageSource.gallery);
                      },
                      onPressedSelfie: () {
                        controller.getIDImage(ImageSource.camera);
                      },
                    )),
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 68.kh, horizontal: 76.kw),
                  decoration: BoxDecoration(
                      color: ColorUtil.kGreyColor,
                      borderRadius: BorderRadius.circular(8.kh)),
                  child: Obx(
                    () => controller.isIDPicked.value
                        ? Image.file(
                            controller.selectedIDImagePath.value!,
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(ImageConstant.svgIconUpload)
                                  .paddingOnly(right: 8.kw),
                              Text(
                                LocaleKeys.app_uploadId.tr,
                                style: TextStyleUtil.k14Regular(
                                    color: ColorUtil.kBlack03),
                              ),
                            ],
                          ),
                  ),
                ),
              ),*/
              Obx(
                () => GreenPoolButton(
                  onPressed: () => controller.checkUserValidations(),
                  label: LocaleKeys.app_proceed.tr,
                  isLoading: controller.isBtnLoading.value,
                ).paddingSymmetric(vertical: 40.kh),
              ),
            ],
          ).paddingSymmetric(horizontal: 16.kw),
        ),
      ),
    );
  }
}

class ProfileImage extends StatelessWidget {
  const ProfileImage({
    super.key,
    required this.controller,
  });

  final RiderProfileSetupController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => Get.to(() => AddPictureView(
                onPressedGallery: () {
                  controller.getProfileImage(ImageSource.gallery);
                },
                onPressedSelfie: () {
                  controller.getProfileImage(ImageSource.camera);
                },
              )),
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              Obx(
                () => Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: controller.isProfileImagePickedCheck.value &&
                                (controller.selectedProfileImagePath.value
                                            ?.path ??
                                        "")
                                    .isEmpty
                            ? Colors.red
                            : Colors.transparent,
                        style: BorderStyle.solid),
                  ),
                  child: controller.isProfileImagePicked.value
                      ? ClipOval(
                          child: SizedBox.fromSize(
                              size: Size.fromRadius(44.kh),
                              child: CommonImageView(
                                file:
                                    controller.selectedProfileImagePath.value!,
                              )),
                        )
                      : SvgPicture.asset(ImageConstant.svgSetupProfilePic),
                ),
              ),
              SvgPicture.asset(ImageConstant.svgSetupAddSec01),
            ],
          ).paddingOnly(bottom: 12.kh),
        ),
        Text(
          LocaleKeys.app_takeOrUploadProfilePic.tr,
          style: TextStyleUtil.k16Regular(color: ColorUtil.kNeutral4),
        ),
      ],
    );
  }
}

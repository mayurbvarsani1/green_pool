import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/components/greenpool_textfield.dart';
import 'package:green_pool/app/components/socials.dart';
import 'package:green_pool/app/routes/app_pages.dart';
import 'package:green_pool/app/services/colors.dart';
import 'package:green_pool/app/services/custom_button.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import 'package:green_pool/app/services/text_style_util.dart';

import '../../../../generated/locales.g.dart';
import '../controllers/create_account_controller.dart';

class CreateAccountView extends GetView<CreateAccountController> {
  const CreateAccountView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: controller.formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LocaleKeys.app_createAccount.tr,
                  style: TextStyleUtil.k32Heading700(),
                ).paddingOnly(top: 48.kh),
                Text(
                  LocaleKeys.app_enterDetails.tr,
                  style: TextStyleUtil.k16Regular(color: ColorUtil.kBlack04),
                ).paddingOnly(bottom: 32.kh),

                //
                Text(
                  LocaleKeys.app_fullName.tr,
                  style: TextStyleUtil.k14Semibold(),
                ).paddingOnly(bottom: 8.kh),
                GreenPoolTextField(
                  hintText: LocaleKeys.app_enterName.tr,
                  controller: controller.fullNameController,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(
                        r'[a-zA-Z\s]')), // Allow only alphabets and spaces
                  ],
                  keyboardType: TextInputType.name,
                  validator: (value) => controller.nameValidator(value),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ).paddingOnly(bottom: 12.kh),
                //

                Text(
                  LocaleKeys.app_phoneNumber.tr,
                  style: TextStyleUtil.k14Semibold(),
                ).paddingOnly(bottom: 8.kh),
                GreenPoolTextField(
                  hintText: LocaleKeys.app_enterHere.tr,
                  keyboardType: TextInputType.phone,
                  controller: controller.phoneNumberController,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp(r'[0-9]')), // Only allow digits (0-9)
                    FilteringTextInputFormatter.deny(
                        RegExp(r'[^\w\s]')), // Deny all special characters
                    LengthLimitingTextInputFormatter(3),

                  ],
                  validator: (value) => controller.phoneNumberValidator(value),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  prefix: CountryCodePicker(
                    onChanged: (countryCode) {
                      controller.countryCode = countryCode.dialCode ?? "+1";
                    },
                    padding: const EdgeInsets.all(0),
                    showFlag: true,
                    hideSearch: true,
                    dialogSize: Size(60.kw, 25.h),
                    initialSelection: 'CA',
                    countryFilter: const ['CA','IN'],
                    searchDecoration: InputDecoration(
                      focusColor: ColorUtil.kNeutral6,
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.kh)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.kh)),
                    ),
                  ),
                  onchanged: (String? value) =>
                      controller.phoneNumberController.text = value!,
                ).paddingOnly(bottom: 12.kh),

                //
                // Text(
                //   'Password',
                //   style: TextStyleUtil.k14Semibold(),
                // ).paddingOnly(bottom: 8.kh),
                // Obx(
                //   ()=> GreenPoolTextField(
                //     hintText: 'Enter password here',
                //     suffix: controller.isVisible.value ? Icon(Icons.visibility, size: 20.kh,color: ColorUtil.kSecondary01,) : Icon(Icons.visibility_off_sharp, size: 20.kh,color: ColorUtil.kSecondary01,),
                //     onPressedSuffix: () {
                //       controller.setVisible();
                //     },
                //     obscureText: !controller.isVisible.value,
                //     controller: controller.passwordTextController,
                //     validator: (value) => controller.passwordValidator(value),
                //     autovalidateMode: AutovalidateMode.onUserInteraction,
                //   ).paddingOnly(bottom: 12.kh),
                // ),
                //

                Row(
                  children: [
                    Obx(
                      () => Checkbox(
                        value: controller.isTermsAccepted.value,
                        activeColor: ColorUtil.kSecondary01,
                        onChanged: (value) {
                          controller.toggleCheckbox();
                        },
                      ),
                    ),
                    Expanded(
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: LocaleKeys.app_readAndAgree.tr,
                              style: TextStyleUtil.k12Regular(),
                            ),
                            TextSpan(
                                text: LocaleKeys.app_termsCondition.tr,
                                style: TextStyleUtil.k12Semibold(
                                    color: ColorUtil.kSecondary03),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () =>
                                      Get.toNamed(Routes.TERMS_CONDITIONS)),
                            TextSpan(
                              text: LocaleKeys.app_and.tr,
                              style: TextStyleUtil.k12Regular(),
                            ),
                            TextSpan(
                                text: LocaleKeys.app_privacyPolicy.tr,
                                style: TextStyleUtil.k12Semibold(
                                    color: ColorUtil.kSecondary03),
                                recognizer: TapGestureRecognizer()
                                  ..onTap =
                                      () => Get.toNamed(Routes.POLICY_PRIVACY)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ).paddingOnly(bottom: 32.kh),
                Obx(
                  () => GreenPoolButton(
                    onPressed: () async {
                      await controller.checkValidation();
                    },
                    isActive: controller.isTermsAccepted.value,
                    label: LocaleKeys.app_signUp.tr,
                  ).paddingOnly(bottom: 16.kh),
                ),
                Center(
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                            text: LocaleKeys.app_alreadyHaveAcc.tr,
                            style: TextStyleUtil.k14Semibold(
                                color: ColorUtil.kBlack04)),
                        TextSpan(
                            text: LocaleKeys.app_spaceLogin.tr,
                            style: TextStyleUtil.k14Semibold(
                                color: ColorUtil.kSecondary01),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => controller.moveToLogin()),
                      ],
                    ),
                  ).paddingOnly(bottom: 32.kh),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        height: 1.kh,
                        color: ColorUtil.kNeutral2,
                      ).paddingOnly(right: 8.kw),
                    ),
                    Text(
                      LocaleKeys.app_orSignUpWith.tr,
                      style:
                          TextStyleUtil.k12Semibold(color: ColorUtil.kNeutral3),
                    ),
                    Expanded(
                      child: Container(
                        height: 1.kh,
                        color: ColorUtil.kNeutral2,
                      ).paddingOnly(left: 8.kw),
                    ),
                  ],
                ).paddingOnly(bottom: 24.kh),
                Socials(
                  onPressedGoogle: () {
                    FocusScope.of(context).unfocus();
                    controller.googleAuth();
                  },
                  onPressedFacebook: () {
                    FocusScope.of(context).unfocus();
                    controller.facebookAuth();
                  },
                  onPressedApple: () {
                    FocusScope.of(context).unfocus();
                    controller.appleAuth();
                  },
                ).paddingOnly(bottom: 40.kh),
              ],
            ).paddingOnly(left: 16.kw, right: 16.kw),
          ),
        ),
      ),
    );
  }
}

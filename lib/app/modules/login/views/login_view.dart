import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:green_pool/app/res/strings.dart';
import 'package:green_pool/app/services/colors.dart';
import 'package:green_pool/app/services/custom_button.dart';
import 'package:green_pool/app/services/responsive_size.dart';
import 'package:green_pool/app/services/text_style_util.dart';

import '../../../../generated/locales.g.dart';
import '../../../components/greenpool_textfield.dart';
import '../../../components/socials.dart';
import '../../create_account/controllers/create_account_controller.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => CreateAccountController());
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Form(
            key: controller.loginKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LocaleKeys.app_login.tr,
                  style: TextStyleUtil.k32Heading700(),
                ).paddingOnly(top: 48.kh, bottom: 4.kh),
                Text(
                  LocaleKeys.app_enterLoginDetails.tr,
                  style: TextStyleUtil.k16Regular(color: ColorUtil.kBlack04),
                ).paddingOnly(bottom: 40.kh),
                //
                Text(
                  LocaleKeys.app_phoneNumber.tr,
                  style: TextStyleUtil.k14Semibold(),
                ).paddingOnly(bottom: 8.kh),
                GreenPoolTextField(
                  hintText: LocaleKeys.app_enterHere.tr,
                  controller: controller.phoneNumberController,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp(r'[0-9]')), // Only allow digits (0-9)
                    FilteringTextInputFormatter.deny(
                        RegExp(r'[^\w\s]')), // Deny all special characters
                    LengthLimitingTextInputFormatter(10),

                  ],
                  keyboardType: TextInputType.phone,
                  validator: (value) => controller.phoneNumberValidator(value),
                  onchanged: (v) {},
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  autofocus: false,
                  prefix: CountryCodePicker(
                    onChanged: (countryCode) {
                      controller.countryCode = countryCode.dialCode ?? "+1";
                      debugPrint("controller.countryCode=>${controller.countryCode}");
                    },
                    padding: const EdgeInsets.all(0),
                    dialogSize: Size(60.kw, 25.h),
                    initialSelection: 'CA',
                    countryFilter: const ['CA','IN'],
                    showFlag: true,
                    hideSearch: true,
                    searchDecoration: InputDecoration(
                      focusColor: ColorUtil.kNeutral6,
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.kh)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.kh)),
                    ),
                  ),
                ).paddingOnly(bottom: 12.kh),
                //

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

                // Row(
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   children: [
                //     Text.rich(
                //       TextSpan(
                //         children: [
                //           TextSpan(
                //             text: "Forgot password?",
                //             style: TextStyleUtil.k14Semibold(
                //                 color: ColorUtil.kBlack03),
                //             recognizer: TapGestureRecognizer()
                //               ..onTap = () => Get.toNamed(
                //                   Routes.FORGOT_PASSWORD,
                //                   arguments: controller.isDriver),
                //           ),
                //         ],
                //       ),
                //       textAlign: TextAlign.center,
                //     ),
                //   ],
                // ),

                GreenPoolButton(
                  onPressed: () async {
                    // await controller.otpAuth();
                    await controller.checkLogin();
                  },
                  label: LocaleKeys.app_login.tr,
                  // isActive: controller.isActive.value,
                ).paddingSymmetric(vertical: 40.kh),

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
                      LocaleKeys.app_orLoginWith.tr,
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
                ).paddingOnly(bottom: 40.kh),
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
                ),
                const Expanded(child: SizedBox()),
                Center(
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                            text: LocaleKeys.app_dontHaveAccount.tr,
                            style: TextStyleUtil.k14Regular(
                                color: ColorUtil.kBlack04)),
                        TextSpan(
                            text: LocaleKeys.app_createAccount.tr,
                            style: TextStyleUtil.k14Regular(
                                color: ColorUtil.kSecondary01),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => controller.moveToCreateAcc()),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ).paddingOnly(bottom: 24.kh),
                ),
              ],
            ).paddingSymmetric(horizontal: 16.kw),
          ),
        ));
  }
}

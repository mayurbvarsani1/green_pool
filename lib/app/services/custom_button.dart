import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_pool/app/services/responsive_size.dart';

import '../modules/home/controllers/home_controller.dart';
import 'colors.dart';
import 'text_style_util.dart';

class GreenPoolButton extends StatelessWidget {
  final bool isActive;
  final bool isBorder;
  final bool isLoading;
  final String? label;
  final double? width, fontSize, height, borderRadius, borderWidth;
  final Function()? onPressed;
  final Widget? child;
  final Color? color, borderColor, labelColor, loadingColor;
  final EdgeInsetsGeometry? padding;
  final FontWeight? fontWeight;
  const GreenPoolButton({
    super.key,
    this.label,
    this.borderRadius,
    this.fontSize,
    required this.onPressed,
    this.width,
    this.color,
    this.child,
    this.height,
    this.isActive = true,
    this.isBorder = false,
    this.borderWidth,
    this.borderColor,
    this.isLoading = false,
    this.labelColor,
    this.padding,
    this.loadingColor,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: isLoading || !isActive ? () {} : onPressed,
        /*Get.find<GetStorageService>().accSuspended
            ? () {
                DialogHelper.accSuspendedDialog(() async {
                  Get.back();
                  Get.offAllNamed(Routes.BOTTOM_NAVIGATION);
                  await Future.delayed(const Duration(seconds: 1)).then(
                      (value) => Get.find<HomeController>().changeTabIndex(3));
                  Get.toNamed(Routes.HELP_SUPPORT);
                });
              }
            :*/
        style: ElevatedButton.styleFrom(
          foregroundColor: ColorUtil.kWhiteColor,
          surfaceTintColor: ColorUtil.kSecondary07,
          shadowColor: ColorUtil.kWhiteColor,
          minimumSize: Size(width ?? 343.kw, height ?? 56.kh),
          padding: padding ?? EdgeInsets.symmetric(vertical: 16.kh),
          elevation: 0,
          backgroundColor: color ??
              (isBorder
                  ? Colors.transparent
                  : Get.find<HomeController>().isPinkModeOn.value
                      ? (isActive
                          ? ColorUtil.kPrimaryPinkMode
                          : ColorUtil.kSecondaryPinkMode)
                      : (isActive
                          ? ColorUtil.kPrimary01
                          : ColorUtil.kPrimary06)),
          shape: RoundedRectangleBorder(
              side: isBorder
                  ? BorderSide(
                      color: borderColor ?? ColorUtil.kSecondary01,
                      width: borderWidth ?? 1.kh)
                  : BorderSide.none,
              borderRadius: BorderRadius.circular(borderRadius ?? 100.kh)),
        ),
        child: isLoading
            ? isActive
                ? SizedBox(
                    height: 20.kh,
                    width: 20.kh,
                    child: CircularProgressIndicator(
                        color: loadingColor ?? Colors.white),
                  )
                : SizedBox(
                    height: 20.kh,
                    width: 20.kh,
                    child: CircularProgressIndicator(
                        color: loadingColor ?? Colors.white),
                  )
            : child ??
                Text(
                  label ?? '',
                  style: TextStyleUtil.k16Semibold(
                       fontWeight: fontWeight ?? FontWeight.w500 ,

                      fontSize: fontSize ?? 16.kh,
                      color: isActive
                          ? isBorder
                              ? labelColor ?? ColorUtil.kSecondary01
                              : labelColor ?? ColorUtil.kBlack01
                          : labelColor ?? ColorUtil.kBlack05),
                ),
      ),
    );
  }
}

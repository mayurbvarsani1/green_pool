import 'package:flutter/material.dart';
import 'hexColorToFlutterColor.dart';

extension ColorUtil on BuildContext {
  Color dynamicColor({required int light, required int dark}) {
    return (Theme.of(this).brightness == Brightness.light)
        ? Color(light)
        : Color(dark);
  }

  Color dynamicColour({required Color light, required Color dark}) {
    return (Theme.of(this).brightness == Brightness.light) ? light : dark;
  }

  Color get brandColor1 =>
      dynamicColour(light: HexColor("#5D48D0"), dark: HexColor("#000000"));

  Color get brandColor2 =>
      dynamicColour(light: HexColor("#8032A8"), dark: HexColor("#000000"));

  //primary
  static const Color kPrimary07 = Color(0xfff5fdf0);
  static const Color kPrimary06 = Color(0xffe7fada);
  static const Color kPrimary05 = Color(0xffd8f6c5);
  static const Color kPrimary04 = Color(0xffcaf3b0);
  static const Color kPrimary03 = Color(0xffbcef9b);
  static const Color kPrimary02 = Color(0xffadec85);
  static const Color kPrimary01 = Color(0xff9fe870);

  static const Color kWhiteColor = Color(0xffffffff);
  static const Color kGreyColor = Color(0xffF4F4F4);
  static Color kBackgroundColor = Colors.grey.shade50;
  static const Color kGreenColor = Color(0xFF34A853);
  static const Color kYellowColor = Color(0xFFF6DD00);
  static const Color kBlueColor = Color(0xFF4285F4);

  static const Color kSecondaryPinkMode = Color(0xffffe5e9);
  static const Color kPrimaryPinkMode = Color(0xffffc0cb);
  static const Color kPrimary2PinkMode = Color(0xfffe889d);
  static const Color kPrimary3PinkMode = Color(0xffff6782);
  static const Color kPrimary4PinkMode = Color(0xffffd3da);
  static const Color kPrimary5PinkMode = Color(0xffffeff1);

  //neutral
  static const Color kNeutral1 = Color(0xFFEEEEEE);
  static const Color kNeutral2 = Color(0xFFE6E5E4);
  static const Color kNeutral3 = Color(0xFF5C5C5C);
  static const Color kNeutral4 = Color(0xFF8A8A8A);
  static const Color kNeutral5 = Color(0xFF17161D);
  static const Color kNeutral6 = Color(0xFF2D2D2D);
  static const Color kNeutral7 = Color(0xFFEBEBEB);
  static const Color kNeutral8 = Color(0xFFE7E5E4);
  static const Color kNeutral9 = Color(0xFFDEDEDE);
  static const Color kNeutral10 = Color(0xFF454745);
  static const Color kNeutral11 = Color(0xFFF5F5F5);
  static const Color kNeutral12 = Color(0xFFEAEAEA);
  static const Color appGray5= Color(0xFFBFBFBF);

  //secondary
  static const Color kSecondary07 = Color(0xffe4f9d5);
  static const Color kSecondary06 = Color(0xffc2d8b1);
  static const Color kSecondary05 = Color(0xffa0b78e);
  static const Color kSecondary04 = Color(0xff7d966a);
  static const Color kSecondary03 = Color(0xff5b7547);
  static const Color kSecondary02 = Color(0xff385423);
  static const Color kSecondary01 = Color(0xff163300);

  //black
  static const Color kBlack011 = Color(0xFF121417);
  static const Color kBlack010 = Color(0xFF61758A);
  static const Color kBlack09 = Color(0xFF373737);
  static const Color kBlack08 = Color(0xffF2F2F5);
  static const Color kBlack07 = Color(0xfff6f6f6);
  static const Color kBlack06 = Color(0xffcfcfcf);
  static const Color kBlack05 = Color(0xffa8a9a8);
  static const Color kBlack04 = Color(0xff828281);
  static const Color kBlack03 = Color(0xff5b5c5a);
  static const Color kBlack02 = Color(0xff353533);
  static const Color kBlack01 = Color(0xff0e0f0c);

  //error
  static const Color kError1 = Color(0xfff9dcdc);
  static const Color kError2 = Color(0xffde2121);
  static const Color kError3 = Color(0xFFFF2E39);
  static const Color kError4 = Color(0xFFEA4335);
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:green_pool/app/services/colors.dart';
import 'package:green_pool/app/services/responsive_size.dart';

class TextStyleUtil {
  static TextStyle genSans300({
    Color color = Colors.white,
    required double fontSize,
  }) {
    return TextStyle(
      fontFamily: 'General Sans',
      color: color,
      fontSize: fontSize,
      fontWeight: FontWeight.w300,
    );
  }

  static TextStyle genSans400({
    Color color = Colors.white,
    required double fontSize,
  }) {
    return TextStyle(
      fontFamily: 'General Sans',
      color: color,
      fontSize: fontSize,
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle genSans500({
    Color color = Colors.white,
    required double fontSize,
  }) {
    return TextStyle(
      fontFamily: 'General Sans',
      color: color,
      fontSize: fontSize,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle genSans600({
    Color color = Colors.white,
    required double fontSize,
  }) {
    return TextStyle(
      fontFamily: 'General Sans',
      color: color,
      fontSize: fontSize,
      fontWeight: FontWeight.w600,
    );
  }

  //inter
  static k18Regular({
    Color color = ColorUtil.kBlack01,
    FontWeight fontWeight = FontWeight.w400,
    TextDecoration textDecoration = TextDecoration.none,
  }) {
    return GoogleFonts.inter(
      fontWeight: fontWeight,
      color: color,
      fontStyle: FontStyle.normal,
      fontSize: 18.kh,
      decoration: textDecoration,
      letterSpacing: 0.20000000298023224,
    );
  }

  static k18Semibold({
    Color color = ColorUtil.kBlack01,
    FontWeight fontWeight = FontWeight.w500,
    TextDecoration textDecoration = TextDecoration.none,
  }) {
    return GoogleFonts.inter(
      fontWeight: fontWeight,
      color: color,
      fontStyle: FontStyle.normal,
      fontSize: 18.kh,
      decoration: textDecoration,
      letterSpacing: 0.20000000298023224,
    );
  }

  static k18Bold({
    Color color = ColorUtil.kBlack01,
    FontWeight fontWeight = FontWeight.w600,
    TextDecoration textDecoration = TextDecoration.none,
  }) {
    return GoogleFonts.inter(
      fontWeight: fontWeight,
      color: color,
      fontStyle: FontStyle.normal,
      fontSize: 18.kh,
      decoration: textDecoration,
      letterSpacing: 0.20000000298023224,
    );
  }

  static k18Medium({
    Color color = ColorUtil.kBlack01,
    FontWeight fontWeight = FontWeight.w600,
    TextDecoration textDecoration = TextDecoration.none,
  }) {
    return GoogleFonts.inter(
      fontWeight: fontWeight,
      color: color,
      fontStyle: FontStyle.normal,
      fontSize: 18.kh,
      decoration: textDecoration,
      letterSpacing: 0.20000000298023224,
    );
  }

  static k16Regular({
    Color color = ColorUtil.kBlack01,
    FontWeight fontWeight = FontWeight.w400,
    TextDecoration textDecoration = TextDecoration.none,
  }) {
    return GoogleFonts.inter(
      fontWeight: fontWeight,
      color: color,
      fontStyle: FontStyle.normal,
      fontSize: 16.kh,
      decoration: textDecoration,
      letterSpacing: 0,
    );
  }

  static k16Medium({
    Color color = ColorUtil.kBlack01,
    FontWeight fontWeight = FontWeight.w600,
    TextDecoration textDecoration = TextDecoration.none,
  }) {
    return GoogleFonts.inter(
      fontWeight: fontWeight,
      color: color,
      fontStyle: FontStyle.normal,
      fontSize: 16.kh,
      decoration: textDecoration,
      letterSpacing: 0.20000000298023224,
    );
  }

  static k16Semibold({
    Color color = ColorUtil.kBlack01,
    FontWeight fontWeight = FontWeight.w500,
    required double fontSize,
    TextDecoration textDecoration = TextDecoration.none,
  }) {
    return GoogleFonts.inter(
      fontWeight: fontWeight,
      color: color,
      fontStyle: FontStyle.normal,
      fontSize: fontSize,
      decoration: textDecoration,
      letterSpacing: 0.20000000298023224,
    );
  }

  static k16Bold({
    Color color = ColorUtil.kBlack01,
    FontWeight fontWeight = FontWeight.w600,
    TextDecoration textDecoration = TextDecoration.none,
  }) {
    return GoogleFonts.inter(
      fontWeight: fontWeight,
      color: color,
      fontStyle: FontStyle.normal,
      fontSize: 16.kh,
      decoration: textDecoration,
      letterSpacing: 0.20000000298023224,
    );
  }

  static k14Regular({
    Color color = ColorUtil.kBlack01,
    FontWeight fontWeight = FontWeight.w400,
    TextDecoration textDecoration = TextDecoration.none,
  }) {
    return GoogleFonts.inter(
      fontWeight: fontWeight,
      color: color,
      fontStyle: FontStyle.normal,
      fontSize: 14.kh,
      decoration: textDecoration,
      letterSpacing: 0.20000000298023224,
    );
  }

  static k14Medium({
    Color color = ColorUtil.kBlack01,
    FontWeight fontWeight = FontWeight.w600,
    TextDecoration textDecoration = TextDecoration.none,
    double? fontSize,
  }) {
    return GoogleFonts.inter(
      fontWeight: fontWeight,
      color: color,
      fontStyle: FontStyle.normal,
      fontSize: 14.kh,
      decoration: textDecoration,
      letterSpacing: 0.20000000298023224,
    );
  }

  static k14Semibold({
    Color color = ColorUtil.kBlack01,
    FontWeight fontWeight = FontWeight.w500,
    TextDecoration textDecoration = TextDecoration.none,
  }) {
    return GoogleFonts.inter(
      fontWeight: fontWeight,
      color: color,
      fontStyle: FontStyle.normal,
      fontSize: 14.kh,
      decoration: textDecoration,
      letterSpacing: 0.20000000298023224,
    );
  }

  static k14Bold({
    Color color = ColorUtil.kBlack01,
    FontWeight fontWeight = FontWeight.w600,
    TextDecoration textDecoration = TextDecoration.none,
  }) {
    return GoogleFonts.inter(
      fontWeight: fontWeight,
      color: color,
      fontStyle: FontStyle.normal,
      fontSize: 14.kh,
      decoration: textDecoration,
      letterSpacing: 0.20000000298023224,
    );
  }

  static k12Regular({
    Color color = ColorUtil.kBlack01,
    FontWeight fontWeight = FontWeight.w400,
    TextDecoration textDecoration = TextDecoration.none,
  }) {
    return GoogleFonts.inter(
      fontWeight: fontWeight,
      color: color,
      fontStyle: FontStyle.normal,
      fontSize: 12.kh,
      decoration: textDecoration,
      letterSpacing: 0.4000000059604645,
    );
  }

  static k12Medium({
    Color color = ColorUtil.kBlack01,
    FontWeight fontWeight = FontWeight.w600,
    TextDecoration textDecoration = TextDecoration.none,
  }) {
    return GoogleFonts.inter(
      fontWeight: fontWeight,
      color: color,
      fontStyle: FontStyle.normal,
      fontSize: 12.kh,
      decoration: textDecoration,
      letterSpacing: 0.4000000059604645,
    );
  }

  static k12Semibold({
    Color color = ColorUtil.kBlack01,
    FontWeight fontWeight = FontWeight.w500,
    TextDecoration textDecoration = TextDecoration.none,
  }) {
    return GoogleFonts.inter(
      fontWeight: fontWeight,
      color: color,
      fontStyle: FontStyle.normal,
      fontSize: 12.kh,
      decoration: textDecoration,
      letterSpacing: 0.4000000059604645,
    );
  }

  static k12Bold({
    Color color = ColorUtil.kBlack01,
    FontWeight fontWeight = FontWeight.w600,
    TextDecoration textDecoration = TextDecoration.none,
  }) {
    return GoogleFonts.inter(
      fontWeight: fontWeight,
      color: color,
      fontStyle: FontStyle.normal,
      fontSize: 12.kh,
      decoration: textDecoration,
      letterSpacing: 0.4000000059604645,
    );
  }

  static k10Regular({
    Color color = ColorUtil.kBlack01,
    FontWeight fontWeight = FontWeight.w400,
    TextDecoration textDecoration = TextDecoration.none,
  }) {
    return GoogleFonts.inter(
      fontWeight: fontWeight,
      color: color,
      fontStyle: FontStyle.normal,
      fontSize: 10.kh,
      decoration: textDecoration,
      letterSpacing: 0.4000000059604645,
    );
  }

  static k10Medium({
    Color color = ColorUtil.kBlack01,
    FontWeight fontWeight = FontWeight.w600,
    TextDecoration textDecoration = TextDecoration.none,
  }) {
    return GoogleFonts.inter(
      fontWeight: fontWeight,
      color: color,
      fontStyle: FontStyle.normal,
      fontSize: 10.kh,
      decoration: textDecoration,
      letterSpacing: 0,
    );
  }

  static k10Semibold({
    Color color = ColorUtil.kBlack01,
    FontWeight fontWeight = FontWeight.w500,
    TextDecoration textDecoration = TextDecoration.none,
  }) {
    return GoogleFonts.inter(
      fontWeight: fontWeight,
      color: color,
      fontStyle: FontStyle.normal,
      fontSize: 10.kh,
      decoration: textDecoration,
      letterSpacing: 0.4000000059604645,
    );
  }

  static k10Bold({
    Color color = ColorUtil.kBlack01,
    FontWeight fontWeight = FontWeight.w600,
    TextDecoration textDecoration = TextDecoration.none,
  }) {
    return GoogleFonts.inter(
      fontWeight: fontWeight,
      color: color,
      fontStyle: FontStyle.normal,
      fontSize: 10.kh,
      decoration: textDecoration,
      letterSpacing: 0.4000000059604645,
    );
  }

  static k8Semibold({
    Color color = ColorUtil.kBlack01,
    FontWeight fontWeight = FontWeight.w500,
    TextDecoration textDecoration = TextDecoration.none,
  }) {
    return GoogleFonts.inter(
      fontWeight: fontWeight,
      color: color,
      fontStyle: FontStyle.normal,
      fontSize: 8.kh,
      decoration: textDecoration,
      letterSpacing: 0.4000000059604645,
    );
  }

  static k18Heading700({
    Color color = ColorUtil.kBlack01,
    FontWeight fontWeight = FontWeight.w700,
    TextDecoration textDecoration = TextDecoration.none,
  }) {
    return GoogleFonts.inter(
      fontWeight: fontWeight,
      color: color,
      fontStyle: FontStyle.normal,
      fontSize: 18.kh,
      decoration: textDecoration,
      letterSpacing: 0,
    );
  }

  static k20Heading700({
    Color color = ColorUtil.kBlack01,
    FontWeight fontWeight = FontWeight.w700,
    TextDecoration textDecoration = TextDecoration.none,
  }) {
    return GoogleFonts.inter(
      fontWeight: fontWeight,
      color: color,
      fontStyle: FontStyle.normal,
      fontSize: 20.kh,
      decoration: textDecoration,
      letterSpacing: 0,
    );
  }

  static k24Heading700({
    Color color = ColorUtil.kBlack01,
    FontWeight fontWeight = FontWeight.w700,
    TextDecoration textDecoration = TextDecoration.none,
  }) {
    return GoogleFonts.inter(
      fontWeight: fontWeight,
      color: color,
      fontStyle: FontStyle.normal,
      fontSize: 24.kh,
      decoration: textDecoration,
      letterSpacing: 0,
    );
  }

  static k32Heading700({
    Color color = ColorUtil.kBlack01,
    FontWeight fontWeight = FontWeight.w700,
    TextDecoration textDecoration = TextDecoration.none,
  }) {
    return GoogleFonts.inter(
      fontWeight: fontWeight,
      color: color,
      fontStyle: FontStyle.normal,
      fontSize: 32.kh,
      decoration: textDecoration,
      letterSpacing: 0,
    );
  }

  static k40Heading700({
    Color color = ColorUtil.kBlack01,
    FontWeight fontWeight = FontWeight.w700,
    TextDecoration textDecoration = TextDecoration.none,
  }) {
    return GoogleFonts.inter(
      fontWeight: fontWeight,
      color: color,
      fontStyle: FontStyle.normal,
      fontSize: 40.kh,
      decoration: textDecoration,
      letterSpacing: 0,
    );
  }

  static k48Heading700({
    Color color = ColorUtil.kBlack01,
    FontWeight fontWeight = FontWeight.w700,
    TextDecoration textDecoration = TextDecoration.none,
  }) {
    return GoogleFonts.inter(
      fontWeight: fontWeight,
      color: color,
      fontStyle: FontStyle.normal,
      fontSize: 48.kh,
      decoration: textDecoration,
      letterSpacing: -0.5,
    );
  }

  static k18Heading600({
    Color color = ColorUtil.kBlack01,
    FontWeight fontWeight = FontWeight.w600,
    TextDecoration textDecoration = TextDecoration.none,
  }) {
    return GoogleFonts.inter(
      fontWeight: fontWeight,
      color: color,
      fontStyle: FontStyle.normal,
      fontSize: 18.kh,
      decoration: textDecoration,
      letterSpacing: 0,
    );
  }

  static k20Heading600({
    Color color = ColorUtil.kBlack01,
    FontWeight fontWeight = FontWeight.w600,
    TextDecoration textDecoration = TextDecoration.none,
  }) {
    return GoogleFonts.inter(
      fontWeight: fontWeight,
      color: color,
      fontStyle: FontStyle.normal,
      fontSize: 20.kh,
      decoration: textDecoration,
      letterSpacing: 0,
    );
  }

  static k24Heading600({
    Color color = ColorUtil.kBlack01,
    FontWeight fontWeight = FontWeight.w600,
    TextDecoration textDecoration = TextDecoration.none,
  }) {
    return GoogleFonts.inter(
      fontWeight: fontWeight,
      color: color,
      fontStyle: FontStyle.normal,
      fontSize: 24.kh,
      decoration: textDecoration,
      letterSpacing: 0,
    );
  }

  static k32Heading600({
    Color color = ColorUtil.kBlack01,
    FontWeight fontWeight = FontWeight.w600,
    TextDecoration textDecoration = TextDecoration.none,
  }) {
    return GoogleFonts.inter(
      fontWeight: fontWeight,
      color: color,
      fontStyle: FontStyle.normal,
      fontSize: 32.kh,
      decoration: textDecoration,
      letterSpacing: 0,
    );
  }

  static k40Heading600({
    Color color = ColorUtil.kBlack01,
    FontWeight fontWeight = FontWeight.w600,
    TextDecoration textDecoration = TextDecoration.none,
  }) {
    return GoogleFonts.inter(
      fontWeight: fontWeight,
      color: color,
      fontStyle: FontStyle.normal,
      fontSize: 40.kh,
      decoration: textDecoration,
      letterSpacing: 0,
    );
  }

  static k48Heading600({
    Color color = ColorUtil.kBlack01,
    FontWeight fontWeight = FontWeight.w600,
    TextDecoration textDecoration = TextDecoration.none,
  }) {
    return GoogleFonts.inter(
      fontWeight: fontWeight,
      color: color,
      fontStyle: FontStyle.normal,
      fontSize: 48.kh,
      decoration: textDecoration,
      letterSpacing: -0.5,
    );
  }
}

extension AppText on String {
  String get string => this;

  Widget text300(double fontSize,
          {Color color = ColorUtil.kBlack01, TextAlign? textAlign}) =>
      Text(
        string,
        textAlign: textAlign,
        style: TextStyle(
          fontFamily: 'General Sans',
          color: color,
          fontSize: fontSize,
          fontWeight: FontWeight.w300,
        ),
      );

  Widget text400(double fontSize,
          {Color color = ColorUtil.kBlack01, TextAlign? textAlign}) =>
      Text(
        string,
        textAlign: textAlign,
        style: TextStyle(
          fontFamily: 'General Sans',
          color: color,
          fontSize: fontSize,
          fontWeight: FontWeight.w400,
        ),
      );

  Widget text500(double fontSize,
          {Color color = ColorUtil.kBlack01, TextAlign? textAlign}) =>
      Text(
        string,
        textAlign: textAlign,
        style: TextStyle(
          fontFamily: 'General Sans',
          color: color,
          fontSize: fontSize,
          fontWeight: FontWeight.w500,
        ),
      );

  Widget text600(double fontSize,
          {Color color = ColorUtil.kBlack01,
          TextAlign? textAlign,
          TextStyle? style}) =>
      Text(
        string,
        textAlign: textAlign,
        style: style ??
            TextStyle(
              fontFamily: 'General Sans',
              color: color,
              fontSize: fontSize,
              fontWeight: FontWeight.w600,
            ),
      );
}

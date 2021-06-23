import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hey_fellas/common/constants/size_constants.dart';
import 'package:hey_fellas/common/extensions/size_extension.dart';
import 'package:hey_fellas/ui/theme/themecolor.dart';

class ThemeText {
  const ThemeText._();

  static TextTheme get _poppinsTextTheme => GoogleFonts.poppinsTextTheme();

  static TextStyle get _whiteHeadline6 => _poppinsTextTheme.headline6.copyWith(
        fontSize: Sizes.dimen_20.sp,
        color: Colors.white,
      );

  static TextStyle get _whiteHeadline5 => _poppinsTextTheme.headline5.copyWith(
        fontSize: Sizes.dimen_24.sp,
        color: Colors.white,
      );

  static TextStyle get _whiteHeadline2 => _poppinsTextTheme.headline2.copyWith(
        fontSize: Sizes.dimen_36.sp,
        color: Colors.white,
      );

  static TextStyle get _whiteSubtitle1 => _poppinsTextTheme.subtitle2.copyWith(
        fontSize: Sizes.dimen_16.sp,
        color: Colors.white70,
      );

  static TextStyle get _whiteButton => _poppinsTextTheme.button.copyWith(
        fontSize: Sizes.dimen_14.sp,
        color: Colors.white,
      );

  static TextStyle get _whiteBodyText2 => _poppinsTextTheme.bodyText2.copyWith(
        color: Colors.black,
        fontSize: Sizes.dimen_16.sp,
        // wordSpacing: 0.25,
        // letterSpacing: 0.25,
        // height: 1.5,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get _whiteBodyText1 => _poppinsTextTheme.bodyText1.copyWith(
        fontSize: Sizes.dimen_14.sp,
        color: Colors.white54,
      );

  static getTextTheme() => TextTheme(
        headline5: _whiteHeadline5,
        headline6: _whiteHeadline6,
        headline2: _whiteHeadline2,
        subtitle2: _whiteSubtitle1,
        bodyText2: _whiteBodyText2,
        bodyText1: _whiteBodyText1,
        button: _whiteButton,
      );
}

extension ThemeTextExtension on TextTheme {
  TextStyle get royalBlueSubtitle1 => subtitle1.copyWith(
        color: AppColor.royalBlue,
        fontWeight: FontWeight.w600,
      );
}

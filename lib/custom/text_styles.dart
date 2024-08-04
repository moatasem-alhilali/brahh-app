import 'package:active_ecommerce_flutter/core/resources/assets_fonts.dart';
import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';
import 'package:flutter/material.dart';
import 'package:active_ecommerce_flutter/my_theme.dart';

class TextStyles {
  static TextStyle buildAppBarTexStyle() {
    return TextStyle(
      fontSize: 16,
      color: MyTheme.dark_font_grey,
      fontFamily: app_mobile_language.$ == 'en'
          ? "PublicSansSerif"
          : AssetsArFonts.medium,
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle largeTitleTexStyle() {
    return TextStyle(
      fontSize: 16,
      color: MyTheme.dark_font_grey,
      fontWeight: FontWeight.w700,
      fontFamily: app_mobile_language.$ == 'en'
          ? "PublicSansSerif"
          : AssetsArFonts.medium,
    );
  }

  static TextStyle smallTitleTexStyle() {
    return TextStyle(
        fontFamily: app_mobile_language.$ == 'en'
            ? "PublicSansSerif"
            : AssetsArFonts.medium,
        fontSize: 13,
        color: MyTheme.dark_font_grey,
        fontWeight: FontWeight.w700);
  }

  static TextStyle verySmallTitleTexStyle() {
    return TextStyle(
        fontSize: 10,
        color: MyTheme.dark_font_grey,
        fontFamily: app_mobile_language.$ == 'en'
            ? "PublicSansSerif"
            : AssetsArFonts.medium,
        fontWeight: FontWeight.normal);
  }

  static TextStyle largeBoldAccentTexStyle() {
    return TextStyle(
        fontFamily: app_mobile_language.$ == 'en'
            ? "PublicSansSerif"
            : AssetsArFonts.medium,
        fontSize: 16,
        color: MyTheme.accent_color,
        fontWeight: FontWeight.w700);
  }

  static TextStyle smallBoldAccentTexStyle() {
    return TextStyle(
        fontFamily: app_mobile_language.$ == 'en'
            ? "PublicSansSerif"
            : AssetsArFonts.medium,
        fontSize: 13,
        color: MyTheme.accent_color,
        fontWeight: FontWeight.w700);
  }
}

import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';
import 'package:active_ecommerce_flutter/my_theme.dart';
import 'package:flutter/material.dart';
import '/core/resources/assets_fonts.dart';

enum ToolAppThemeType { light, dark }

ThemeData lightTheme = ThemeData(
  primaryColor: MyTheme.white,
  scaffoldBackgroundColor: MyTheme.white,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  fontFamily:
      app_mobile_language.$ == 'en' ? "PublicSansSerif" : AssetsArFonts.medium,
  fontFamilyFallback: ['NotoSans'],

  brightness: Brightness.light,

  ///dividerTheme
  dividerColor: Colors.grey.withOpacity(0.5),
  dividerTheme: DividerThemeData(
    thickness: 1,
    color: Colors.grey.withOpacity(0.5),
  ),
  useMaterial3: true,

  ///AppBarTheme
  appBarTheme: AppBarTheme(
    foregroundColor: Colors.white,
    surfaceTintColor: Colors.white,
    shadowColor: Colors.white,
    elevation: 0,
    color: Colors.white,
    scrolledUnderElevation: 0,
    iconTheme: const IconThemeData(
      color: Color(0xff393939),
      size: 24,
    ),
    titleTextStyle: TextStyle(
      color: const Color(0xff393939),
      fontFamily: AssetsArFonts.regular,
      fontSize: 22,
    ),
  ),

  ///iconTheme
  iconTheme: const IconThemeData(
    color: Color(0xff393939),
    size: 35,
  ),

  ///bottom AppBar Theme
  bottomAppBarTheme: const BottomAppBarTheme(
    color: Color(0xff464c52),
    elevation: 2,
  ),

  ///tab Bar Theme
  tabBarTheme: TabBarTheme(
      labelStyle: TextStyle(
        color: Colors.black,
        fontFamily: AssetsArFonts.regular,
        fontWeight: FontWeight.bold,
      ),
      labelColor: Colors.black,
      dividerColor: Colors.black,
      indicatorColor: Colors.black,
      unselectedLabelStyle: TextStyle(
        color: Colors.grey,
        fontWeight: FontWeight.bold,
        fontFamily: AssetsArFonts.regular,
      ),
      unselectedLabelColor: Colors.grey,
      indicator: BoxDecoration(
        color: LightColors.primary,
        borderRadius: BorderRadius.circular(15),
      ),
      indicatorSize: TabBarIndicatorSize.tab
      // indicator: UnderlineTabIndicator(
      //   borderSide: BorderSide(
      //     color: Colors.black,
      //     width: 4.0,
      //   ),
      // ),
      ),

  ///Input Decoration Theme
  inputDecorationTheme: InputDecorationTheme(
    suffixIconColor: LightColors.lapel,
    errorStyle: const TextStyle(
      fontWeight: FontWeight.bold,
      fontFamily: AssetsArFonts.medium,
      color: Colors.red,
    ),
    prefixIconColor: LightColors.lapel,
    iconColor: LightColors.lapel,
    labelStyle: const TextStyle(
      color: LightColors.lapel,
    ),

    suffixStyle: const TextStyle(
      color: LightColors.lapel,
    ),
    prefixStyle: const TextStyle(
      color: LightColors.lapel,
    ),
    // fillColor: LightColors.lapel,
    hintStyle: const TextStyle(
      fontSize: 16,
      color: LightColors.lapel,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(
        color: LightColors.lapel.withOpacity(0.5),
        width: 2,
      ),
    ),

    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: const BorderSide(
        color: MyTheme.accent_color,
        width: 2,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: const BorderSide(
        color: Colors.red,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: const BorderSide(
        color: Colors.red,
      ),
    ),
  ),
  //text Button Theme
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      enableFeedback: false,
      elevation: 0,
      textStyle: const TextStyle(
        color: MyTheme.accent_color,
        fontSize: 16,
      ),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,
      enableFeedback: false,
      alignment: Alignment.center,
      backgroundColor: Colors.transparent,
      side: const BorderSide(
        color: MyTheme.accent_color,
        width: 1.8,
      ),
      padding: const EdgeInsets.all(4),
      textStyle: const TextStyle(
        fontSize: 16,
        color: Colors.white,
        fontWeight: FontWeight.w500,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  ),

  //elevated Button Theme
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      enableFeedback: false,
      alignment: Alignment.center,
      backgroundColor: LightColors.black,
      padding: const EdgeInsets.all(4),
      textStyle: const TextStyle(
        fontSize: 16,
        color: Colors.white,
        fontWeight: FontWeight.w500,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
  ),

  ///iconButtonTheme
  iconButtonTheme: IconButtonThemeData(
    style: IconButton.styleFrom(
      // backgroundColor: LightColors.black,
      enableFeedback: false,
      elevation: 0,
      iconSize: 35,
    ),
  ),

  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: MyTheme.accent_color,
    elevation: 0,
    iconSize: 35,
  ),

  //bottom Sheet Theme
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: Colors.white,
    modalBackgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(12),
        topRight: Radius.circular(12),
      ),
    ),
  ),
  //dialog Theme
  dialogTheme: DialogTheme(
    backgroundColor: const Color(0xff1F222A),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  ),

  //BottomNavigationBarThemeData
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedItemColor: Colors.black,
    backgroundColor: Colors.white.withOpacity(0.4),
    //
    unselectedItemColor: Colors.grey,
    selectedIconTheme: const IconThemeData(
      size: 35,
      color: Colors.black,
    ),
    unselectedIconTheme: const IconThemeData(
      size: 32,
      color: Colors.grey,
    ),
    selectedLabelStyle: const TextStyle(
      fontFamily: AssetsEnFonts.semiBold,
    ),
    type: BottomNavigationBarType.fixed,
    showSelectedLabels: true,
    showUnselectedLabels: true,
    elevation: 0,
  ),

  //textTheme
  textTheme: TextTheme(
    bodyLarge: TextStyle(
      fontFamily: app_mobile_language.$ == 'ar'
          ? AssetsArFonts.medium
          : 'PublicSansSerif',
      fontSize: 14,
    ),
    bodyMedium: TextStyle(
      // fontFamily: "PublicSansSerif",
      fontFamily: app_mobile_language.$ == 'ar'
          ? AssetsArFonts.medium
          : 'PublicSansSerif',
      fontSize: 12,
    ),
    //display
    displaySmall: TextStyle(
      color: LightColors.black,
      fontFamily: AssetsArFonts.regular,
      fontSize: 18,
    ),

    //headline
    headlineSmall: TextStyle(
      color: LightColors.black,
      fontFamily: AssetsArFonts.regular,
      fontSize: 16,
    ),

    //title
    titleSmall: TextStyle(
      color: LightColors.black,
      fontSize: 18,
      fontFamily: AssetsArFonts.regular,
    ),
    titleMedium: TextStyle(
      color: LightColors.black,
      fontSize: 18,
      fontFamily: AssetsArFonts.regular,
    ),
    titleLarge: TextStyle(
      color: LightColors.black,
      fontSize: 22,
      fontFamily: AssetsArFonts.regular,
    ),
  ),
);

class LightColors {
  static const Color primary = Color(0xfff3e008);
  static const Color secondary = Color(0xffEE9322);
  static const Color teal = Color(0xff219C90);
  static const Color red = Color(0xffD83F31);
  static const Color blue = Color(0xff3765de);
  static const Color main = Color(0xfff1f6f7);
  static const Color black = Color(0xff282828);
  static const Color lapel = Color(0xff4D515B);
}

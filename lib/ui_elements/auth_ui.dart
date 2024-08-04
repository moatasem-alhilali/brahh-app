import 'package:active_ecommerce_flutter/core/resources/assets_fonts.dart';
import 'package:active_ecommerce_flutter/custom/box_decorations.dart';
import 'package:active_ecommerce_flutter/custom/device_info.dart';
import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';
import 'package:active_ecommerce_flutter/my_theme.dart';
import 'package:flutter/material.dart';

class AuthScreen {
  static Widget buildScreen(
      BuildContext context, String headerText, Widget child,
      {bool withHeader = true}) {
    return Directionality(
      textDirection:
          app_language_rtl.$! ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Container(
              height: DeviceInfo(context).height! / 3,
              width: DeviceInfo(context).width,
              color: MyTheme.accent_color,
              alignment: Alignment.topRight,
              child: Image.asset(
                "assets/background_1.png",
              ),
            ),
            CustomScrollView(
              //controller: _mainScrollController,
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      if (!withHeader)
                        SizedBox(
                          width: 72,
                          height: 72,
                        ),
                      if (withHeader)
                        Padding(
                          padding: const EdgeInsets.only(top: 48.0),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 12),
                                width: 72,
                                height: 72,
                                decoration: BoxDecoration(
                                    color: MyTheme.white,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Image.asset(
                                    'assets/login_registration_form_logo.png'),
                              ),
                            ],
                            mainAxisAlignment: MainAxisAlignment.center,
                          ),
                        ),
                      if (!withHeader)
                        SizedBox(
                          height: 30,
                        ),
                      if (withHeader)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20.0, top: 10),
                          child: Text(
                            headerText,
                            style: TextStyle(
                              color: MyTheme.white,
                              fontSize: 18,
                              fontFamily: app_mobile_language.$ == 'en'
                                  ? "PublicSansSerif"
                                  : AssetsArFonts.medium,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          decoration:
                              BoxDecorations.buildBoxDecoration_1(radius: 16),
                          child: child,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

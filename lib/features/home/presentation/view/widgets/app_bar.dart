import 'package:active_ecommerce_flutter/core/my_extensions.dart';
import 'package:active_ecommerce_flutter/core/resources/assets_fonts.dart';
import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';
import 'package:active_ecommerce_flutter/screens/filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

AppBar buildAppBar(double statusBarHeight, BuildContext context) {
  return AppBar(
    automaticallyImplyLeading: false,
    // Don't show the leading button
    backgroundColor: Colors.white,
    centerTitle: false,
    elevation: 0,
    flexibleSpace: Padding(
      // padding:
      //     const EdgeInsets.only(top: 40.0, bottom: 22, left: 18, right: 18),
      padding:
          const EdgeInsets.only(top: 10.0, bottom: 10, left: 18, right: 18),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return Filter();
              },
            ),
          );
        },
        child: buildHomeSearchBox(context),
      ),
    ),
  );
}

buildHomeSearchBox(BuildContext context) {
  return Container(
    height: context.getHight(6),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25),
      color: Colors.white,
      border: Border.all(
        color: Colors.grey,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(.08),
          blurRadius: 20,
          spreadRadius: 0.0,
          offset: Offset(0.0, 10.0), // shadow direction: bottom right
        )
      ],
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            AppLocalizations.of(context)!.search_anything,
            style: TextStyle(
              fontSize: 13.0,
              color: Colors.grey,
              fontFamily: app_mobile_language.$ == 'en'
                  ? "PublicSansSerif"
                  : AssetsArFonts.medium,
            ),
          ),
          Image.asset(
            'assets/search.png',
            height: 16,
            //color: MyTheme.dark_grey,
            color: Colors.grey,
          )
        ],
      ),
    ),
  );
}

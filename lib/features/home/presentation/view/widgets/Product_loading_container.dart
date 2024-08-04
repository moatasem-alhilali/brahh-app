import 'package:active_ecommerce_flutter/presenter/home_presenter.dart';
import 'package:flutter/material.dart';
import 'package:active_ecommerce_flutter/core/resources/assets_fonts.dart';
import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Container buildProductLoadingContainer(HomePresenter homeData, context) {
  return Container(
    height: homeData.showAllLoadingContainer ? 36 : 0,
    width: double.infinity,
    color: Colors.white,
    child: Center(
      child: Text(
        homeData.totalAllProductData == homeData.allProductList.length
            ? AppLocalizations.of(context)!.no_more_products_ucf
            : AppLocalizations.of(context)!.loading_more_products_ucf,
        style: TextStyle(
          fontFamily: app_mobile_language.$ == 'en'
              ? "PublicSansSerif"
              : AssetsArFonts.medium,
        ),
      ),
    ),
  );
}

import 'package:active_ecommerce_flutter/helpers/shimmer_helper.dart';
import 'package:active_ecommerce_flutter/presenter/home_presenter.dart';
import 'package:active_ecommerce_flutter/ui_elements/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Widget buildHomeAllProducts(context, HomePresenter homeData) {
  if (homeData.isAllProductInitial && homeData.allProductList.length == 0) {
    return SingleChildScrollView(
        child: ShimmerHelper().buildProductGridShimmer(
            scontroller: homeData.allProductScrollController));
  } else if (homeData.allProductList.length > 0) {
    //snapshot.hasData

    return GridView.builder(
      // 2
      //addAutomaticKeepAlives: true,
      itemCount: homeData.allProductList.length,
      controller: homeData.allProductScrollController,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.618),
      padding: EdgeInsets.all(16.0),
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        // 3
        return ProductCard(
          id: homeData.allProductList[index].id,
          image: homeData.allProductList[index].thumbnail_image,
          name: homeData.allProductList[index].name,
          main_price: homeData.allProductList[index].main_price,
          stroked_price: homeData.allProductList[index].stroked_price,
          has_discount: homeData.allProductList[index].has_discount,
          discount: homeData.allProductList[index].discount,
        );
      },
    );
  } else if (homeData.totalAllProductData == 0) {
    return Center(
        child: Text(AppLocalizations.of(context)!.no_product_is_available));
  } else {
    return Container(); // should never be happening
  }
}

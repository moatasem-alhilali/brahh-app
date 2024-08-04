// import 'package:active_ecommerce_flutter/core/resources/assets_fonts.dart';
// import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';
// import 'package:active_ecommerce_flutter/helpers/shimmer_helper.dart';
// import 'package:active_ecommerce_flutter/my_theme.dart';
// import 'package:active_ecommerce_flutter/presenter/home_presenter.dart';
// import 'package:active_ecommerce_flutter/ui_elements/mini_product_card.dart';
// import 'package:active_ecommerce_flutter/ui_elements/product_card.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

//   Widget buildHomeFeatureProductHorizontalList(HomePresenter homeData,context) {
//     if (homeData.isFeaturedProductInitial == true &&
//         homeData.featuredProductList.length == 0) {
//       return Row(
//         children: [
//           Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: ShimmerHelper().buildBasicShimmer(
//                   height: 120.0,
//                   width: (MediaQuery.of(context).size.width - 64) / 3)),
//           Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: ShimmerHelper().buildBasicShimmer(
//                   height: 120.0,
//                   width: (MediaQuery.of(context).size.width - 64) / 3)),
//           Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: ShimmerHelper().buildBasicShimmer(
//                   height: 120.0,
//                   width: (MediaQuery.of(context).size.width - 160) / 3)),
//         ],
//       );
//     } else if (homeData.featuredProductList.length > 0) {
//       return SingleChildScrollView(
//         child: SizedBox(
//           height: 248,
//           child: NotificationListener<ScrollNotification>(
//             onNotification: (ScrollNotification scrollInfo) {
//               if (scrollInfo.metrics.pixels ==
//                   scrollInfo.metrics.maxScrollExtent) {
//                 homeData.fetchFeaturedProducts();
//               }
//               return true;
//             },
//             child: ListView.separated(
//               padding: const EdgeInsets.all(18.0),
//               separatorBuilder: (context, index) => SizedBox(
//                 width: 14,
//               ),
//               itemCount: homeData.totalFeaturedProductData! >
//                       homeData.featuredProductList.length
//                   ? homeData.featuredProductList.length + 1
//                   : homeData.featuredProductList.length,
//               scrollDirection: Axis.horizontal,
//               //itemExtent: 135,

//               physics: const BouncingScrollPhysics(
//                   parent: AlwaysScrollableScrollPhysics()),
//               itemBuilder: (context, index) {
//                 return (index == homeData.featuredProductList.length)
//                     ? SpinKitFadingFour(
//                         itemBuilder: (BuildContext context, int index) {
//                           return DecoratedBox(
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                             ),
//                           );
//                         },
//                       )
//                     : MiniProductCard(
//                         id: homeData.featuredProductList[index].id,
//                         image:
//                             homeData.featuredProductList[index].thumbnail_image,
//                         name: homeData.featuredProductList[index].name,
//                         main_price:
//                             homeData.featuredProductList[index].main_price,
//                         stroked_price:
//                             homeData.featuredProductList[index].stroked_price,
//                         has_discount:
//                             homeData.featuredProductList[index].has_discount,
//                         is_wholesale:
//                             homeData.featuredProductList[index].isWholesale,
//                         discount: homeData.featuredProductList[index].discount,
//                       );
//               },
//             ),
//           ),
//         ),
//       );
//     } else {
//       return Container(
//         height: 100,
//         child: Center(
//           child: Text(
//             AppLocalizations.of(context)!.no_related_product,
//             style: TextStyle(
//               color: MyTheme.font_grey,
//               fontFamily: app_mobile_language.$ == 'en'
//                   ? "PublicSansSerif"
//                   : AssetsArFonts.medium,
//             ),
//           ),
//         ),
//       );
//     }
//   }

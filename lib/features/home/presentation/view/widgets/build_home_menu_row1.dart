// import 'package:active_ecommerce_flutter/core/resources/assets_fonts.dart';
// import 'package:active_ecommerce_flutter/custom/box_decorations.dart';
// import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';
// import 'package:active_ecommerce_flutter/presenter/home_presenter.dart';
// import 'package:active_ecommerce_flutter/screens/flash_deal_list.dart';
// import 'package:active_ecommerce_flutter/screens/todays_deal_products.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// Widget buildHomeMenuRow1(BuildContext context, HomePresenter homeData) {
//   return Row(
//     children: [
//       if (homeData.isTodayDeal)
//         Flexible(
//           flex: 1,
//           fit: FlexFit.tight,
//           child: GestureDetector(
//             onTap: () {
//               Navigator.push(context, MaterialPageRoute(builder: (context) {
//                 return TodaysDealProducts();
//               }));
//             },
//             child: Container(
//               height: 90,
//               decoration: BoxDecorations.buildBoxDecoration_1(),
//               child: Column(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Container(
//                         height: 20,
//                         width: 20,
//                         child: Image.asset("assets/todays_deal.png")),
//                   ),
//                   Text(
//                     AppLocalizations.of(context)!.todays_deal_ucf,
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       color: Color.fromRGBO(132, 132, 132, 1),
//                       fontWeight: FontWeight.w300,
//                       fontFamily: app_mobile_language.$ == 'en'
//                           ? "PublicSansSerif"
//                           : AssetsArFonts.medium,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       if (homeData.isTodayDeal && homeData.isFlashDeal) SizedBox(width: 14.0),
//       if (homeData.isFlashDeal)
//         Flexible(
//           flex: 1,
//           fit: FlexFit.tight,
//           child: GestureDetector(
//             onTap: () {
//               Navigator.push(context, MaterialPageRoute(builder: (context) {
//                 return FlashDealList();
//               }));
//             },
//             child: Container(
//               height: 90,
//               decoration: BoxDecorations.buildBoxDecoration_1(),
//               child: Column(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Container(
//                         height: 20,
//                         width: 20,
//                         child: Image.asset("assets/flash_deal.png")),
//                   ),
//                   Text(
//                     AppLocalizations.of(context)!.flash_deal_ucf,
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       color: Color.fromRGBO(132, 132, 132, 1),
//                       fontWeight: FontWeight.w300,
//                       fontSize: 18,
//                       fontFamily: app_mobile_language.$ == 'en'
//                           ? "PublicSansSerif"
//                           : AssetsArFonts.medium,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         )
//     ],
//   );
// }

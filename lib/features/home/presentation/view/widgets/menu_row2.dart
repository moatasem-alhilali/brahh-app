// import 'package:active_ecommerce_flutter/core/my_extensions.dart';
// import 'package:active_ecommerce_flutter/core/resources/assets_fonts.dart';
// import 'package:active_ecommerce_flutter/features/category/presentation/view/pages/category_screen.dart';
// import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';
// import 'package:active_ecommerce_flutter/screens/top_sellers.dart';
// import 'package:flutter/material.dart';

// class HomeMenuRow2 extends StatelessWidget {
//   const HomeMenuRow2({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         if (vendor_system.$)
//           SizedBox(
//             width: 10,
//           ),
//         if (vendor_system.$) TopSellerSection(),
//       ],
//     );
//   }
// }

// class TopSellerSection extends StatelessWidget {
//   const TopSellerSection({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text(
//                 'الاكثر مبيعا',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.w700,
//                   fontFamily: app_mobile_language.$ == 'en'
//                       ? "PublicSansSerif"
//                       : AssetsArFonts.medium,
//                 ),
//               ),
//             ),
//             InkWell(
//               onTap: () {
//                 context.push(TopSellers());
//               },
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text(
//                   app_mobile_language.$ != 'en' ? 'الكل' : 'all',
//                   style: TextStyle(
//                     fontSize: 18,
//                     color: Color.fromRGBO(132, 132, 132, 1),
//                     fontWeight: FontWeight.w300,
//                     fontFamily: app_mobile_language.$ == 'en'
//                         ? "PublicSansSerif"
//                         : AssetsArFonts.medium,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         SizedBox(
//           height: context.getHight(20),
//           child: ListView.builder(
//             shrinkWrap: true,
//             scrollDirection: Axis.horizontal,
//             itemBuilder: (context, index) {
//               return Container(
//                 width: context.getWidth(50),
//                 margin: EdgeInsets.all(8),
//                 padding: EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                   color: Colors.grey,
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               );
//             },
//             itemCount: 20,
//           ),
//         ),
//       ],
//     );
//   }
// }

// class TopCategorySection extends StatelessWidget {
//   const TopCategorySection({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text(
//                 'الفئات',
//                 style: TextStyle(
//                   fontSize: 18,
//                   color: Color.fromRGBO(132, 132, 132, 1),
//                   fontWeight: FontWeight.w300,
//                   fontFamily: app_mobile_language.$ == 'en'
//                       ? "PublicSansSerif"
//                       : AssetsArFonts.medium,
//                 ),
//               ),
//             ),
//             InkWell(
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) {
//                       return CategoryScreen(
//                         isTopCategory: true,
//                         isBaseCategory: true,
//                         parentCategoryName: '',
//                         parentCategoryId: 0,
//                       );
//                     },
//                   ),
//                 );
//               },
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text(
//                   app_mobile_language.$ != 'en' ? 'الكل' : 'all',
//                   style: TextStyle(
//                     fontSize: 18,
//                     color: Color.fromRGBO(132, 132, 132, 1),
//                     fontWeight: FontWeight.w300,
//                     fontFamily: app_mobile_language.$ == 'en'
//                         ? "PublicSansSerif"
//                         : AssetsArFonts.medium,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         SizedBox(
//           height: context.getHight(20),
//           child: ListView.builder(
//             shrinkWrap: true,
//             scrollDirection: Axis.horizontal,
//             itemBuilder: (context, index) {
//               return Container(
//                 width: context.getWidth(50),
//                 margin: EdgeInsets.all(8),
//                 padding: EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                   color: Colors.grey,
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               );
//             },
//             itemCount: 20,
//           ),
//         ),
//       ],
//     );
//   }
// }

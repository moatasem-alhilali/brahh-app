import 'package:active_ecommerce_flutter/core/resources/assets_fonts.dart';
import 'package:active_ecommerce_flutter/custom/aiz_image.dart';
import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';
import 'package:active_ecommerce_flutter/helpers/shimmer_helper.dart';
import 'package:active_ecommerce_flutter/my_theme.dart';
import 'package:active_ecommerce_flutter/presenter/home_presenter.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Widget buildHomeCarouselSlider(context, HomePresenter homeData) {
  if (homeData.isCarouselInitial && homeData.carouselImageList.length == 0) {
    return Padding(
        padding: const EdgeInsets.only(left: 18, right: 18, top: 0, bottom: 20),
        child: ShimmerHelper().buildBasicShimmer(height: 120));
  } else if (homeData.carouselImageList.length > 0) {
    return CarouselSlider(
      options: CarouselOptions(
          aspectRatio: 338 / 140,
          viewportFraction: 1,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 5),
          autoPlayAnimationDuration: Duration(milliseconds: 1000),
          autoPlayCurve: Curves.easeInExpo,
          enlargeCenterPage: false,
          scrollDirection: Axis.horizontal,
          onPageChanged: (index, reason) {
            homeData.incrementCurrentSlider(index);
          }),
      items: homeData.carouselImageList.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Padding(
              padding: const EdgeInsets.only(
                left: 18,
                right: 18,
                top: 0,
                // bottom: 20,
              ),
              child: Stack(
                children: <Widget>[
                  Container(
                      //color: Colors.amber,
                      width: double.infinity,
                      height: 140,
                      //decoration: BoxDecorations.buildBoxDecoration_1(),
                      child: AIZImage.radiusImage(i, 6)),
                  // Align(
                  //   alignment: Alignment.bottomCenter,
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: homeData.carouselImageList.map((url) {
                  //       int index = homeData.carouselImageList.indexOf(url);
                  //       return Container(
                  //         width: 7.0,
                  //         height: 7.0,
                  //         margin: EdgeInsets.symmetric(
                  //             vertical: 10.0, horizontal: 4.0),
                  //         decoration: BoxDecoration(
                  //           shape: BoxShape.circle,
                  //           color: homeData.current_slider == index
                  //               ? MyTheme.white
                  //               : Color.fromRGBO(112, 112, 112, .3),
                  //         ),
                  //       );
                  //     }).toList(),
                  //   ),
                  // ),
                ],
              ),
            );
          },
        );
      }).toList(),
    );
  } else if (!homeData.isCarouselInitial &&
      homeData.carouselImageList.length == 0) {
    return Container(
      height: 100,
      child: Center(
        child: Text(
          AppLocalizations.of(context)!.no_carousel_image_found,
          style: TextStyle(
            color: MyTheme.font_grey,
            fontFamily: app_mobile_language.$ == 'en'
                ? "PublicSansSerif"
                : AssetsArFonts.medium,
          ),
        ),
      ),
    );
  } else {
    // should not be happening
    return Container(
      height: 100,
    );
  }
}

import 'package:active_ecommerce_flutter/core/resources/assets_fonts.dart';
import 'package:active_ecommerce_flutter/custom/aiz_image.dart';
import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';
import 'package:active_ecommerce_flutter/my_theme.dart';
import 'package:active_ecommerce_flutter/presenter/home_presenter.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Widget buildHomeBannerTwo(context, HomePresenter homeData) {
  if (homeData.isBannerTwoInitial && homeData.bannerTwoImageList.length == 0) {
    return SizedBox();
    // return Padding(
    //     padding:
    //         const EdgeInsets.only(left: 18.0, right: 18, top: 10, bottom: 10),
    //     child: ShimmerHelper().buildBasicShimmer(height: 120));
  } else if (homeData.bannerTwoImageList.length > 0) {
    return Padding(
      padding: app_language_rtl.$!
          ? const EdgeInsets.only(right: 9.0)
          : const EdgeInsets.only(left: 9.0),
      child: CarouselSlider(
        options: CarouselOptions(
            aspectRatio: 270 / 120,
            viewportFraction: 0.7,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 5),
            autoPlayAnimationDuration: Duration(milliseconds: 1000),
            autoPlayCurve: Curves.easeInExpo,
            enlargeCenterPage: false,
            scrollDirection: Axis.horizontal,
            onPageChanged: (index, reason) {
              // setState(() {
              //   homeData.current_slider = index;
              // });
            }),
        items: homeData.bannerTwoImageList.map((i) {
          return Builder(
            builder: (BuildContext context) {
              return Padding(
                padding: const EdgeInsets.only(
                    left: 9.0, right: 9, top: 20.0, bottom: 10),
                child: Container(
                    width: double.infinity, child: AIZImage.radiusImage(i, 6)),
              );
            },
          );
        }).toList(),
      ),
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
        )));
  } else {
    // should not be happening
    return Container(
        // height: 100,
        );
  }
}

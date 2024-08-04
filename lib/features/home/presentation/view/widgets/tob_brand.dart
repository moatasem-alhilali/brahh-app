import 'package:active_ecommerce_flutter/core/base_fade_image.dart';
import 'package:active_ecommerce_flutter/core/failure/request_state.dart';
import 'package:active_ecommerce_flutter/core/my_extensions.dart';
import 'package:active_ecommerce_flutter/core/resources/assets_fonts.dart';
import 'package:active_ecommerce_flutter/custom/box_decorations.dart';
import 'package:active_ecommerce_flutter/features/home/presentation/bloc/home_bloc.dart';
import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';
import 'package:active_ecommerce_flutter/my_theme.dart';
import 'package:active_ecommerce_flutter/screens/brand_products.dart';
import 'package:active_ecommerce_flutter/screens/filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class TopBrandSection extends StatelessWidget {
  const TopBrandSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          final allData = state.featuredBrands['data'];
          if (state.featuredBrands == {} || allData == null) {
            return SizedBox();
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'الماركات',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      fontFamily: app_mobile_language.$ == 'en'
                          ? "PublicSansSerif"
                          : AssetsArFonts.medium,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      context.push(Filter(selected_filter: "brands"));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        app_mobile_language.$ != 'en' ? 'الكل' : 'all',
                        style: TextStyle(
                          fontSize: 18,
                          color: Color.fromRGBO(132, 132, 132, 1),
                          fontWeight: FontWeight.w300,
                          fontFamily: app_mobile_language.$ == 'en'
                              ? "PublicSansSerif"
                              : AssetsArFonts.medium,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  // logger.d(state.featuredBrands);
                  switch (state.featuredBrandsState) {
                    case RState.defaults:
                      return _Loading();

                    case RState.loading:
                      return _Loading();

                    case RState.error:
                      return _Loading();
                    case RState.success:
                      return SizedBox(
                        height: context.getHight(20),
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            final data = allData[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: _Item(
                                id: data['id'],
                                image: data['logo'],
                                name: data['name'],
                              ),
                            );
                          },
                          itemCount: allData.length,
                        ),
                      );
                  }
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

class _Loading extends StatelessWidget {
  const _Loading();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.getHight(15),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Shimmer.fromColors(
              baseColor: Color.fromARGB(255, 206, 205, 205),
              highlightColor: MyTheme.shimmer_highlighted,
              child: Container(
                height: 50,
                width: context.getWidth(30),
                decoration: BoxDecorations.buildBoxDecoration_1(),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _Item extends StatelessWidget {
  int? id;
  String? image;
  String? name;

  _Item({Key? key, this.id, this.image, this.name}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(BrandProducts(
          id: id,
          brand_name: name,
        ));
      },
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.08),
                      blurRadius: 20,
                      spreadRadius: 0.0,
                      offset: Offset(
                        0.0,
                        10.0,
                      ), // shadow direction: bottom right
                    )
                  ],
                ),
                child: Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: BaseFadeImage(
                      // height: context.getHight(10),
                      width: context.getWidth(25),
                      image: image ?? "",
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              name ?? "",
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
              softWrap: true,
              style: TextStyle(
                fontSize: 12,
                color: MyTheme.font_grey,
                fontFamily: app_mobile_language.$ == 'en'
                    ? "PublicSansSerif"
                    : AssetsArFonts.medium,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

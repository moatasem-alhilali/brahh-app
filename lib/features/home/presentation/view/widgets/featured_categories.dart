import 'package:active_ecommerce_flutter/core/base_fade_image.dart';
import 'package:active_ecommerce_flutter/core/failure/request_state.dart';
import 'package:active_ecommerce_flutter/core/my_extensions.dart';
import 'package:active_ecommerce_flutter/core/resources/assets_fonts.dart';
import 'package:active_ecommerce_flutter/features/category/presentation/view/pages/category_products.dart';
import 'package:active_ecommerce_flutter/features/home/presentation/bloc/home_bloc.dart';
import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';
import 'package:active_ecommerce_flutter/helpers/shimmer_helper.dart';
import 'package:active_ecommerce_flutter/my_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeFeaturedCategories extends StatelessWidget {
  const HomeFeaturedCategories({super.key});
  // final HomePresenter homeData;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.featured_categories_ucf,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              fontFamily: app_mobile_language.$ == 'en'
                  ? "PublicSansSerif"
                  : AssetsArFonts.medium,
            ),
          ),
          SizedBox(
            height: context.getHight(20),
            child: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                switch (state.featuredCategoriesState) {
                  case RState.defaults:
                    return _Loading();
                  case RState.loading:
                    return _Loading();

                  case RState.error:
                    return _Loading();

                  case RState.success:
                    final allData = state.featuredCategories['data'];
                    if (allData == [] || state.featuredCategories == {}) {
                      return SizedBox();
                    }

                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: allData.length,
                      itemBuilder: (context, index) {
                        final data = allData[index];
                        return GestureDetector(
                          onTap: () {
                            context.push(
                              CategoryProducts(
                                categoryId: data['id'],
                                categoryName: data['name'],
                              ),
                            );
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
                                          image: data['banner'],
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  data['name'],
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
                      },
                    );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _Loading extends StatelessWidget {
  const _Loading();

  @override
  Widget build(BuildContext context) {
    return ShimmerHelper().buildHorizontalGridShimmerWithAxisCount(
      crossAxisSpacing: 14.0,
      mainAxisSpacing: 14.0,
      item_count: 10,
      mainAxisExtent: 170.0,
      // controller: homeData.featuredCategoryScrollController,
    );
  }
}

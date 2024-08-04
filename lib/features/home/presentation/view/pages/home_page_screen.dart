import 'package:active_ecommerce_flutter/core/failure/request_state.dart';
import 'package:active_ecommerce_flutter/core/my_extensions.dart';
import 'package:active_ecommerce_flutter/core/resources/assets_fonts.dart';
import 'package:active_ecommerce_flutter/custom/common_functions.dart';
import 'package:active_ecommerce_flutter/features/home/presentation/bloc/home_bloc.dart';
import 'package:active_ecommerce_flutter/features/home/presentation/view/widgets/banner_one.dart';
import 'package:active_ecommerce_flutter/features/home/presentation/view/widgets/banner_two.dart';
import 'package:active_ecommerce_flutter/features/home/presentation/view/widgets/carousel_slider.dart';
import 'package:active_ecommerce_flutter/features/home/presentation/view/widgets/featured_categories.dart';
import 'package:active_ecommerce_flutter/features/home/presentation/view/widgets/all_products2.dart';
import 'package:active_ecommerce_flutter/features/home/presentation/view/widgets/app_bar.dart';
import 'package:active_ecommerce_flutter/features/home/presentation/view/widgets/tob_brand.dart';
import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';
import 'package:active_ecommerce_flutter/my_theme.dart';
import 'package:active_ecommerce_flutter/presenter/home_presenter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePageScreen extends StatefulWidget {
  HomePageScreen({
    Key? key,
    this.title,
    this.showBackButton = false,
    goBack = true,
  }) : super(key: key);

  final String? title;
  bool showBackButton;
  late bool goBack;

  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  @override
  void initState() {
    change();
    super.initState();
  }

  change() {
    // homeData.onRefresh();
    // homeData.fetchAll();
    // homeData.mainScrollListener();
    // homeData.initPiratedAnimation(this);
    // Provider.of<HomePresenter>(context, listen: false).fetchAll();
    // context.read<HomeBloc>()..add(GetFeaturedCategoriesEvent());
    // context.read<HomeBloc>()..add(GetFeaturedBrandsEvent());
    //
  }

  @override
  void dispose() {
    // homeData.piratedLogoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return WillPopScope(
      onWillPop: () async {
        CommonFunctions(context).appExitDialog();
        return widget.goBack;
      },
      child: Directionality(
        textDirection:
            app_language_rtl.$! ? TextDirection.rtl : TextDirection.ltr,
        child: SafeArea(
          child: Scaffold(
            //key: homeData.scaffoldKey,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(context.getHight(10)),
              child: buildAppBar(statusBarHeight, context),
            ),
            //drawer: MainDrawer(),
            body: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                HomePresenter homeData = context.read<HomeBloc>().homeData;

                return Stack(
                  children: [
                    RefreshIndicator(
                      color: MyTheme.accent_color,
                      backgroundColor: Colors.white,
                      onRefresh: () async {
                        context
                            .read<HomeBloc>()
                            .add(FetchCarouselImagesEvent());
                      },
                      displacement: 0,
                      child: CustomScrollView(
                        controller: context.read<HomeBloc>().scroll,
                        physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        slivers: <Widget>[
                          SliverList(
                            delegate: SliverChildListDelegate(
                              [
                                buildHomeCarouselSlider(context, homeData),
                                // Padding(
                                //   padding: const EdgeInsets.fromLTRB(
                                //     18.0,
                                //     0.0,
                                //     18.0,
                                //     0.0,
                                //   ),
                                //   child: buildHomeMenuRow1(context, homeData),
                                // ),
                                // Padding(
                                //   padding: const EdgeInsets.fromLTRB(
                                //     18.0,
                                //     0.0,
                                //     18.0,
                                //     0.0,
                                //   ),
                                //   child: HomeMenuRow2(),
                                // ),
                              ],
                            ),
                          ),
                          // SliverToBoxAdapter(
                          //   child: TopBrandSection(),
                          // ),

                          SliverToBoxAdapter(
                            child: HomeFeaturedCategories(),
                          ),

                          SliverToBoxAdapter(
                            child: buildHomeBannerOne(context, homeData),
                          ),

                          //منتجات ذات صله
                          // SliverList(
                          //   delegate: SliverChildListDelegate([
                          //     Container(
                          //       color: MyTheme.accent_color,
                          //       child: Stack(
                          //         children: [
                          //           Container(
                          //             height: 180,
                          //             width: double.infinity,
                          //             child: Row(
                          //               mainAxisAlignment:
                          //                   MainAxisAlignment.end,
                          //               children: [
                          //                 Image.asset(
                          //                     "assets/background_1.png")
                          //               ],
                          //             ),
                          //           ),
                          //           Column(
                          //             crossAxisAlignment:
                          //                 CrossAxisAlignment.start,
                          //             children: [
                          //               Padding(
                          //                 padding: const EdgeInsets.only(
                          //                     top: 10.0,
                          //                     right: 18.0,
                          //                     left: 18.0),
                          //                 child: Text(
                          //                   AppLocalizations.of(context)!
                          //                       .featured_products_ucf,
                          //                   style: TextStyle(
                          //                     color: Colors.white,
                          //                     fontSize: 18,
                          //                     fontWeight: FontWeight.w700,
                          //                     fontFamily:
                          //                         app_mobile_language.$ ==
                          //                                 'en'
                          //                             ? "PublicSansSerif"
                          //                             : AssetsArFonts.medium,
                          //                   ),
                          //                 ),
                          //               ),
                          //               buildHomeFeatureProductHorizontalList(
                          //                   homeData, context)
                          //             ],
                          //           ),
                          //         ],
                          //       ),
                          //     ),
                          //   ]),
                          // ),
                          SliverList(
                            delegate: SliverChildListDelegate(
                              [
                                buildHomeBannerTwo(context, homeData),
                              ],
                            ),
                          ),
                          // SliverList(
                          //   delegate: SliverChildListDelegate(
                          //     [
                          //       Padding(
                          //         padding: const EdgeInsets.fromLTRB(
                          //           18.0,
                          //           18.0,
                          //           20.0,
                          //           0.0,
                          //         ),
                          //         child: Column(
                          //           crossAxisAlignment:
                          //               CrossAxisAlignment.start,
                          //           children: [
                          //             Text(
                          //               AppLocalizations.of(context)!
                          //                   .all_products_ucf,
                          //               style: TextStyle(
                          //                 fontSize: 18,
                          //                 fontWeight: FontWeight.w700,
                          //                 fontFamily:
                          //                     app_mobile_language.$ == 'en'
                          //                         ? "PublicSansSerif"
                          //                         : AssetsArFonts.medium,
                          //               ),
                          //             ),
                          //           ],
                          //         ),
                          //       ),
                          //       SingleChildScrollView(
                          //         child: Column(
                          //           children: [
                          //             buildHomeAllProducts2(context, homeData),
                          //             BlocBuilder<HomeBloc, HomeState>(
                          //               builder: (context, state) {
                          //                 switch (state.allProductsMoreState) {
                          //                   case RState.defaults:
                          //                     return SizedBox();
                          //                   case RState.loading:
                          //                     return CircularProgressIndicator();

                          //                   case RState.error:
                          //                     return SizedBox();

                          //                   case RState.success:
                          //                     return SizedBox();
                          //                 }
                          //               },
                          //             ),
                          //           ],
                          //         ),
                          //       ),
                          //       SizedBox(height: 80)
                          //     ],
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

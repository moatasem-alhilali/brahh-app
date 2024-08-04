import 'package:active_ecommerce_flutter/core/base_fade_image.dart';
import 'package:active_ecommerce_flutter/core/my_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:active_ecommerce_flutter/core/resources/assets_fonts.dart';
import 'package:active_ecommerce_flutter/custom/box_decorations.dart';
import 'package:active_ecommerce_flutter/custom/btn.dart';
import 'package:active_ecommerce_flutter/custom/device_info.dart';
import 'package:active_ecommerce_flutter/data_model/category_response.dart';
import 'package:active_ecommerce_flutter/features/category/presentation/view/pages/category_products.dart';
import 'package:active_ecommerce_flutter/helpers/shimmer_helper.dart';
import 'package:active_ecommerce_flutter/presenter/bottom_appbar_index.dart';
import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';
import 'package:active_ecommerce_flutter/my_theme.dart';
import 'package:active_ecommerce_flutter/core/failure/request_state.dart';
import 'package:active_ecommerce_flutter/features/category/presentation/bloc/category_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryScreen extends StatefulWidget {
  final int parentCategoryId;
  final String parentCategoryName;
  final bool isBaseCategory;
  final bool isTopCategory;
  final BottomAppBarIndex? bottomAppBarIndex;

  CategoryScreen({
    Key? key,
    required this.parentCategoryId,
    required this.parentCategoryName,
    this.isBaseCategory = false,
    this.isTopCategory = false,
    this.bottomAppBarIndex,
  }) : super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection:
          app_language_rtl.$! ? TextDirection.rtl : TextDirection.ltr,
      child: Stack(
        children: [
          Container(
            height: DeviceInfo(context).height! / 8,
            width: DeviceInfo(context).width,
            color: MyTheme.accent_color,
            alignment: Alignment.topRight,
            child: Image.asset(
              "assets/background_1.png",
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: PreferredSize(
              child: buildAppBar(context),
              preferredSize: Size(
                DeviceInfo(context).width!,
                50,
              ),
            ),
            body: RefreshIndicator(
              onRefresh: () async {
                BlocProvider.of<CategoryBloc>(context).add(GetTopCategories());
              },
              child: CustomScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                slivers: [
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        BodyCategory(),
                        // buildCategoryList(),
                        Container(
                          height: widget.isBaseCategory ? 60 : 90,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Builder(
              builder: (context) {
                if (!widget.isBaseCategory || !widget.isTopCategory) {
                  return buildBottomContainer();
                }
                return SizedBox();
              },
            ),
          )
        ],
      ),
    );
  }

  Widget buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: SizedBox(),
      title: Text(
        getAppBarTitle(),
        style: TextStyle(
          fontSize: 16,
          color: MyTheme.white,
          fontWeight: FontWeight.bold,
          fontFamily: app_mobile_language.$ == 'en'
              ? "PublicSansSerif"
              : AssetsArFonts.medium,
        ),
      ),
      elevation: 0.0,
      titleSpacing: 0,
    );
  }

  String getAppBarTitle() {
    String name = widget.parentCategoryName == ""
        ? (widget.isTopCategory
            ? AppLocalizations.of(context)!.top_categories_ucf
            : AppLocalizations.of(context)!.categories_ucf)
        : widget.parentCategoryName;

    return name;
  }

  Widget buildBottomContainer() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      height: widget.isBaseCategory ? 0 : 80,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Container(
                width: (MediaQuery.of(context).size.width - 32),
                height: 40,
                child: Btn.basic(
                  minWidth: MediaQuery.of(context).size.width,
                  color: MyTheme.accent_color,
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(8.0))),
                  child: Text(
                    AppLocalizations.of(context)!.all_products_of_ucf +
                        " " +
                        widget.parentCategoryName,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      fontFamily: app_mobile_language.$ == 'en'
                          ? "PublicSansSerif"
                          : AssetsArFonts.medium,
                    ),
                  ),
                  onPressed: () {
                    context.push(CategoryProducts(
                      categoryId: widget.parentCategoryId,
                      categoryName: widget.parentCategoryName,
                    ));
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BodyCategory extends StatelessWidget {
  const BodyCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        switch (state.topCategoriesState) {
          case RState.defaults:
            return SingleChildScrollView(child: BuildShimmer());

          case RState.loading:
            return SingleChildScrollView(child: BuildShimmer());

          case RState.error:
            return SingleChildScrollView(child: BuildShimmer());

          case RState.success:
            // logger.d(state.topCategoriesState);
            var bloc = BlocProvider.of<CategoryBloc>(context);
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 14,
                crossAxisSpacing: 14,
                childAspectRatio: 0.7,
                crossAxisCount: 3,
              ),
              itemCount: bloc.topCategories.categories!.length,
              padding: EdgeInsets.only(left: 18, right: 18, bottom: 30),
              scrollDirection: Axis.vertical,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return _BuildCategoryItemCard(
                    categoryResponse: bloc.topCategories, index: index);
              },
            );
        }
      },
    );
  }
}

class BuildShimmer extends StatelessWidget {
  const BuildShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 14,
        crossAxisSpacing: 14,
        childAspectRatio: 1,
        crossAxisCount: 3,
      ),
      itemCount: 18,
      padding: EdgeInsets.only(left: 18, right: 18, bottom: 30),
      scrollDirection: Axis.vertical,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecorations.buildBoxDecoration_1(),
          child: ShimmerHelper().buildBasicShimmer(),
        );
      },
    );
  }
}

class _BuildCategoryItemCard extends StatelessWidget {
  const _BuildCategoryItemCard(
      {required this.categoryResponse, required this.index});
  final int index;
  final CategoryResponse categoryResponse;
  @override
  Widget build(BuildContext context) {
    var itemWidth = ((DeviceInfo(context).width! - 36) / 3);

    return Column(
      children: [
        Container(
          decoration: BoxDecorations.buildBoxDecoration_1(),
          child: InkWell(
            onTap: () {
              context.push(
                CategoryProducts(
                  categoryId: categoryResponse.categories![index].id,
                  categoryName: categoryResponse.categories![index].name,
                ),
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  constraints: BoxConstraints(maxHeight: itemWidth - 28),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(6),
                        topLeft: Radius.circular(6)),
                    child: BaseFadeImage(
                      // placeholder: 'assets/placeholder.png',
                      image: categoryResponse.categories![index].banner ?? "",
                      fit: BoxFit.cover,
                      height: itemWidth,
                      width: DeviceInfo(context).width,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 10),
        Text(
          categoryResponse.categories![index].name ?? "",
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          style: TextStyle(
            color: MyTheme.font_grey,
            fontSize: 14,
            height: 1.6,
            fontWeight: FontWeight.w600,
            fontFamily: app_mobile_language.$ == 'en'
                ? "PublicSansSerif"
                : AssetsArFonts.medium,
          ),
        )
      ],
    );
  }
}

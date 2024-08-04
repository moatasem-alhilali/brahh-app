// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

@immutable
class HomeState {
  // All products
  final RState allProductsState;
  final RState allProductsMoreState;
  final Map<String, dynamic> allProducts;

  //
  final RState fetchCarouselImagesState;
  final RState fetchBannerOneImagesState;
  final RState fetchBannerTwoImagesState;
  final RState fetchTodayDealDataState;
  final RState fetchFlashDealDataState;

  // Featured products
  final RState featuredProductsState;
  final Map<String, dynamic> featuredProducts;

  // Featured Categories
  final RState featuredCategoriesState;
  final Map<String, dynamic> featuredCategories;

  // Featured Brands
  final RState featuredBrandsState;
  final Map<String, dynamic> featuredBrands;
    final RState downloadState;


  HomeState({
    // All products
    this.allProductsState = RState.defaults,
    this.allProductsMoreState = RState.defaults,
    this.allProducts = const {},
    //
    this.fetchBannerOneImagesState = RState.defaults,
    this.downloadState = RState.defaults,
    this.fetchBannerTwoImagesState = RState.defaults,
    this.fetchCarouselImagesState = RState.defaults,
    this.fetchFlashDealDataState = RState.defaults,
    this.fetchTodayDealDataState = RState.defaults,

    // Featured products
    this.featuredProductsState = RState.defaults,
    this.featuredProducts = const {},

    // Featured Categories
    this.featuredCategoriesState = RState.defaults,
    this.featuredCategories = const {},
    // Featured Brands
    this.featuredBrandsState = RState.defaults,
    this.featuredBrands = const {},
  });

  HomeState copyWith({
    RState? allProductsState,
    RState? allProductsMoreState,
    Map<String, dynamic>? allProducts,
    RState? fetchCarouselImagesState,
    RState? fetchBannerOneImagesState,
    RState? fetchBannerTwoImagesState,
    RState? fetchTodayDealDataState,
    RState? fetchFlashDealDataState,
    RState? featuredProductsState,
    Map<String, dynamic>? featuredProducts,
    RState? featuredCategoriesState,
    Map<String, dynamic>? featuredCategories,
    RState? featuredBrandsState,
    Map<String, dynamic>? featuredBrands,
    RState? downloadState,
  }) {
    return HomeState(
      allProductsState: allProductsState ?? this.allProductsState,
      allProductsMoreState: allProductsMoreState ?? this.allProductsMoreState,
      allProducts: allProducts ?? this.allProducts,
      fetchCarouselImagesState: fetchCarouselImagesState ?? this.fetchCarouselImagesState,
      fetchBannerOneImagesState: fetchBannerOneImagesState ?? this.fetchBannerOneImagesState,
      fetchBannerTwoImagesState: fetchBannerTwoImagesState ?? this.fetchBannerTwoImagesState,
      fetchTodayDealDataState: fetchTodayDealDataState ?? this.fetchTodayDealDataState,
      fetchFlashDealDataState: fetchFlashDealDataState ?? this.fetchFlashDealDataState,
      featuredProductsState: featuredProductsState ?? this.featuredProductsState,
      featuredProducts: featuredProducts ?? this.featuredProducts,
      featuredCategoriesState: featuredCategoriesState ?? this.featuredCategoriesState,
      featuredCategories: featuredCategories ?? this.featuredCategories,
      featuredBrandsState: featuredBrandsState ?? this.featuredBrandsState,
      featuredBrands: featuredBrands ?? this.featuredBrands,
      downloadState: downloadState ?? this.downloadState,
    );
  }
}

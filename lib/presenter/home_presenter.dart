import 'dart:async';

import 'package:active_ecommerce_flutter/main.dart';
import 'package:active_ecommerce_flutter/repositories/category_repository.dart';
import 'package:active_ecommerce_flutter/repositories/flash_deal_repository.dart';
import 'package:active_ecommerce_flutter/repositories/product_repository.dart';
import 'package:active_ecommerce_flutter/repositories/sliders_repository.dart';
import 'package:flutter/material.dart';

class HomePresenter {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  int currentSlider = 0;
  ScrollController? allProductScrollController;
  ScrollController? featuredCategoryScrollController;
  ScrollController mainScrollController = ScrollController();

  // late AnimationController piratedLogoController;
  // late Animation piratedLogoAnimation;

  var carouselImageList = [];
  var bannerOneImageList = [];
  var bannerTwoImageList = [];
  var featuredCategoryList = [];

  bool isCategoryInitial = true;

  bool isCarouselInitial = true;
  bool isBannerOneInitial = true;
  bool isBannerTwoInitial = true;

  // var featuredProductList = [];
  bool isFeaturedProductInitial = true;
  int? totalFeaturedProductData = 0;
  int featuredProductPage = 1;
  bool showFeaturedLoadingContainer = false;

  bool isTodayDeal = false;
  bool isFlashDeal = false;

  var allProductList = [];
  bool isAllProductInitial = true;
  int? totalAllProductData = 0;
  int allProductPage = 1;
  bool showAllLoadingContainer = false;
  int cartCount = 0;

  fetchAll() {
    try {
      fetchCarouselImages();
      fetchBannerOneImages();
      fetchBannerTwoImages();

      //
      // fetchFeaturedCategories();
      // fetchFeaturedProducts();
      fetchAllProducts();

      //
      fetchTodayDealData();
      fetchFlashDealData();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> fetchTodayDealData() async {
    try {
      var deal = await ProductRepository().getTodaysDealProducts();
      print(deal.products!.length);
      if (deal.success! && deal.products!.isNotEmpty) {
        isTodayDeal = true;
        // notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> fetchFlashDealData() async {
    try {
      var deal = await FlashDealRepository().getFlashDeals();

      if (deal.success! && deal.flashDeals!.isNotEmpty) {
        isFlashDeal = true;
        // notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> fetchCarouselImages() async {
    try {
      var carouselResponse = await SlidersRepository().getSliders();
      carouselResponse.sliders!.forEach((slider) {
        carouselImageList.add(slider.photo);
      });
      isCarouselInitial = false;
      // notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> fetchBannerOneImages() async {
    try {
      var bannerOneResponse = await SlidersRepository().getBannerOneImages();
      bannerOneResponse.sliders!.forEach((slider) {
        bannerOneImageList.add(slider.photo);
      });
      isBannerOneInitial = false;
      // notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> fetchBannerTwoImages() async {
    try {
      var bannerTwoResponse = await SlidersRepository().getBannerTwoImages();
      bannerTwoResponse.sliders!.forEach((slider) {
        bannerTwoImageList.add(slider.photo);
      });
      isBannerTwoInitial = false;
      // notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> fetchFeaturedCategories() async {
    try {
      var categoryResponse = await CategoryRepository().getFeaturedCategories();
      featuredCategoryList = [];
      featuredCategoryList.addAll(categoryResponse.categories!);
      isCategoryInitial = false;
      // notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  // fetchFeaturedProducts() async {
  //   var productResponse = await ProductRepository().getFeaturedProducts(
  //     page: featuredProductPage,
  //   );
  //   featuredProductPage++;
  //   featuredProductList.addAll(productResponse.products!);
  //   isFeaturedProductInitial = false;
  //   totalFeaturedProductData = productResponse.meta!.total;
  //   showFeaturedLoadingContainer = false;
  //   // notifyListeners();
  // }

  Future<void> fetchAllProducts() async {
    var productResponse =
        await ProductRepository().getFilteredProducts(page: allProductPage);
    if (productResponse.products!.isEmpty) {
      return;
    }

    allProductList.addAll(productResponse.products!);
    isAllProductInitial = false;
    totalAllProductData = productResponse.meta!.total;
    showAllLoadingContainer = false;
    // notifyListeners();
  }

  reset() {
    carouselImageList = [];
    bannerOneImageList = [];
    bannerTwoImageList = [];
    featuredCategoryList = [];

    isCarouselInitial = true;
    isBannerOneInitial = true;
    isBannerTwoInitial = true;
    isCategoryInitial = true;
    cartCount = 0;

    resetFeaturedProductList();
    resetAllProductList();
  }

  Future<void> onRefresh() async {
    reset();
    fetchAll();
    // notifyListeners();
  }

  resetFeaturedProductList() {
    // featuredProductList.clear();
    isFeaturedProductInitial = true;
    totalFeaturedProductData = 0;
    featuredProductPage = 1;
    showFeaturedLoadingContainer = false;
    // notifyListeners();
  }

  resetAllProductList() {
    allProductList.clear();
    isAllProductInitial = true;
    totalAllProductData = 0;
    allProductPage = 1;
    showAllLoadingContainer = false;
    // notifyListeners();
  }

  Future<void> mainScrollListener() async {
    allProductPage++;

    showAllLoadingContainer = true;
    await fetchAllProducts();
    logger.d('mainScrollListener');
  }

  initPiratedAnimation(vnc) {
    // piratedLogoController =
    //     AnimationController(vsync: vnc, duration: Duration(milliseconds: 2000));
    // piratedLogoAnimation = Tween(begin: 40.0, end: 60.0).animate(
    //     CurvedAnimation(
    //         curve: Curves.bounceOut, parent: piratedLogoController));

    // piratedLogoController.addStatusListener((AnimationStatus status) {
    //   if (status == AnimationStatus.completed) {
    //     piratedLogoController.repeat();
    //   }
    // });

    // piratedLogoController.forward();
  }

  incrementCurrentSlider(index) {
    currentSlider = index;
    // notifyListeners();
  }

  @override
  void dispose() {
    // piratedLogoController.dispose();
    // notifyListeners();
    // super.dispose();
  }
}

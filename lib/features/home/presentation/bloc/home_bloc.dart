import 'dart:async';
import 'package:active_ecommerce_flutter/core/failure/request_state.dart';
import 'package:active_ecommerce_flutter/core/services/update_serves.dart';
import 'package:active_ecommerce_flutter/features/home/data/home_repo_imp.dart';
import 'package:active_ecommerce_flutter/main.dart';
import 'package:active_ecommerce_flutter/presenter/home_presenter.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeRepositoryImp homeRepositoryImp;
  ScrollController scroll = ScrollController();
  int page = 1;
  HomePresenter homeData = HomePresenter();

  HomeBloc({
    required this.homeRepositoryImp,
  }) : super(HomeState()) {
    //
    // homeData.onRefresh();
    // homeData.fetchAll();
    // homeData.mainScrollListener();

    //
    InUpdateServes.checkUpdate();
    //
    scroll.addListener(() {
      if (scroll.position.pixels == scroll.position.maxScrollExtent) {
        add(GetAllProductsMoreEvent());
      }
    });

    on<SetStateHomeEvent>((event, emit) => emit(state.copyWith()));
    on<DownloadImageEvent>(download);
    on<GetAllProductsEvent>(fetchAllProducts);
    on<GetAllProductsMoreEvent>(mainScrollListener);
    // on<GetFeaturedProductsEvent>(fetchFeaturedProducts);
    //
    on<GetFeaturedCategoriesEvent>(fetchFeaturedCategories);
    on<GetFeaturedBrandsEvent>(fetchFeaturedBrand);
    //
    on<FetchCarouselImagesEvent>(fetchCarouselImages);
    on<FetchBannerOneImagesEvent>(fetchBannerOneImages);
    on<FetchBannerTwoImagesEvent>(fetchBannerTwoImages);
    on<FetchTodayDealDataEvent>(fetchTodayDealData);
    on<FetchFlashDealDataEvent>(fetchFlashDealData);
  }
  getAll() {
    add(GetFeaturedCategoriesEvent());
    add(GetFeaturedBrandsEvent());
    add(FetchCarouselImagesEvent());
    add(FetchBannerOneImagesEvent());
    add(FetchBannerTwoImagesEvent());
    add(FetchTodayDealDataEvent());
    add(FetchFlashDealDataEvent());
  }

  FutureOr<void> fetchAllProducts(event, emit) async {
    emit(state.copyWith(allProductsState: RState.loading));
    try {
      await homeData.fetchAllProducts();
      emit(state.copyWith(allProductsState: RState.success));
    } catch (e) {
      emit(state.copyWith(allProductsState: RState.error));
    }
  }

  FutureOr<void> mainScrollListener(event, emit) async {
    emit(state.copyWith(allProductsMoreState: RState.loading));
    try {
      await homeData.mainScrollListener();
      emit(state.copyWith(allProductsMoreState: RState.success));
      emit(state.copyWith(allProductsMoreState: RState.defaults));
    } catch (e) {
      emit(state.copyWith(allProductsMoreState: RState.error));
    }
  }

  FutureOr<void> fetchCarouselImages(event, emit) async {
    emit(state.copyWith(fetchCarouselImagesState: RState.loading));
    try {
      await homeData.fetchCarouselImages();
      emit(state.copyWith(fetchCarouselImagesState: RState.success));
      emit(state.copyWith(fetchCarouselImagesState: RState.defaults));
    } catch (e) {
      emit(state.copyWith(fetchCarouselImagesState: RState.error));
    }
  }

  FutureOr<void> fetchBannerOneImages(event, emit) async {
    emit(state.copyWith(fetchBannerOneImagesState: RState.loading));
    try {
      await homeData.fetchBannerOneImages();
      emit(state.copyWith(fetchBannerOneImagesState: RState.success));
      emit(state.copyWith(fetchBannerOneImagesState: RState.defaults));
    } catch (e) {
      emit(state.copyWith(fetchBannerOneImagesState: RState.error));
    }
  }

  FutureOr<void> fetchBannerTwoImages(event, emit) async {
    emit(state.copyWith(fetchBannerTwoImagesState: RState.loading));
    try {
      await homeData.fetchBannerTwoImages();
      emit(state.copyWith(fetchBannerTwoImagesState: RState.success));
      emit(state.copyWith(fetchBannerTwoImagesState: RState.defaults));
    } catch (e) {
      emit(state.copyWith(fetchBannerTwoImagesState: RState.error));
    }
  }

  FutureOr<void> fetchTodayDealData(event, emit) async {
    emit(state.copyWith(fetchTodayDealDataState: RState.loading));
    try {
      await homeData.fetchTodayDealData();
      emit(state.copyWith(fetchTodayDealDataState: RState.success));
      emit(state.copyWith(fetchTodayDealDataState: RState.defaults));
    } catch (e) {
      emit(state.copyWith(fetchTodayDealDataState: RState.error));
    }
  }

  FutureOr<void> fetchFlashDealData(event, emit) async {
    emit(state.copyWith(fetchFlashDealDataState: RState.loading));
    try {
      await homeData.fetchFlashDealData();
      emit(state.copyWith(fetchFlashDealDataState: RState.success));
      emit(state.copyWith(fetchFlashDealDataState: RState.defaults));
    } catch (e) {
      emit(state.copyWith(fetchFlashDealDataState: RState.error));
    }
  }
  // FutureOr<void> fetchFeaturedProducts(event, emit) async {
  //   page = page + 1;
  //   emit(state.copyWith(featuredProductsState: RState.loading));
  //   final dataProduct = await homeRepositoryImp.fetchFeaturedProducts(
  //     page: page,
  //   );
  //   dataProduct.fold(
  //     (l) {
  //       emit(state.copyWith(featuredProductsState: RState.error));
  //     },
  //     (r) {
  //       emit(
  //         state.copyWith(
  //           featuredProductsState: RState.success,
  //           // featuredProducts: [
  //           //   ...state.products,
  //           //   // ...r,
  //           // ],
  //           featuredProducts: r,
  //         ),
  //       );
  //     },
  //   );
  // }

  FutureOr<void> fetchFeaturedCategories(event, emit) async {
    emit(state.copyWith(featuredCategoriesState: RState.loading));
    final result = await homeRepositoryImp.fetchFeaturedCategories();
    result.fold(
      (l) {
        emit(state.copyWith(featuredCategoriesState: RState.error));
      },
      (r) {
        emit(
          state.copyWith(
            featuredCategoriesState: RState.success,
            featuredCategories: r,
          ),
        );
      },
    );
  }

  FutureOr<void> fetchFeaturedBrand(event, emit) async {
    emit(state.copyWith(featuredBrandsState: RState.loading));
    final result = await homeRepositoryImp.fetchFeaturedBrand();
    result.fold(
      (l) {
        emit(state.copyWith(featuredBrandsState: RState.error));
      },
      (r) {
        emit(
          state.copyWith(
            featuredBrandsState: RState.success,
            featuredBrands: r,
          ),
        );
      },
    );
  }

  FutureOr<void> download(event, emit) async {
    emit(state.copyWith(downloadState: RState.loading));
    try {
      var response = await Dio()
          .get(event.url, options: Options(responseType: ResponseType.bytes));
      await ImageGallerySaver.saveImage(
        Uint8List.fromList(response.data),
        quality: 60,
        name: DateTime.now().microsecondsSinceEpoch.toString(),
      );
      
      emit(state.copyWith(downloadState: RState.success));
    } catch (e) {
      emit(state.copyWith(downloadState: RState.error));

      logger.e(e);
    }
    emit(state.copyWith(downloadState: RState.defaults));
  }

  @override
  close() async {
    // homeData.piratedLogoController.dispose();
    super.close();
  }
}

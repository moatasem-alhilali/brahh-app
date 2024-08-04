import 'package:active_ecommerce_flutter/core/helper/dio/dio_helper.dart';
import 'package:active_ecommerce_flutter/main.dart';
import 'package:dio/dio.dart';

import '/core/failure/failure.dart';
import 'package:dartz/dartz.dart';

import 'home_repo.dart';

class HomeRepositoryImp implements HomeRepository {
  @override
  Future<Either<Failure, Map<String, dynamic>>> fetchAllProducts(
    Map<String, dynamic> data,
  ) async {
    try {
      String url = ("/products/search" +
          "?page=${data['page']}&name=${data['name']}&sort_key=${data['sort_key']}&brands=${data['brands']}&categories=${data['categories']}&min=${data['min']}&max=${data['max']}");
      final result = await DioHelper.get(
        url: url,
      );

      logger.i(result.data);
      return right(result.data);
    } catch (e) {
      logger.e("Get Brands error ${e.toString()}");
      if (e is DioException) return left(ServerFailure.fromServerFailure(e));

      return left(ServerFailure("unable to process"));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> fetchFeaturedProducts({
    int page = 1,
  }) async {
    try {
      String url = "/products/featured?page=$page";
      final result = await DioHelper.get(
        url: url,
      );

      return right(result.data);
    } catch (e) {
      logger.e("Get fetch Featured Products error ${e.toString()}");
      if (e is DioException) return left(ServerFailure.fromServerFailure(e));

      return left(ServerFailure("unable to process"));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> fetchFeaturedCategories({
    int page = 1,
  }) async {
    try {
      String url = ("/categories/featured");

      final result = await DioHelper.get(
        url: url,
      );
      // logger.d(result.data);
      return right(result.data);
    } catch (e) {
      logger.e("Get fetch Featured Categories error ${e.toString()}");
      if (e is DioException) return left(ServerFailure.fromServerFailure(e));

      return left(ServerFailure("unable to process"));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> fetchCarouselImages() async {
    try {
      String url = ("/sliders");

      final result = await DioHelper.get(
        url: url,
      );
      // logger.d(result.data);
      return right(result.data);
    } catch (e) {
      logger.e("Get fetch Featured Categories error ${e.toString()}");
      if (e is DioException) return left(ServerFailure.fromServerFailure(e));

      return left(ServerFailure("unable to process"));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> fetchBannerOneImages() async {
    try {
      String url = ("/banners-one");

      final result = await DioHelper.get(
        url: url,
      );
      // logger.d(result.data);
      return right(result.data);
    } catch (e) {
      logger.e("Get fetch  Banner error ${e.toString()}");
      if (e is DioException) return left(ServerFailure.fromServerFailure(e));

      return left(ServerFailure("unable to process"));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> fetchBannerTwoImages() async {
    try {
      String url = ("/banners-two");

      final result = await DioHelper.get(
        url: url,
      );
      // logger.d(result.data);
      return right(result.data);
    } catch (e) {
      logger.e("Get fetch  Banner error ${e.toString()}");
      if (e is DioException) return left(ServerFailure.fromServerFailure(e));

      return left(ServerFailure("unable to process"));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> fetchBannerThreeImages() async {
    try {
      String url = ("/banners-three");

      final result = await DioHelper.get(
        url: url,
      );
      // logger.d(result.data);
      return right(result.data);
    } catch (e) {
      logger.e("Get fetch  Banner error ${e.toString()}");
      if (e is DioException) return left(ServerFailure.fromServerFailure(e));

      return left(ServerFailure("unable to process"));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> fetchFlashDealData(
      int id) async {
    try {
      String url = ("/flash-deal-products/" + id.toString());

      final result = await DioHelper.get(
        url: url,
      );
      // logger.d(result.data);
      return right(result.data);
    } catch (e) {
      logger.e("Get fetch  Banner error ${e.toString()}");
      if (e is DioException) return left(ServerFailure.fromServerFailure(e));

      return left(ServerFailure("unable to process"));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> fetchTodayDealData() async {
    try {
      String url = ("/products/todays-deal");

      final result = await DioHelper.get(
        url: url,
      );
      return right(result.data);
    } catch (e) {
      logger.e("Get fetch  Banner error ${e.toString()}");
      if (e is DioException) return left(ServerFailure.fromServerFailure(e));

      return left(ServerFailure("unable to process"));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> fetchFeaturedBrand() async {
    try {
      String url = ("/brands" + "?page=1&name=");
      final result = await DioHelper.get(
        url: url,
      );
      // logger.d(result.data);
      return right(result.data);
    } catch (e) {
      logger.e("Get fetch   Featured Brand error ${e.toString()}");
      if (e is DioException) return left(ServerFailure.fromServerFailure(e));

      return left(ServerFailure("unable to process"));
    }
  }
}

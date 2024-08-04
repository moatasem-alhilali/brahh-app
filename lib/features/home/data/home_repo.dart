import 'package:active_ecommerce_flutter/core/failure/failure.dart';
import 'package:dartz/dartz.dart';

abstract class HomeRepository {
  Future<Either<Failure, Map<String, dynamic>>> fetchAllProducts(
      Map<String, dynamic> data);
  Future<Either<Failure, Map<String, dynamic>>> fetchFeaturedProducts();
  //

  Future<Either<Failure, Map<String, dynamic>>> fetchFeaturedCategories();

    Future<Either<Failure, Map<String, dynamic>>> fetchFeaturedBrand();


  //
  Future<Either<Failure, Map<String, dynamic>>> fetchCarouselImages();
  Future<Either<Failure, Map<String, dynamic>>> fetchBannerOneImages();
  Future<Either<Failure, Map<String, dynamic>>> fetchBannerTwoImages();
  Future<Either<Failure, Map<String, dynamic>>> fetchBannerThreeImages();

  //
  Future<Either<Failure, Map<String, dynamic>>> fetchTodayDealData();
  Future<Either<Failure, Map<String, dynamic>>> fetchFlashDealData(int id);
}

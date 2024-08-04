part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class SetStateHomeEvent extends HomeEvent {}

//product
class GetAllProductsEvent extends HomeEvent {}

class GetAllProductsMoreEvent extends HomeEvent {}

class GetFeaturedCategoriesEvent extends HomeEvent {}

class GetFeaturedProductsEvent extends HomeEvent {}

class GetFeaturedBrandsEvent extends HomeEvent {}

//

class FetchCarouselImagesEvent extends HomeEvent {}

class FetchBannerOneImagesEvent extends HomeEvent {}

class FetchBannerTwoImagesEvent extends HomeEvent {}

class FetchTodayDealDataEvent extends HomeEvent {}

class FetchFlashDealDataEvent extends HomeEvent {}

class DownloadImageEvent extends HomeEvent {
  final String url;
  final String ?name;

  DownloadImageEvent(this.url, this.name);
}

part of 'category_bloc.dart';

@immutable
class CategoryState {
  RState topCategoriesState;
  RState loadMoreState;
  int id;

  //
  RState categoryState;

  CategoryState({
    this.loadMoreState = RState.defaults,
    this.topCategoriesState = RState.defaults,
    this.categoryState = RState.defaults,
    this.id = 0,
  });
}

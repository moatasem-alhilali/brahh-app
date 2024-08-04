part of 'category_bloc.dart';

@immutable
abstract class CategoryEvent {}

class GetTopCategories extends CategoryEvent {}

class GetCategories extends CategoryEvent {
  final int id;
  GetCategories({required this.id});
}


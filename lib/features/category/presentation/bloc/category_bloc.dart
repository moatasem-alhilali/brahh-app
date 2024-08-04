import 'dart:async';
import 'package:active_ecommerce_flutter/data_model/category_response.dart';
import 'package:active_ecommerce_flutter/main.dart';
import 'package:active_ecommerce_flutter/repositories/category_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '/core/failure/request_state.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  ScrollController scrollCategory = ScrollController();
  late CategoryResponse topCategories;
  int page = 1;
  CategoryBloc() : super(CategoryState()) {
    scrollCategory.addListener(() {
      if (scrollCategory.position.pixels ==
          scrollCategory.position.maxScrollExtent) {
        logger.d('scrollCategory');
      }
    });

    on<GetTopCategories>(getTopCategories);

    //
  }

  FutureOr<void> getTopCategories(event, emit) async {
    try {
      emit(CategoryState(topCategoriesState: RState.loading));
      topCategories = await CategoryRepository().getCategories();
      emit(CategoryState(topCategoriesState: RState.success));
    } catch (e) {
      emit(CategoryState(topCategoriesState: RState.error));
    }
  }
}

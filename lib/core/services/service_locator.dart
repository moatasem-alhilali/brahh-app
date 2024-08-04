import 'package:active_ecommerce_flutter/features/home/data/home_repo_imp.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  //Auth
  getIt.registerSingleton<HomeRepositoryImp>(HomeRepositoryImp());
}

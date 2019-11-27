import 'package:get_it/get_it.dart';

import 'package:team_project/api.dart';
import 'package:team_project/viewModel.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.reset();
  locator.registerLazySingleton(() => Api('menu'));
  locator.registerLazySingleton(() => ViewModel());
}
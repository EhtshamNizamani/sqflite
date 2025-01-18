import 'package:get_it/get_it.dart';
import 'package:sqflite_crud/providers/item_provider.dart';

final GetIt locator = GetIt.instance;
void setupLocator() {
  locator.registerLazySingleton(() => ItemProvider());
}

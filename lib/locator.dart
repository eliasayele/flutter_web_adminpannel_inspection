import 'package:get_it/get_it.dart';
import 'package:inspection_admin/controllers/FilterNotifieer.dart';
import 'package:inspection_admin/controllers/SummaryNotifier.dart';

GetIt locator = GetIt.instance;

Future<void> setUp() async {
  locator.registerLazySingleton(() => FilterNotifier());
  locator.registerLazySingleton(() => SummaryNotifier());
  //locator.registerFactory(() => ApiServices());
}

import 'package:easacc_task/repositories/auth_repository.dart';
import 'package:easacc_task/repositories/bluetooth_repo.dart';
import 'package:easacc_task/repositories/wifi_repo.dart';
import 'package:easacc_task/views_model/auth_controller/auth_cubit.dart';
import 'package:easacc_task/views_model/bluetooth_controller/bluetooth_cubit.dart';
import 'package:easacc_task/views_model/webview_controller/webview_cubit.dart';
import 'package:easacc_task/views_model/wifi_controller/wifi_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:network_info_plus/network_info_plus.dart';
import '../../views_model/settings_controller/settings_cubit.dart';
import 'logging_service.dart';

final GetIt sl = GetIt.instance;

class DI {
  static Future<void> init() async {
    try {
      /// Repositories
      sl.registerLazySingleton<WifiRepo>(() => WifiRepo());
      sl.registerLazySingleton<FlutterBluetoothSerialRepo>(() => FlutterBluetoothSerialRepo());
      sl.registerLazySingleton<FlutterBluePlusRepo>(() => FlutterBluePlusRepo());
      sl.registerLazySingleton<AuthRepository>(() => AuthRepository());

      /// Controllers
      sl.registerLazySingleton<AuthCubit>(()=> AuthCubit(sl<AuthRepository>()));
      sl.registerLazySingleton<WebviewCubit>(WebviewCubit.new);
      sl.registerLazySingleton<SettingsCubit>(SettingsCubit.new);
      sl.registerLazySingleton<WifiCubit>(() => WifiCubit(sl<WifiRepo>()));
      sl.registerLazySingleton<BluetoothCubit>(()=> BluetoothCubit(availableBluetoothRepo: sl<FlutterBluePlusRepo>(),pairedBluetoothRepo: sl<FlutterBluetoothSerialRepo>()));

      /// Firebase
      sl.registerLazySingleton<FirebaseAuth>(()=> FirebaseAuth.instance);

      /// Others
      sl.registerLazySingleton<NetworkInfo>(NetworkInfo.new);
    } catch (e, stackTrace) {
      LoggingService.showMsg("$e,$stackTrace");
    }
  }
}

import 'package:easacc_task/core/constants/strings.dart';
import 'package:easacc_task/core/services/logging_service.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionService{
  static Future<void> kBluetooth() async {
    try{
      await [
        Permission.bluetooth,
        Permission.bluetoothScan,
        Permission.bluetoothConnect,
        Permission.location,
      ].request();
    }
    catch(e){
      LoggingService.showMsg(AppStrings.kSomethingWentWrong);
    }
  }
}
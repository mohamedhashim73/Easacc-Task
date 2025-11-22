import 'package:network_info_plus/network_info_plus.dart';
import '../core/constants/app_enums.dart';
import '../core/constants/strings.dart';
import '../core/services/dependency_injection.dart';
import '../models/device_model.dart';

class WifiRepo {
  Future<List<DeviceModel>> getDevices() async {
    final List<DeviceModel> devices = [];
    final ssid = await sl<NetworkInfo>().getWifiName();
    final bssid = await sl<NetworkInfo>().getWifiBSSID();
    if (ssid == null || ssid.isEmpty) {
      throw Exception(AppStrings.kWifiTurnedOffMsg);
    }
    final DeviceModel device = DeviceModel(
      name: ssid,
      id: bssid ?? ssid,
      type: DeviceType.wifi,
    );
    if( !devices.contains(device) ){
      devices.add(device);
    }
    return devices;
  }
}

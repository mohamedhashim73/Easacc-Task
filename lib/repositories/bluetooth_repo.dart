import 'package:easacc_task/core/constants/strings.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import '../core/constants/app_enums.dart';
import '../models/device_model.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

abstract class BluetoothRepo{
  Future<List<DeviceModel>> getPairedDevices({Duration timeout = const Duration(seconds: 5)});
  Future<List<DeviceModel>> getAvailableDevices({Duration timeout = const Duration(seconds: 5)});
}

class FlutterBluetoothSerialRepo implements BluetoothRepo{
  @override
  Future<List<DeviceModel>> getPairedDevices({Duration timeout = const Duration(seconds: 5)}) async {
    final List<DeviceModel> devices = [];
    final bool? isEnabled = await FlutterBluetoothSerial.instance.isEnabled;
    if (isEnabled == null || isEnabled == false) {
      throw Exception(AppStrings.kBluetoothMustTurnOnMsg);
    }
    final bondedDevices = await FlutterBluetoothSerial.instance.getBondedDevices();
    for (final device in bondedDevices) {
      final DeviceModel deviceModel = DeviceModel(
        name: device.name?.isNotEmpty == true ? device.name! : AppStrings.kUnknowDevice,
        id: device.address,
        type: DeviceType.bluetooth,
      );
      if (!devices.contains(deviceModel)) {
        devices.add(deviceModel);
      }
    }
    return devices;
  }

  @override
  Future<List<DeviceModel>> getAvailableDevices({Duration timeout = const Duration(seconds: 5)}) {
    throw Exception(AppStrings.kSomethingWentWrong);
  }
}

class FlutterBluePlusRepo implements BluetoothRepo{
  @override
  Future<List<DeviceModel>> getAvailableDevices({Duration timeout = const Duration(seconds: 5)}) async {
    final List<DeviceModel> devices = [];
    final bluetoothState = await FlutterBluePlus.adapterState.first;
    if (bluetoothState != BluetoothAdapterState.on) {
      throw Exception(AppStrings.kBluetoothMustTurnOnMsg);
    }
    FlutterBluePlus.startScan(timeout: timeout);
    await Future.delayed(timeout);
    final scanResults = await FlutterBluePlus.scanResults.first;
    for (final r in scanResults) {
      devices.add(
        DeviceModel(
          name: r.device.name.isNotEmpty ? r.device.name : AppStrings.kUnknowDevice,
          id: r.device.id.id,
          type: DeviceType.bluetooth,
        ),
      );
    }
    FlutterBluePlus.stopScan();
    return devices;
  }

  @override
  Future<List<DeviceModel>> getPairedDevices({Duration timeout = const Duration(seconds: 5)}) {
    throw Exception(AppStrings.kSomethingWentWrong);
  }
}

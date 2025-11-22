part of 'bluetooth_cubit.dart';

abstract class BluetoothStates {}

class InitialBluetoothState extends BluetoothStates {}

class GetPairedBluetoothDevicesState extends BluetoothStates {
  final ApiRequestStatus status;
  final String? error;
  GetPairedBluetoothDevicesState(this.status,{this.error});
}

class GetAvailableBluetoothDevicesState extends BluetoothStates {
  final ApiRequestStatus status;
  final String? error;
  GetAvailableBluetoothDevicesState(this.status,{this.error});
}
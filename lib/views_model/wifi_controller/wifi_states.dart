part of 'wifi_cubit.dart';

abstract class WifiStates {}

class InitialWifiState extends WifiStates {}

class GetWifiDevicesState extends WifiStates {
  final ApiRequestStatus status;
  final String? error;
  GetWifiDevicesState(this.status,{this.error});
}

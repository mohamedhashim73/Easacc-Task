import 'package:easacc_task/core/constants/extensions/string_extensions.dart';
import 'package:easacc_task/models/device_model.dart';
import 'package:easacc_task/repositories/wifi_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/app_enums.dart';
part 'wifi_states.dart';

class WifiCubit extends Cubit<WifiStates> {
  final WifiRepo repo;
  WifiCubit(this.repo) : super(InitialWifiState());

  List<DeviceModel>? devices;
  void getDevices({bool reset = false}) async {
    try{
      if( devices == null || devices?.isEmpty == true || reset )
      {
        if( reset ){
          devices?.clear();
        }
        emit(GetWifiDevicesState(ApiRequestStatus.loading));
        devices = await repo.getDevices();
        emit(GetWifiDevicesState(ApiRequestStatus.success));
      }
    }
    catch(e){
      emit(GetWifiDevicesState(ApiRequestStatus.failure,error: e.toString().formatError));
    }
  }
}

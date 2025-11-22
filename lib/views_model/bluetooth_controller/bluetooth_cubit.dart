import 'dart:async';
import 'package:easacc_task/core/services/logging_service.dart';
import 'package:easacc_task/core/services/permissions_service.dart';
import 'package:easacc_task/models/device_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/app_enums.dart';
import '../../repositories/bluetooth_repo.dart';
part 'bluetooth_states.dart';

class BluetoothCubit extends Cubit<BluetoothStates> {
  final BluetoothRepo pairedBluetoothRepo;
  final BluetoothRepo availableBluetoothRepo;
  BluetoothCubit({required this.pairedBluetoothRepo,required this.availableBluetoothRepo}) : super(InitialBluetoothState());

  void stopScan(){
    try{
      discoverySubscription?.cancel();
      discoverySubscription = null;
    }
    catch(e){
      LoggingService.showMsg(e);
    }
  }

  Future<void> scanDevices({bool permissionAlreadyCalled = false}) async {
    if( permissionAlreadyCalled ){
      await PermissionService.kBluetooth();
    }
    await getPairedDevices();
    await getAvailableDevices();
  }

  List<DeviceModel>? pairedDevices;
  List<DeviceModel>? availableDevices;
  StreamSubscription<DeviceModel>? discoverySubscription;
  Future<void> getPairedDevices({bool reset = false}) async {
    try{
      if( pairedDevices == null || pairedDevices?.isEmpty == true || reset )
      {
        if( reset ){
          pairedDevices?.clear();
        }
        emit(GetPairedBluetoothDevicesState(ApiRequestStatus.loading));
        pairedDevices = await pairedBluetoothRepo.getPairedDevices();
        emit(GetPairedBluetoothDevicesState(ApiRequestStatus.success));
      }
    }
    catch(e){
      LoggingService.showMsg(e);
      emit(GetPairedBluetoothDevicesState(ApiRequestStatus.failure,error: e.toString()));
    }
  }

  Future<void> getAvailableDevices({bool reset = false}) async {
    try{
      if( availableDevices == null || availableDevices?.isEmpty == true || reset )
      {
        if( reset ){
          availableDevices?.clear();
        }
        emit(GetAvailableBluetoothDevicesState(ApiRequestStatus.loading));
        availableDevices = await availableBluetoothRepo.getAvailableDevices();
        emit(GetAvailableBluetoothDevicesState(ApiRequestStatus.success));
      }
    }
    catch(e){
      LoggingService.showMsg(e);
      emit(GetAvailableBluetoothDevicesState(ApiRequestStatus.failure,error: e.toString()));
    }
  }
}

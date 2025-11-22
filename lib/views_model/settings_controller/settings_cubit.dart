import 'package:easacc_task/core/components/custom_dialogs_widget/showSnackBar.dart';
import 'package:easacc_task/core/constants/extensions/buildContext_extensions.dart';
import 'package:easacc_task/core/constants/routes.dart';
import 'package:easacc_task/core/constants/strings.dart';
import 'package:easacc_task/core/services/logging_service.dart';
import 'package:easacc_task/core/services/permissions_service.dart';
import 'package:easacc_task/views/webview_page/webview_page.dart';
import 'package:easacc_task/views_model/bluetooth_controller/bluetooth_cubit.dart';
import 'package:easacc_task/views_model/wifi_controller/wifi_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/services/dependency_injection.dart';
part 'settings_states.dart';

class SettingsCubit extends Cubit<SettingsStates> {
  SettingsCubit() : super(InitialSettingsState());

  late TextEditingController urlCtr;
  late GlobalKey<FormState> formKey;
  final WifiCubit _wifiCubit = sl<WifiCubit>();
  final BluetoothCubit _bluetoothCubit = sl<BluetoothCubit>();

  void init() async {
    urlCtr = TextEditingController();
    formKey = GlobalKey<FormState>();
    await PermissionService.kBluetooth();
    _wifiCubit.getDevices();
    _bluetoothCubit.scanDevices(permissionAlreadyCalled: true);
  }

  void dispose(){
    try{
      urlCtr.dispose();
    }
    catch(e){
      LoggingService.showMsg(AppStrings.kSomethingWentWrong);
    }
  }

  void openWebView(String url){
    try{
      if( formKey.currentState?.validate() == true ){
        AppRoutes.key.currentContext!.push(WebviewPage(url: url));
      }
    }
    catch(e){
      showSnackBarWidget(message: AppStrings.kSomethingWentWrong,isError: true);
    }
  }
}

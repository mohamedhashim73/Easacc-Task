import 'package:easacc_task/core/constants/extensions/buildContext_extensions.dart';
import 'package:easacc_task/views/settings_page/widgets/available_bluetooth_devices_column_widget.dart';
import 'package:easacc_task/views/settings_page/widgets/paired_bluetooth_devices_column_widget.dart';
import 'package:easacc_task/views/settings_page/widgets/enter_website_column_widget.dart';
import 'package:easacc_task/views/settings_page/widgets/wifi_devices_column_widget.dart';
import 'package:easacc_task/views_model/bluetooth_controller/bluetooth_cubit.dart';
import 'package:easacc_task/views_model/wifi_controller/wifi_cubit.dart';
import 'package:flutter/material.dart';
import '../../core/services/dependency_injection.dart';
import '../../views_model/settings_controller/settings_cubit.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final SettingsCubit _settingsCubit = sl<SettingsCubit>();
  final WifiCubit _wifiCubit = sl<WifiCubit>();
  final BluetoothCubit _bluetoothCubit = sl<BluetoothCubit>();

  @override
  void initState() {
    _settingsCubit.init();
    super.initState();
  }

  @override
  void dispose() {
    _settingsCubit.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Form(
        key: _settingsCubit.formKey,
        child: ListView(
          padding: context.scaffoldPadding.copyWith(bottom: 22),
          children: [
            EnterWebsiteColumnWidget(urlCtr: _settingsCubit.urlCtr,onTap: ()=> _settingsCubit.openWebView(_settingsCubit.urlCtr.text),),
            WifiDevicesColumnWidget(cubit: _wifiCubit,),
            PairedBluetoothDevicesColumnWidget(cubit: _bluetoothCubit,),
            AvailableBluetoothDevicesColumnWidget(cubit: _bluetoothCubit)
          ],
        ),
      ),
    );
  }
}

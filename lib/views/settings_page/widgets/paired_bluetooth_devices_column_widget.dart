import 'package:easacc_task/core/components/custom_txt_widgets/header_txt_row_widget.dart';
import 'package:easacc_task/core/constants/extensions/buildContext_extensions.dart';
import 'package:easacc_task/core/constants/extensions/widgets_extensions.dart';
import 'package:easacc_task/core/constants/strings.dart';
import 'package:easacc_task/core/theme/app_colors.dart';
import 'package:easacc_task/views/settings_page/widgets/device_card_widget.dart';
import 'package:easacc_task/views_model/bluetooth_controller/bluetooth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/components/custom_listview_widgets/custom_listview_widget.dart';
import '../../../core/components/data_state_widgets/data_state_handler_widget.dart';
import '../../../core/constants/app_enums.dart';

class PairedBluetoothDevicesColumnWidget extends StatelessWidget {
  final BluetoothCubit cubit;
  const PairedBluetoothDevicesColumnWidget({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.kGrey,width: 0.71))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeaderTxtRowWidget(txt: "Paired Bluetooth"),
          BlocBuilder<BluetoothCubit,BluetoothStates>(
            bloc: cubit,
            buildWhen: (_,current)=> current is GetPairedBluetoothDevicesState,
            builder: (context,state)=> DataStateBuilderWidget(
              isEmpty: cubit.pairedDevices == null || cubit.pairedDevices?.isEmpty == true,
              emptyTxt: AppStrings.kNoBluetoothDeviceExist,
              isError: state is GetPairedBluetoothDevicesState && state.status == ApiRequestStatus.failure,
              errorTxt: state is GetPairedBluetoothDevicesState && state.status == ApiRequestStatus.failure ? state.error : null,
              failureTap: ()=> cubit.scanDevices(),
              shimmerWidget: Container(
                decoration: BoxDecoration(
                    color: AppColors.kWhite,
                    borderRadius: context.min,
                    border: context.basic
                ),
                child: ShimmerListViewWidget(
                  count: 3,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (index)=> ShimmerDeviceCardWidget(borderIsOn: index == 2, type: DeviceType.bluetooth),
                ),
              ),
              isSuccessOrEmpty: cubit.pairedDevices?.isNotEmpty == true || (state is GetPairedBluetoothDevicesState && state.status == ApiRequestStatus.success),
              widget: (()=> Container(
                decoration: BoxDecoration(
                  color: AppColors.kWhite,
                  borderRadius: context.min,
                  border: context.basic
                ),
                child: CustomListviewWidget(
                  length: cubit.pairedDevices?.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (index)=> DeviceCardWidget(device: cubit.pairedDevices![index],isLast: index == (cubit.pairedDevices!.length - 1),)),
              )).lazy,
            ),
          ),
        ],
      ),
    );
  }
}


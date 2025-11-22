import 'package:easacc_task/core/components/custom_txt_widgets/header_txt_row_widget.dart';
import 'package:easacc_task/core/constants/extensions/buildContext_extensions.dart';
import 'package:easacc_task/core/constants/extensions/widgets_extensions.dart';
import 'package:easacc_task/core/constants/strings.dart';
import 'package:easacc_task/core/theme/app_colors.dart';
import 'package:easacc_task/views/settings_page/widgets/device_card_widget.dart';
import 'package:easacc_task/views_model/wifi_controller/wifi_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/components/custom_listview_widgets/custom_listview_widget.dart';
import '../../../core/components/data_state_widgets/data_state_handler_widget.dart';
import '../../../core/constants/app_enums.dart';

class WifiDevicesColumnWidget extends StatelessWidget {
  final WifiCubit cubit;
  const WifiDevicesColumnWidget({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 22),
      padding: EdgeInsets.only(top: 14,bottom: 22),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.kGrey,width: 0.71))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeaderTxtRowWidget(txt: "Networks",trailingTxt: "Search",trailingTap: ()=> cubit.getDevices(reset: true),trailingStyle: Theme.of(context).textTheme.labelMedium?.copyWith(color: AppColors.kMain),),
          BlocBuilder<WifiCubit,WifiStates>(
            bloc: cubit,
            buildWhen: (_,current)=> current is GetWifiDevicesState,
            builder: (context,state)=> DataStateBuilderWidget(
              isEmpty: cubit.devices == null || cubit.devices?.isEmpty == true,
              emptyTxt: AppStrings.kNoWifiDeviceExist,
              isError: state is GetWifiDevicesState && state.status == ApiRequestStatus.failure,
              errorTxt: state is GetWifiDevicesState && state.status == ApiRequestStatus.failure ? state.error : null,
              failureTap: ()=> cubit.getDevices(),
              shimmerWidget: Container(
                decoration: BoxDecoration(
                    color: AppColors.kWhite,
                    borderRadius: context.min,
                    border: context.basic
                ),
                child: ShimmerListViewWidget(
                  count: 3,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (index)=> ShimmerDeviceCardWidget(borderIsOn: index == 2, type: DeviceType.wifi),
                ),
              ),
              isSuccessOrEmpty: cubit.devices?.isNotEmpty == true || (state is GetWifiDevicesState && state.status == ApiRequestStatus.success),
              widget: (()=> Container(
                decoration: BoxDecoration(
                  color: AppColors.kWhite,
                  borderRadius: context.min,
                  border: context.basic
                ),
                child: CustomListviewWidget(
                  length: cubit.devices?.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (index)=> DeviceCardWidget(device: cubit.devices![index],isLast: index == (cubit.devices!.length - 1),)),
              )).lazy,
            ),
          )
        ],
      ),
    );
  }
}



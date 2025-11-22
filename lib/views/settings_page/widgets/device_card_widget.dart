import 'package:easacc_task/core/components/shimmer_widgets/shimmer_card_widget.dart';
import 'package:easacc_task/core/constants/app_enums.dart';
import 'package:easacc_task/core/constants/extensions/string_extensions.dart';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../models/device_model.dart';

class DeviceCardWidget extends StatelessWidget {
  final DeviceModel device;
  final bool isLast;
  const DeviceCardWidget({super.key, required this.device, required this.isLast});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 14),
        margin: EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
            border: isLast ? null : Border(bottom: BorderSide(color: AppColors.kBorder,width: 1))
        ),
        child: Row(
          spacing: 10,
          children: [
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 2,
              children: [
                Text(device.name.rmQuotes,overflow:TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14,color: AppColors.kBlack),maxLines: 1,),
                Text("${device.type == DeviceType.wifi ? "ID" : "Address"} : ${device.id}",overflow:TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.w400,fontSize: 12,color: AppColors.kLightBlack),maxLines: 1,),
              ],
            )),
            Icon(device.type == DeviceType.wifi ? Icons.wifi : Icons.bluetooth,color: AppColors.kMain,size: 22,)
          ],
        )
    );
  }
}

class ShimmerDeviceCardWidget extends StatelessWidget {
  final bool borderIsOn;
  final DeviceType type;
  const ShimmerDeviceCardWidget({super.key,required this.borderIsOn, required this.type});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 14),
        margin: EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
            border: borderIsOn ? null : Border(bottom: BorderSide(color: AppColors.kBorder,width: 1))
        ),
        child: Row(
          spacing: 10,
          children: [
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 6,
              children: [
                ShimmerItemWidget(height: 10,width: 74,),
                ShimmerItemWidget(height: 10,width: 122,),
              ],
            )),
            Icon(type == DeviceType.wifi ? Icons.wifi : Icons.bluetooth,color: AppColors.kShimmer,size: 22,)
          ],
        )
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../constants/strings.dart';
import '../../services/asset_service.dart';
import '../../theme/app_colors.dart';

class EmptyViewWidget extends StatelessWidget {
  final String? title;
  final double? size;
  final double? txtSize;
  final Color? color;
  final bool sizesIsMin;
  const EmptyViewWidget({super.key, this.sizesIsMin = false,required this.title, this.size, this.color, this.txtSize});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 10,
        children:
        [
          SvgPicture.asset(AssetsService.icEmpty,height: size ?? 122,width: size ?? 122,color: color),
          Text(title ?? AppStrings.kEmptyTxt,style: TextStyle(color: AppColors.kLightBlack,fontSize: txtSize ?? 14,fontWeight: FontWeight.w500),textAlign: TextAlign.center)
        ],
      ),
    );
  }
}

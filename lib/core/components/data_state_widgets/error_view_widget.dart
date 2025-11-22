import 'package:easacc_task/core/constants/extensions/buildContext_extensions.dart';
import 'package:easacc_task/core/constants/extensions/string_extensions.dart';
import 'package:flutter/material.dart';
import '../../constants/strings.dart';
import '../../services/asset_service.dart';
import '../../theme/app_colors.dart';

class ErrorViewWidget extends StatelessWidget {
  final Function()? retryFunction;
  final double? size;
  final double? txtSize;
  final bool sizesIsMin;
  final String? message;
  final FontWeight? txtWeight;
  const ErrorViewWidget({super.key,this.retryFunction, this.sizesIsMin = false,this.size, this.txtSize, this.txtWeight, this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.cardPadding,
      child: Center(
        child: GestureDetector(
          onTap: retryFunction,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 10,
            children:
            [
              Image.asset(AssetsService.error,height: size ?? 122,width: size ?? 122),
              Text(message != null ? message!.formatError : AppStrings.kSomethingWentWrong,style: TextStyle(color: AppColors.kLightBlack,fontSize: txtSize ?? 14,fontWeight: txtWeight ?? FontWeight.w500,),textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../constants/constants.dart';
import '../../theme/app_colors.dart';
import 'toggle_between_widgets.dart';

class LoadingViewWidget extends StatelessWidget {
  final String? message;
  final Color? color;
  final double? size;
  final double? cupertinoRadius;
  const LoadingViewWidget({super.key, this.message,this.color, this.size, this.cupertinoRadius});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ToggleBetweenWidgets(
          showFirst: AppConstants.kPlatformIsIOS,
          first: CupertinoActivityIndicator(color: color ?? AppColors.kSecondary,radius: cupertinoRadius ?? 16,),
          second: SizedBox(
            height: size ?? 22,
            width: size ?? 22,
            child: CircularProgressIndicator(
              strokeWidth: 2.4,
              color: color ?? AppColors.kSecondary,
            ),
          )
      ),
    );
  }
}

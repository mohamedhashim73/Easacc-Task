import 'package:easacc_task/core/constants/extensions/widgets_extensions.dart';
import 'package:easacc_task/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class HeaderTxtRowWidget extends StatelessWidget {
  final String txt;
  final String? trailingTxt;
  final TextStyle? trailingStyle;
  final Function()? trailingTap;
  final double bSpace;
  const HeaderTxtRowWidget({super.key,this.bSpace = 10,this.trailingTxt, required this.txt, this.trailingTap, this.trailingStyle});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      children: [
        Expanded(
          child: Text(txt,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: AppColors.kBlack),),
        ),
        Visibility(
          visible: trailingTxt != null,
          child: GestureDetector(
            onTap: trailingTap,
            child: Text("$trailingTxt",style: trailingStyle ?? TextStyle(fontSize: 12,fontWeight: FontWeight.w400,color: AppColors.kSecondary)),
          ),
        )
      ],
    ).marginOnly(bottom: bSpace);
  }
}

import 'package:easacc_task/core/constants/extensions/buildContext_extensions.dart';
import 'package:easacc_task/core/constants/strings.dart';
import 'package:easacc_task/core/services/logging_service.dart';
import 'package:flutter/material.dart';
import '../../constants/routes.dart';

void showSnackBarWidget({required String message,bool isError = false,Duration? duration}) {
  try{
    SnackBar snackBarItem() => SnackBar(
      elevation: 0,
      duration: duration ?? Duration(milliseconds: 400),
      padding: AppRoutes.key.currentContext!.cardPadding,
      content: Align(alignment:AlignmentDirectional.topStart, child: Text(message,style:const TextStyle(fontSize: 14,fontWeight: FontWeight.bold),)),backgroundColor: !isError ? Colors.black : Colors.red,
    );
    ScaffoldMessenger.of(AppRoutes.key.currentContext!).showSnackBar(snackBarItem());
  }
  catch(e){
    LoggingService.showMsg(AppStrings.kSomethingWentWrong);
  }
}
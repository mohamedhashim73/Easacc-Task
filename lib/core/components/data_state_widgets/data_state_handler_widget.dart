import 'package:flutter/material.dart';
import 'empty_view_widget.dart';
import 'error_view_widget.dart';
import 'loading_view_widget.dart';

class DataStateBuilderWidget extends StatelessWidget {
  final bool isError;
  final String? errorTxt;
  final bool isSuccessOrEmpty;
  final bool isEmpty;
  final Widget widget;
  final String? emptyTxt;
  final Widget? emptyWidget;
  final Function()? failureTap;
  final Widget? shimmerWidget;
  final double? emptyOrErrorTxtSize;
  final double? errorOrEmptyImageSize;
  final double? errorTxtSize;
  final EdgeInsets? marginOfEmptyOrError;
  const DataStateBuilderWidget({super.key,required this.isError, required this.isEmpty,this.errorTxt, required this.isSuccessOrEmpty,required this.widget, this.shimmerWidget, this.emptyTxt, this.emptyOrErrorTxtSize,this.failureTap, this.marginOfEmptyOrError,this.errorOrEmptyImageSize, this.errorTxtSize,this.emptyWidget});

  @override
  Widget build(BuildContext context) {
    if (isSuccessOrEmpty) {
      if(!isEmpty){
        return widget;
      }
      else
      {
        return emptyWidget ?? Container(
          margin: marginOfEmptyOrError,
          child: EmptyViewWidget(
              title: emptyTxt,
              txtSize: emptyOrErrorTxtSize,
              size: errorOrEmptyImageSize,
          ),
        );
      }
    }
    else if (isError) {
      return Container(
        margin: marginOfEmptyOrError,
        child: ErrorViewWidget(
          retryFunction: failureTap,
          txtSize: emptyOrErrorTxtSize,
          message: errorTxt,
          size: errorOrEmptyImageSize,
        ),
      );
    }
    else
    {
      return shimmerWidget ?? const LoadingViewWidget();
    }
  }
}

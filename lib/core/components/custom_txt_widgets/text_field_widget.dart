import 'package:easacc_task/core/constants/extensions/buildContext_extensions.dart';
import 'package:easacc_task/core/constants/extensions/string_extensions.dart';
import 'package:easacc_task/core/constants/extensions/widgets_extensions.dart';
import 'package:flutter/material.dart';
import '../../constants/constants.dart';
import '../../theme/app_colors.dart';

class TxtFieldWidget extends StatefulWidget {
  final String label;
  final String? hint;
  final double columnSpacing;
  final TextStyle? labelStyle;
  final String? validatorTxt;
  final bool? enableLabelInsideTxtField;
  final TextEditingController controller;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;
  final bool? isPassword;
  final String? Function(String?)? validator;
  final bool? disabled;
  final FocusNode? focusNode;
  final Function()? onChanged;
  final double bSpace;
  final int? maxLength;
  const TxtFieldWidget({super.key,bool? enableValidation = false,this.textInputType,this.textInputAction, required this.label, required this.controller,this.isPassword, this.bSpace = 10, this.disabled,this.validator, this.validatorTxt, this.enableLabelInsideTxtField, this.maxLength, this.hint, this.labelStyle, this.columnSpacing = 10, this.focusNode, this.onChanged});

  @override
  State<TxtFieldWidget> createState() => _TxtFieldWidgetState();
}

class _TxtFieldWidgetState extends State<TxtFieldWidget> {
  FocusNode? _focusNode;

  @override
  void initState() {
    if( widget.focusNode == null ){
      _focusNode = FocusNode();
    }
    super.initState();
  }

  @override
  void dispose() {
    widget.focusNode?.dispose();
    _focusNode?.dispose();
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context)
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: widget.columnSpacing,
      children:
      [
        Visibility(
          visible: widget.enableLabelInsideTxtField == null,
          child: Text(widget.label,style: widget.labelStyle ?? TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: AppColors.kBlack),maxLines: 1,overflow: TextOverflow.ellipsis),
        ),
        TextFormField(
          controller: widget.controller,
          autocorrect: true,
          validator: widget.validator != null ? widget.validator! : (input){
            if( input == null || (input.isEmpty) )
            {
              return widget.validatorTxt ?? widget.label.formatTxtValidate;
            }
            else
            {
              return null;
            }
          },
          onChanged: (input){
            if( widget.onChanged != null ){
              setState(() {
                widget.onChanged!();
              });
            }
          },
          focusNode: widget.focusNode ?? _focusNode,
          style: TextStyle(fontSize: 14,height: 1.6,fontWeight: FontWeight.w400,color: AppColors.kBlack),
          enabled: widget.disabled != null ? false : true,
          keyboardType: widget.textInputType ?? TextInputType.text,
          obscureText: widget.isPassword ?? false,
          maxLength: widget.maxLength,
          onTapOutside: (pointerDownEvent)=> unFocus(),
          textInputAction: widget.textInputAction ?? TextInputAction.next,
          decoration: InputDecoration(
            labelText: widget.enableLabelInsideTxtField != null ? widget.label : null,
            labelStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: AppColors.kBlack),
            hintText: widget.hint,
            hintStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: AppColors.kGrey),
            contentPadding: context.cardPadding,
            enabledBorder: AppConstants.kEnabledInputBorder,
            focusedBorder: AppConstants.kFocusedInputBorder,
            errorBorder: AppConstants.kErrorInputBorder,
            counterText: "",
            focusedErrorBorder: AppConstants.kErrorInputBorder,
            filled: true,
            isDense: true,
            fillColor: AppColors.kWhite
          ),
        ),
      ],
    ).marginOnly(bottom: widget.bSpace);
  }

  void unFocus(){
    if( widget.focusNode != null ){
      widget.focusNode?.unfocus();
    }
    else
    {
      _focusNode?.unfocus();
    }
  }
}

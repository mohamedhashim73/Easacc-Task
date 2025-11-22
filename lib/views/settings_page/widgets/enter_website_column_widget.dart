import 'package:flutter/material.dart';
import '../../../core/components/btn_widgets/btn_widget.dart';
import '../../../core/components/custom_txt_widgets/text_field_widget.dart';

class EnterWebsiteColumnWidget extends StatelessWidget {
  final TextEditingController urlCtr;
  final Function() onTap;
  const EnterWebsiteColumnWidget({super.key, required this.urlCtr,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TxtFieldWidget(
          controller: urlCtr,
          label: "Enter Website URL",
          bSpace: 22,
          hint: 'https://example.com',
        ),
        BtnWidget(
          onTap: onTap,
          title: "Open WebView",
        ),
      ],
    );
  }
}

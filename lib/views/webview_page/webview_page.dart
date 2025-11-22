import 'package:easacc_task/core/constants/app_enums.dart';
import 'package:easacc_task/core/constants/extensions/widgets_extensions.dart';
import 'package:easacc_task/views_model/webview_controller/webview_cubit.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../core/components/data_state_widgets/data_state_handler_widget.dart';
import '../../core/services/dependency_injection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WebviewPage extends StatefulWidget {
  final String url;
  const WebviewPage({super.key, required this.url});

  @override
  State<WebviewPage> createState() => _WebviewPageState();
}

class _WebviewPageState extends State<WebviewPage> {
  final WebviewCubit _cubit = sl<WebviewCubit>();

  @override
  void initState() {
    _cubit.openWebsite(widget.url);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('WebView')),
      body: BlocBuilder<WebviewCubit,WebviewStates>(
        bloc: _cubit,
        builder: (context,state) {
          return DataStateBuilderWidget(
            isEmpty: false,
            isError: state is OpenWebviewState && state.status == ApiRequestStatus.failure,
            failureTap: ()=> _cubit.openWebsite(widget.url),
            isSuccessOrEmpty: state is OpenWebviewState && state.status == ApiRequestStatus.success,
            widget: (()=> WebViewWidget(controller: _cubit.controller)).lazy,
          );
        }
      ),
    );
  }
}

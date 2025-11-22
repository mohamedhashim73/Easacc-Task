import 'package:easacc_task/core/constants/app_enums.dart';
import 'package:easacc_task/core/constants/extensions/models_extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';
part 'webview_states.dart';

class WebviewCubit extends Cubit<WebviewStates> {
  WebviewCubit() : super(InitialWebviewState());

  late WebViewController controller;
  void openWebsite(String url){
    try{
      emit(OpenWebviewState(ApiRequestStatus.loading));
      controller = WebViewController()..setJavaScriptMode(JavaScriptMode.unrestricted)..setNavigationDelegate(NavigationDelegate(onPageStarted: (String url) {}, onPageFinished: (String url) {}, onHttpError: (HttpResponseError error) {}, onWebResourceError: (WebResourceError error) {},),)..loadRequest(Uri.tryParse(url).completeUrl(url));
      emit(OpenWebviewState(ApiRequestStatus.success));
    }
    catch(e){
      emit(OpenWebviewState(ApiRequestStatus.failure));
    }
  }
}

part of 'webview_cubit.dart';

abstract class WebviewStates {}

class InitialWebviewState extends WebviewStates {}

class OpenWebviewState extends WebviewStates {
  final ApiRequestStatus status;
  OpenWebviewState(this.status);
}


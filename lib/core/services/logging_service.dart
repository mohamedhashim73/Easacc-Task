import 'dart:developer';

class LoggingService{
  static bool kIsDebug = false;

  // TODO: Update It To True In Production
  static void showMsg(dynamic msg){
    if( kIsDebug ){
      log("$msg");
    }
  }
}
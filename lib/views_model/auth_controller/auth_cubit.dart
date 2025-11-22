import 'package:easacc_task/core/components/custom_dialogs_widget/showSnackBar.dart';
import 'package:easacc_task/core/constants/app_enums.dart';
import 'package:easacc_task/core/constants/extensions/buildContext_extensions.dart';
import 'package:easacc_task/core/constants/extensions/string_extensions.dart';
import 'package:easacc_task/core/constants/routes.dart';
import 'package:easacc_task/core/constants/strings.dart';
import 'package:easacc_task/core/network/cache_network.dart';
import 'package:easacc_task/core/services/logging_service.dart';
import 'package:easacc_task/views/settings_page/settings_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repositories/auth_repository.dart';
part 'auth_states.dart';

class AuthCubit extends Cubit<AuthStates> {
  final AuthRepository repo;
  AuthCubit(this.repo) : super(InitialAuthState());

  Future<void> signInWithGoogle() async {
    try{
      emit(SignInWithGoogleState(ApiRequestStatus.loading));
      final User? user = await repo.signInWithGoogle();
      LoggingService.showMsg("User ${user?.uid}");
      if (user != null) {
        await CacheManager.insertString(key: AppStrings.kCachedToken, value: user.uid);
        AppRoutes.key.currentContext!.pushAndRemovePreviousRoutes(SettingsPage());
        showSnackBarWidget(message: AppStrings.kAuthenticatedSuccessMsg);
        emit(SignInWithGoogleState(ApiRequestStatus.success));
      } else {
        showSnackBarWidget(message: AppStrings.kSomethingWentWrong,isError: true);
        emit(SignInWithGoogleState(ApiRequestStatus.failure));
      }
    }
    catch(e){
      showSnackBarWidget(message: e.toString().formatError,isError: true);
      emit(SignInWithGoogleState(ApiRequestStatus.failure));
    }
  }

  Future<void> signInWithFacebook() async {
    try{
      emit(SignInWithFacebookState(ApiRequestStatus.loading));
      final User? user = await repo.signInWithFacebook();
      LoggingService.showMsg("User ${user?.uid}");
      if (user != null) {
        await CacheManager.insertString(key: AppStrings.kCachedToken, value: user.uid);
        AppRoutes.key.currentContext!.pushAndRemovePreviousRoutes(SettingsPage());
        showSnackBarWidget(message: AppStrings.kAuthenticatedSuccessMsg);
        emit(SignInWithFacebookState(ApiRequestStatus.success));
      }
      else
      {
        showSnackBarWidget(message: AppStrings.kSomethingWentWrong,isError: true);
        emit(SignInWithFacebookState(ApiRequestStatus.failure));
      }
    }
    catch(e){
      showSnackBarWidget(message: e.toString().formatError,isError: true);
      emit(SignInWithFacebookState(ApiRequestStatus.failure));
    }
  }

  Future<void> signOut() async {

  }
}

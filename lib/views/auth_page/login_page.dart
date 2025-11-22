import 'package:easacc_task/core/components/btn_widgets/btn_widget.dart';
import 'package:easacc_task/core/constants/app_enums.dart';
import 'package:easacc_task/core/constants/extensions/widgets_extensions.dart';
import 'package:easacc_task/core/services/asset_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../core/services/dependency_injection.dart';
import '../../core/theme/app_colors.dart';
import '../../views_model/auth_controller/auth_cubit.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthCubit cubit = sl<AuthCubit>();
    return Scaffold(
      body: BlocBuilder<AuthCubit, AuthStates>(
        bloc: cubit,
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 14,
            children: [
              Text("Sign in options",style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600,color: AppColors.kBlack),).marginOnly(bottom: 8),
              BtnWidget(
                title: 'Sign in with Google',
                borderColor: AppColors.kBorder,
                widget: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 10,
                  children: [
                    SvgPicture.asset(AssetsService.icGoogle,height: 22,width: 22,),
                    Text('Sign in with Google',style: Theme.of(context).textTheme.labelMedium?.copyWith(color: AppColors.kBlack),)
                  ],
                ),
                color: AppColors.kBlack,
                backgroundColor: Colors.transparent,
                isLoading: state is SignInWithGoogleState && state.status == ApiRequestStatus.loading,
                onTap: () => cubit.signInWithGoogle(),
              ),
              BtnWidget(
                title: 'Sign in with Facebook',
                widget: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 10,
                  children: [
                    SvgPicture.asset(AssetsService.icFacebook,color: AppColors.kWhite,height: 22,width: 22,),
                    Text('Sign in with Facebook',style: Theme.of(context).textTheme.labelMedium,)
                  ],
                ),
                isLoading: state is SignInWithFacebookState && state.status == ApiRequestStatus.loading,
                onTap: () => cubit.signInWithFacebook(),
              ),
            ],
          ).paddingAll(14);
        },
      ),
    );
  }
}

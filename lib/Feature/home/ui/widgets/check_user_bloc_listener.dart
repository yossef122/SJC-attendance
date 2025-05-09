import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Core/helpers/extensions.dart';
import 'package:madarj/Core/networking/api_error_model.dart';
import 'package:madarj/Core/routing/routes.dart';
import 'package:madarj/Core/themes/colors.dart';
import 'package:madarj/Core/themes/styles.dart';
import 'package:madarj/Feature/home/logic/cubit/home_cubit.dart';
import 'package:madarj/Feature/home/logic/cubit/home_state.dart';
import 'package:madarj/generated/l10n.dart';

class CheckUserBlocListener extends StatelessWidget {
  const CheckUserBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeCubit, HomeState>(
      listenWhen: (prevoius, current) =>
          current is CheckUserLoading ||
          current is CheckUserSuccess ||
          current is CheckUserError,
      listener: (BuildContext context, state) {
        state.whenOrNull(
          checkUserLoading: () {
            showDialog(
              context: context,
              builder: (context) => const Center(
                child: CircularProgressIndicator(
                  color: ColorsManager.mainColor2,
                ),
              ),
            );
          },
          checkUserSuccess: (checkResponse) async {
            print(checkResponse.data[0].message);
            context.popAlert();
            if (checkResponse.data[0].attendanceState == "checked_out") {
              context.read<HomeCubit>().clockInText = S.of(context).Clock_In;
            }
            if (checkResponse.data[0].attendanceState == "checked_in") {
              context.read<HomeCubit>().clockInText = S.of(context).Clock_Out;
            }

            context.read<HomeCubit>().getAllHome2(context);
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                icon: Icon(
                  Icons.verified,
                  color: const Color.fromARGB(255, 0, 255, 13),
                  size: 32.w,
                ),
                content: Text(
                  // context.read<HomeCubit>().clockInText!,
                  checkResponse.data[0].message,
                  style: TextStyles.font15DarkBlueMedium,
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      // context.pop();
                      // Navigator.of(context).pop();
                      // context.read<HomeCubit>().getAllHome2();
                      Navigator.of(context).pop();

                      // context.pushNamed(Routes.homeScreen);

                      // context.pushReplacementNamed(Routes.loginScreen);
                    },
                    child: Text(
                      'got it',
                      style: TextStyles.font14BlueSemiBold,
                    ),
                  ),
                ],
              ),
            );
          },
          checkUserError: (error) {
            context.pop();
            setUpErrorState(context, error);
          },
        );
      },
      child: const SizedBox.shrink(),
    );
  }

  void setUpErrorState(BuildContext context, ApiErrorModel apiErrorModel) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: Icon(
          Icons.error,
          color: Colors.red,
          size: 32.w,
        ),
        content: Text(
          apiErrorModel.message!,
          style: TextStyles.font15DarkBlueMedium,
        ),
        actions: [
          TextButton(
            onPressed: () {
              // context.pop();
              Navigator.of(context).pop();
              context.pushNamedAndRemoveUntill(Routes.homeScreen);
            },
            child: Text(
              'try again',
              style: TextStyles.font14BlueSemiBold,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:madarj/Core/helpers/cach_helper.dart';
import 'package:madarj/Core/helpers/constants.dart';
import 'package:madarj/Core/helpers/extensions.dart';
import 'package:madarj/Core/helpers/shared_key.dart';
import 'package:madarj/Core/networking/dio_factory.dart';
import 'package:madarj/Core/routing/routes.dart';
import 'package:madarj/Core/themes/colors.dart';
import 'package:madarj/Core/themes/styles.dart';
import 'package:madarj/Core/widgets/custom_button.dart';
import 'package:madarj/Feature/home/ui/widgets/alert_design.dart';
import 'package:madarj/generated/l10n.dart';

class CustomAlert extends StatelessWidget {
  const CustomAlert({
    super.key,
    this.content,
  });
  final Widget? content;
  @override
  Widget build(BuildContext context) {
    return AlertDesign(
      content: content ??
          SizedBox(
            height: 400.h,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
                vertical: 20.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    width: 150.w,
                    height: 150.h,
                    "assets/images/logoutAlert.png",
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Text(
                    S.of(context).logout_and_login_again,
                    style: TextStyles.font18BlackBold,
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  CustomButton(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    title: S.of(context).no_continue_button,
                    textStyle: TextStyles.font14WhiteSemiBold,
                    color: ColorsManager.mainColor1,
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  CustomButton(
                    onTap: () async {
                      CachHelper.removeData(key: SharedKeys.userToken);
                      CachHelper.clearAllSecuredData();
                      context.pushNamedAndRemoveUntill(Routes.loginScreen);
                      AppConstants.isLogged = false;
                      await CachHelper.saveData(
                        key: SharedKeys.isLogged,
                        value: false,
                      );
                      DioFactory.setTokenAfterLogin(null);

                      // await DioFactory.setTokenAfterLogin(null);
                      // await CachHelper.removeData(key: 'token');
                      // await context.pushNamedAndRemoveUntill(Routes.login);
                    },
                    title: S.of(context).logout_button,
                    textStyle: TextStyles.font14WhiteSemiBold,
                    color: ColorsManager.red,
                  ),
                ],
              ),
            ),
          ),
    );
  }
}

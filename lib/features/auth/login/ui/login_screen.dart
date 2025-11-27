import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:home_ease/core/routing/routes.dart';
import 'package:home_ease/translations/locale_keys.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:home_ease/core/widgets/custom_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_ease/core/theming/text_styles%20.dart';
import 'package:home_ease/core/helpers/navigation_extensions.dart';
import 'package:home_ease/features/auth/login/ui/widgets/login_form.dart';
import 'package:home_ease/features/auth/login/ui/widgets/login_card_social.dart';
import 'package:home_ease/features/auth/login/ui/widgets/dont_have_account_text.dart';
import 'package:home_ease/features/auth/forgetpassword/ui/forget_password_screen.dart';
// ignore_for_file: unnecessary_import, depend_on_referenced_packages

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 80,
              ),
              Text(
                "Login".tr(),
                style: TextStyles.font28Black700,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 18.h),
                child: SizedBox(
                  width: 340.w,
                  child: Text(
                    textAlign: TextAlign.center,
                    "Welcome back! Please enter your details.".tr(),
                    style: TextStyles.font14Black500,
                  ),
                ),
              ),
              const LoginForm(),
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ForgetPasswordScreen(),
                      ),
                    );
                  },
                  child: Text(
                    "Forget Password".tr(),
                    style: TextStyles.font16Black600,
                  ),
                ),
              ),
              SizedBox(
                height: 24.h,
              ),
              CustomButton(
                text: "Login".tr(),
                onPressed: () {
                  context.pushNamed(
                    Routes.homeLayout,
                  );
                },
              ),
              SizedBox(
                height: 16.h,
              ),
              const LogicCardSocial(),
              const DontHaveAccountText(),
            ],
          ),
        ),
      ),
    );
  }
}

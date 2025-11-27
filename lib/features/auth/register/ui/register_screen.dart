import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:home_ease/translations/locale_keys.dart'; 
import 'package:home_ease/core/widgets/custom_button.dart';
import 'package:home_ease/core/theming/text_styles%20.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_ease/features/auth/register/ui/widgets/register_form.dart';
import 'package:home_ease/features/auth/register/ui/widgets/register_card_social.dart';
import 'package:home_ease/features/auth/register/ui/widgets/already_have_account_text.dart';
class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
        ),
        child: SingleChildScrollView(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 80.h,
              ),
              Center(
                child: Text(
                  "Register".tr(),
                  style: TextStyles.font28Black700,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 18.h),
                child: SizedBox(
                  width: 340.w,
                  child: Text(
                    textAlign: TextAlign.center,
                    "Welcome to Home Ease! Please enter your details to create an account.".tr(),
                    style: TextStyles.font14Black500,
                  ),
                ),
              ),
              const RegisterForm(),
              CustomButton(
                text: "Register".tr(),
                onPressed: () {},
              ),
              SizedBox(
                height: 15.h,
              ),
              const RegisterCardSocial(),
              const AlreadyHaveAccountText(),
            ],
          ),
        ),
      ),
    );
  }
}

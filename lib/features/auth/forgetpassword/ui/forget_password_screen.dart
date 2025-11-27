import 'package:flutter/material.dart';
import 'package:home_ease/core/routing/routes.dart';
import 'package:home_ease/core/theming/colors.dart';
import 'package:home_ease/core/helpers/app_regex.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:home_ease/translations/locale_keys.dart';
import 'package:home_ease/core/widgets/custom_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_ease/core/theming/text_styles%20.dart';
import 'package:home_ease/core/widgets/app_text_form_field.dart';
import 'package:home_ease/core/helpers/navigation_extensions.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.h),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "Forget Password".tr(),
                  style: TextStyles.font28Black700,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 24.h),
                child: Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: 340.w,
                    child: Text(
                      "Forgot your password? No problem. Just let us know which service you use and we'll send you a link to reset it."
                          .tr(),
                      textAlign: TextAlign.center,
                      style: TextStyles.font14Black500,
                    ),
                  ),
                ),
              ),
              Text(
                "Email".tr(),
                style: TextStyles.font16Black600,
              ),
              AppTextFormField(
                keyboardType: TextInputType.emailAddress,
                suffixIcon: Icon(
                  Icons.email_outlined,
                  color: ColorsApp.gray,
                ),
                hintText: "Enter your email".tr(),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      !AppRegex.isEmailValid(value)) {
                    return "Please enter a valid email".tr();
                  }
                },
              ),
              SizedBox(
                height: 48.h,
              ),
              CustomButton(
                onPressed: () {
                  context.pushNamed(Routes.forgetPasswordScreen);
                },
                text: "Submit".tr(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

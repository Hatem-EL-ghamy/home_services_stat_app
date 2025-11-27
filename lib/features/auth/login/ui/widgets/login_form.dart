import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart'; 
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_ease/core/theming/colors.dart';
import 'package:home_ease/core/helpers/app_regex.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_ease/core/theming/text_styles%20.dart';
import 'package:home_ease/core/widgets/app_text_form_field.dart'; 
// ignore_for_file: depend_on_referenced_packages


class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool isPasswordObscureText = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Email'.tr(),
            style: TextStyles.font16Black600,
          ),
          AppTextFormField(
            keyboardType: TextInputType.emailAddress,
            suffixIcon: Icon(
              Icons.email_outlined,
              color: ColorsApp.gray,
            ),
            hintText: 'Enter your Email'.tr(),
            validator: (value) {
              if (value == null ||
                  value.isEmpty ||
                  !AppRegex.isEmailValid(value)) {
                return 'Please enter a valid email'.tr();
              }
            },
          ),
          SizedBox(
            height: 18.h,
          ),
          Text(
            'Password'.tr(),
            style: TextStyles.font16Black600,
          ),
          AppTextFormField(
            isObscureText: isPasswordObscureText,
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  isPasswordObscureText = !isPasswordObscureText;
                });
              },
              child: Icon(
                isPasswordObscureText ? Icons.visibility_off : Icons.visibility,
                color: ColorsApp.gray,
              ),
            ),

            hintText: 'Enter Your Password'.tr(),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a valid Password'.tr();
              } else if (!AppRegex.hasMinLength(value)) {
                return 'Password must be at least 8 characters'.tr();
              }
            },
            // controller: context.read<AuthCubit>().passwordController,
          ),
          SizedBox(
            height: 16.h,
          ),
        ],
      ),
    );
  }
}

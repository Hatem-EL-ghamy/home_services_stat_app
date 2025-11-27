import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_ease/core/helpers/app_regex.dart';
import 'package:home_ease/core/helpers/navigation_extensions.dart';
import 'package:home_ease/core/networking/local/cache_helper.dart';
import 'package:home_ease/core/theming/colors.dart';
import 'package:home_ease/core/theming/text_styles%20.dart';
import 'package:home_ease/core/widgets/app_text_form_field.dart';
import 'package:home_ease/core/widgets/custom_button.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _fullNameController;
  late TextEditingController _phoneController;
  late TextEditingController _passwordController;
  bool _isPasswordObscure = true;

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController(
      text: CacheHelper.getData(key: 'fullName') ?? 'Abdul Aziz Al-Qahtany',
    );
    _phoneController = TextEditingController(
      text: CacheHelper.getData(key: 'phone') ?? '5621458751',
    );
    _passwordController = TextEditingController(text: '********');
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _saveChanges() {
    if (_formKey.currentState!.validate()) {
      CacheHelper.saveData(key: 'fullName', value: _fullNameController.text);
      CacheHelper.saveData(key: 'phone', value: _phoneController.text);
      
      Navigator.of(context).pop({
        'name': _fullNameController.text,
        'phone': _phoneController.text,
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Profile updated successfully'.tr()),
          backgroundColor: ColorsApp.mainGreen,
        ),
      );
    }
  }

  void _deleteAccount() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Account'.tr()),
        content: Text('Are you sure you want to delete your account? This action cannot be undone.'.tr()),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: Text('Cancel'.tr()),
          ),
          TextButton(
            onPressed: () {
              // Handle account deletion
              context.pop();
              context.pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Account deleted successfully'.tr()),
                  backgroundColor: Colors.red,
                ),
              );
            },
            child: Text(
              'Delete'.tr(),
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApp.lightGreen,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Edit Profile'.tr(),
          style: TextStyles.font18Black700,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Profile Picture with Camera Icon
              Stack(
                alignment: Alignment.center,
                children: [
                  CircleAvatar(
                    radius: 50.r,
                    backgroundColor: ColorsApp.lightGreen,
                    backgroundImage: const AssetImage('assets/images/profile.png'),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: ColorsApp.mainGreen,
                        shape: BoxShape.circle,
                        border: Border.all(color: ColorsApp.white, width: 2),
                      ),
                      child: Icon(
                        Icons.camera_alt,
                        color: ColorsApp.white,
                        size: 20.sp,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32.h),
              
              // Full Name Field
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  'Full Name'.tr(),
                  style: TextStyles.font16Black600,
                ),
              ),
              AppTextFormField(
                controller: _fullNameController,
                hintText: 'Enter your Full Name'.tr(),
                keyboardType: TextInputType.name,
                suffixIcon: const Icon(
                  Icons.person_2_outlined,
                  color: Color(0xffB5B5B5),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a valid Full Name'.tr();
                  } else if (value.length <= 3) {
                    return 'fullName must be at least 4 characters'.tr();
                  }
                  return null;
                },
              ),
              SizedBox(height: 18.h),
              
              // Phone Field
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  'Phone'.tr(),
                  style: TextStyles.font16Black600,
                ),
              ),
              AppTextFormField(
                controller: _phoneController,
                hintText: 'Enter your phone'.tr(),
                keyboardType: TextInputType.phone,
                suffixIcon: const Icon(
                  Icons.phone_outlined,
                  color: Color(0xffB5B5B5),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter mobile number'.tr();
                  } else if (!AppRegex.isPhoneNumberValid(value)) {
                    return 'Please enter valid mobile number'.tr();
                  }
                  return null;
                },
              ),
              SizedBox(height: 18.h),
              
              // Password Field
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  'Password'.tr(),
                  style: TextStyles.font16Black600,
                ),
              ),
              AppTextFormField(
                controller: _passwordController,
                hintText: 'Enter Your Password'.tr(),
                isObscureText: _isPasswordObscure,
                keyboardType: TextInputType.visiblePassword,
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      _isPasswordObscure = !_isPasswordObscure;
                    });
                  },
                  child: Icon(
                    _isPasswordObscure ? Icons.visibility_off : Icons.visibility,
                    color: const Color(0xffB5B5B5),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a valid Password'.tr();
                  } else if (!AppRegex.hasMinLength(value)) {
                    return 'Password must be at least 8 characters'.tr();
                  }
                  return null;
                },
              ),
              SizedBox(height: 40.h),
              
              // Save Changes Button
              CustomButton(
                text: 'Save Changes'.tr(),
                onPressed: _saveChanges,
              ),
              SizedBox(height: 20.h),
              
              // Delete Account Button
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[100],
                  minimumSize: Size(double.infinity, 60.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                ),
                onPressed: _deleteAccount,
                icon: const Icon(
                  Icons.delete_outlined,
                  color: Colors.red,
                ),
                label: Text(
                  'Delete Account'.tr(),
                  style: TextStyles.font16Black700.copyWith(color: Colors.red),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

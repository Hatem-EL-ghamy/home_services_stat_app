import 'package:flutter/material.dart';
import 'package:home_ease/core/routing/routes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:home_ease/translations/locale_keys.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserTypeSelectionScreen extends StatelessWidget {
  const UserTypeSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4CAF50), // الأخضر الرئيسي للتطبيق
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 40.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 🔹 شعار التطبيق
              const Icon(
                Icons.cleaning_services_rounded,
                color: Colors.white,
                size: 100,
              ),
              SizedBox(height: 20.h),

              Text(
                "Welcome to Home Service".tr(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Quicksand',
                ),
              ),
              SizedBox(height: 10.h),

              Text(
                "Select Account Type".tr(),
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                  fontFamily: 'Quicksand',
                ),
              ),
              SizedBox(height: 50.h),

              // 🔸 اختيار المستخدم العادي
              _buildOptionCard(
                context,
                title: "I am a User".tr(),
                description: "I am a User".tr(),
                icon: Icons.person_outline,
                onTap: () {
                  // go to register (create account) for regular users
                  Navigator.pushNamed(context, Routes.registerScreen);
                },
              ),

              SizedBox(height: 20.h),

              // 🔸 اختيار مزوّد الخدمة
              _buildOptionCard(
                context,
                title: "I am a Service Provider".tr(),
                description: "I am a Service Provider".tr(),
                icon: Icons.home_repair_service_rounded,
                onTap: () {
                  Navigator.pushNamed(
                      context, Routes.serviceProviderRegisterScreen);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 🔧 Widget مساعد لتصميم كل خيار
  Widget _buildOptionCard(
    BuildContext context, {
    required String title,
    required String description,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28.r,
              backgroundColor: const Color(0xFF4CAF50).withOpacity(0.15),
              child: Icon(icon, color: const Color(0xFF4CAF50), size: 28),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF212121),
                      fontFamily: 'Quicksand',
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey[600],
                      fontFamily: 'Quicksand',
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded,
                color: Color(0xFF4CAF50)),
          ],
        ),
      ),
    );
  }
}

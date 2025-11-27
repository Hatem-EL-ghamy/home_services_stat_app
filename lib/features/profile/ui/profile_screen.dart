import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_ease/core/helpers/navigation_extensions.dart';
import 'package:home_ease/core/networking/local/cache_helper.dart';
import 'package:home_ease/core/routing/routes.dart';
import 'package:home_ease/core/theming/colors.dart';
import 'package:home_ease/core/theming/text_styles%20.dart';
import 'package:home_ease/core/widgets/custom_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _notify = false;
  String? _storedName;
  String? _storedPhone;

  @override
  void initState() {
    super.initState();
    _storedName = CacheHelper.getData(key: 'fullName');
    _storedPhone = CacheHelper.getData(key: 'phone');
  }

  String _buildDisplayName(BuildContext context) {
    if (_storedName != null && _storedName!.trim().isNotEmpty) {
      return _storedName!;
    }
    return 'Abdul Aziz Al-Qahtany'.tr();
  }

  Future<void> _handleEditProfile() async {
    final result = await context.pushNamed(
      Routes.editProfileScreen,
      arguments: {
        'name': _storedName ?? '',
        'phone': _storedPhone ?? '',
      },
    );

    if (result is Map<String, String>) {
      setState(() {
        if ((result['name'] ?? '').trim().isNotEmpty) {
          _storedName = result['name'];
          CacheHelper.saveData(key: 'fullName', value: result['name']);
        }
        if ((result['phone'] ?? '').trim().isNotEmpty) {
          _storedPhone = result['phone'];
          CacheHelper.saveData(key: 'phone', value: result['phone']);
        }
      });
    }
  }

  void _logout(BuildContext context) {
    CacheHelper.removeData(key: "token");
    context.pushNamedAndRemoveUntil(Routes.loginScreen,
        predicate: (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApp.lightGreen,
      appBar: AppBar(
        leading: const SizedBox(),
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Profile'.tr(),
          style: TextStyles.font18Black700,
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        children: [
          _ProfileHeaderCard(
            name: _buildDisplayName(context),
            onEdit: _handleEditProfile,
          ),
          SizedBox(height: 20.h),
          _ProfileActionTile(
            icon: Icons.payment_rounded,
            title: 'Payment Methods'.tr(),
            subtitle: 'Add your credit & debit cards'.tr(),
            onTap: () => context.pushNamed(Routes.paymentScreenScreen),
          ),
          _ProfileActionTile(
            icon: Icons.location_on_outlined,
            title: 'Location'.tr(),
            subtitle: 'Add your Home Location'.tr(),
            onTap: () => context.pushNamed(Routes.addressScreenScreen),
          ),
          _ProfileActionTile(
            icon: Icons.notifications,
            title: 'Push Notification'.tr(),
            subtitle: 'For daily update and others'.tr(),
            trailing: Switch(
              value: _notify,
              activeColor: ColorsApp.mainGreen,
              inactiveTrackColor: ColorsApp.lightGray,
              onChanged: (value) => setState(() => _notify = value),
            ),
          ),
          _ProfileActionTile(
            icon: Icons.call_outlined,
            title: 'Contact Us'.tr(),
            subtitle: 'For more information'.tr(),
            onTap: () => context.pushNamed(Routes.contactUsScreen),
          ),
          _ProfileActionTile(
            icon: Icons.logout,
            title: 'Logout'.tr(),
            onTap: () => _logout(context),
          ),
        ],
      ),
    );
  }
}

class _ProfileHeaderCard extends StatelessWidget {
  final String name;
  final VoidCallback onEdit;
  const _ProfileHeaderCard({required this.name, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 28.h),
      decoration: BoxDecoration(
        color: ColorsApp.white,
        borderRadius: BorderRadius.circular(28.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 48.r,
            backgroundColor: ColorsApp.lightGreen,
            backgroundImage: const AssetImage('assets/images/profile.png'),
          ),
          SizedBox(height: 16.h),
          Text(
            name,
            style: TextStyles.font18Black700,
          ),
          SizedBox(height: 12.h),
          CustomButton(
            width: 130.w,
            height: 44.h,
            radius: 22.r,
            text: 'Edit'.tr(),
            onPressed: onEdit,
          ),
        ],
      ),
    );
  }
}

class _ProfileActionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  const _ProfileActionTile({
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: ColorsApp.white,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Container(
          padding: EdgeInsets.all(10.w),
          decoration: BoxDecoration(
            color: ColorsApp.lightGreen,
            borderRadius: BorderRadius.circular(14.r),
          ),
          child: Icon(
            icon,
            color: ColorsApp.mainGreen,
          ),
        ),
        title: Text(
          title,
          style: TextStyles.font16Black700,
        ),
        subtitle: subtitle == null
            ? null
            : Text(
                subtitle!,
                style: TextStyles.font14Black500,
              ),
        trailing: trailing ?? const Icon(Icons.chevron_right),
      ),
    );
  }
}

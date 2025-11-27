import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';

// Data Model
class ServiceProvider {
  String name;
  String profession;
  double rating;
  int completedOrders;
  int uniqueClients;
  double walletBalance;
  bool isAvailable;
  String? phoneNumber;
  String? profileImage;

  ServiceProvider({
    required this.name,
    required this.profession,
    required this.rating,
    required this.completedOrders,
    required this.uniqueClients,
    required this.walletBalance,
    this.isAvailable = true,
    this.phoneNumber,
    this.profileImage,
  });

  ServiceProvider copyWith({
    String? name,
    String? profession,
    double? rating,
    int? completedOrders,
    int? uniqueClients,
    double? walletBalance,
    bool? isAvailable,
    String? phoneNumber,
    String? profileImage,
  }) {
    return ServiceProvider(
      name: name ?? this.name,
      profession: profession ?? this.profession,
      rating: rating ?? this.rating,
      completedOrders: completedOrders ?? this.completedOrders,
      uniqueClients: uniqueClients ?? this.uniqueClients,
      walletBalance: walletBalance ?? this.walletBalance,
      isAvailable: isAvailable ?? this.isAvailable,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profileImage: profileImage ?? this.profileImage,
    );
  }
}

class Transaction {
  final String id;
  final String description;
  final double amount;
  final DateTime date;
  final String type;
  final String? orderId;

  Transaction({
    required this.id,
    required this.description,
    required this.amount,
    required this.date,
    required this.type,
    this.orderId,
  });
}

// Main Profile Screen with Bottom Navigation
class FreeProfileScreen extends StatefulWidget {
  final ServiceProvider provider;
  final List<Transaction> transactions;
  final Function(String, String) onUpdateProfile;
  final Function(bool) onToggleAvailability;
  final Function(double) onWithdraw;

  const FreeProfileScreen({
    super.key,
    required this.provider,
    required this.transactions,
    required this.onUpdateProfile,
    required this.onToggleAvailability,
    required this.onWithdraw,
  });

  @override
  State<FreeProfileScreen> createState() => _FreeProfileScreenState();
}

class _FreeProfileScreenState extends State<FreeProfileScreen> {
  int _selectedIndex = 0;

  final List<NavItem> _navItems = [
    NavItem(
      icon: Icons.person,
      label: 'Profile'.tr(),
      activeColor: const Color(0xFF52C41A),
    ),
    NavItem(
      icon: Icons.access_time,
      label: 'Orders'.tr(),
      activeColor: Colors.red,
    ),
    NavItem(
      icon: Icons.local_activity,
      label: 'Activity'.tr(),
      activeColor: Colors.blue,
    ),
    NavItem(
      icon: Icons.credit_card,
      label: 'Payment'.tr(),
      activeColor: Colors.grey,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          _ProfileContent(
            provider: widget.provider,
            transactions: widget.transactions,
            onUpdateProfile: widget.onUpdateProfile,
            onToggleAvailability: widget.onToggleAvailability,
            onWithdraw: widget.onWithdraw,
          ),
          _buildPlaceholderScreen('Orders'.tr(), Icons.access_time, Colors.red),
          _buildPlaceholderScreen('Activity'.tr(), Icons.local_activity, Colors.blue),
          _buildPlaceholderScreen(
              'Payment'.tr(), Icons.credit_card, Colors.grey),
        ],
      ),
      bottomNavigationBar: Container(
        height: 70.h,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(
            _navItems.length,
            (index) => _buildNavItem(index),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index) {
    final item = _navItems[index];
    final isSelected = _selectedIndex == index;
    final color = isSelected ? item.activeColor : Colors.grey[400]!;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Container(
        width: 70.w,
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(
                  item.icon,
                  size: 28.sp,
                  color: color,
                ),
                if (index == 1)
                  Positioned(
                    right: -4,
                    top: -4,
                    child: Container(
                      padding: EdgeInsets.all(4.w),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      constraints: BoxConstraints(
                        minWidth: 16.w,
                        minHeight: 16.h,
                      ),
                      child: Text(
                        '3',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 4.h),
            Text(
              item.label,
              style: TextStyle(
                fontSize: 12.sp,
                color: color,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholderScreen(String title, IconData icon, Color color) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Container(),
        title: Text(
          title,
          style:
              const TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 80.sp, color: color),
            SizedBox(height: 20.h),
            Text(
              '$title Page',
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NavItem {
  final IconData icon;
  final String label;
  final Color activeColor;

  NavItem({
    required this.icon,
    required this.label,
    required this.activeColor,
  });
}

// Profile Content Widget
class _ProfileContent extends StatefulWidget {
  final ServiceProvider provider;
  final List<Transaction> transactions;
  final Function(String, String) onUpdateProfile;
  final Function(bool) onToggleAvailability;
  final Function(double) onWithdraw;

  const _ProfileContent({
    required this.provider,
    required this.transactions,
    required this.onUpdateProfile,
    required this.onToggleAvailability,
    required this.onWithdraw,
  });

  @override
  _ProfileContentState createState() => _ProfileContentState();
}

class _ProfileContentState extends State<_ProfileContent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Container(),
        title: Text(
          'Profile'.tr(),
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 18.sp,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(20.w),
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 0,
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50.r,
                    backgroundColor: const Color(0xFF52C41A).withOpacity(0.1),
                    child: Icon(
                      Icons.person,
                      size: 50.sp,
                      color: const Color(0xFF52C41A),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    widget.provider.name,
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF333333),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    widget.provider.profession,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: const Color(0xFF666666),
                    ),
                  ),
                  if (widget.provider.phoneNumber != null) ...[
                    SizedBox(height: 4.h),
                    Text(
                      widget.provider.phoneNumber!,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: const Color(0xFF888888),
                      ),
                    ),
                  ],
                  SizedBox(height: 16.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildStatItem(
                          'Rating'.tr(),
                          widget.provider.rating.toStringAsFixed(1),
                          Icons.star,
                          Colors.orange),
                      Container(
                          width: 1, height: 40.h, color: Colors.grey[300]),
                      _buildStatItem(
                          'Orders'.tr(),
                          widget.provider.completedOrders.toString(),
                          Icons.check_circle,
                          const Color(0xFF52C41A)),
                      Container(
                          width: 1, height: 40.h, color: Colors.grey[300]),
                      _buildStatItem(
                          'Customers'.tr(),
                          widget.provider.uniqueClients.toString(),
                          Icons.people,
                          Colors.blue),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.h),
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Availability Status'.tr(),
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.provider.isAvailable
                            ? 'Available for new orders'.tr()
                            : 'Unavailable'.tr(),
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14.sp,
                        ),
                      ),
                      Switch(
                        value: widget.provider.isAvailable,
                        onChanged: widget.onToggleAvailability,
                        activeColor: Colors.green,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  _buildMenuItem(
                    icon: Icons.edit,
                    title: 'Edit Profile'.tr(),
                    subtitle: 'Update phone number or password'.tr(),
                    onTap: () => _showEditProfileDialog(),
                  ),
                  const Divider(height: 1),
                  _buildMenuItem(
                    icon: Icons.account_balance_wallet,
                    title: 'Payment Wallet'.tr(),
                    subtitle:
                        '\$${widget.provider.walletBalance.toStringAsFixed(2)} ${'Available'.tr()}',
                    onTap: () => _showPaymentWallet(),
                  ),
                  const Divider(height: 1),
                  _buildMenuItem(
                    icon: Icons.settings,
                    title: 'Settings'.tr(),
                    subtitle: 'App preferences and notifications'.tr(),
                    onTap: () => _showSettings(),
                  ),
                  const Divider(height: 1),
                  _buildMenuItem(
                    icon: Icons.help,
                    title: 'Help and Support'.tr(),
                    subtitle: 'Get help or contact support'.tr(),
                    onTap: () => _showHelpSupport(),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(
      String label, String value, IconData icon, Color color) {
    return Column(
      children: [
        Icon(
          icon,
          color: color,
          size: 24.sp,
        ),
        SizedBox(height: 8.h),
        Text(
          value,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF333333),
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            color: const Color(0xFF666666),
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          color: Colors.green.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Icon(icon, color: Colors.green, size: 20.sp),
      ),
      title: Text(
        title,
        style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(fontSize: 12.sp, color: Colors.grey[600]),
      ),
      trailing: Icon(Icons.arrow_forward_ios, size: 16.sp, color: Colors.grey),
      onTap: onTap,
    );
  }

  void _showEditProfileDialog() {
    final nameController = TextEditingController(text: widget.provider.name);
    final phoneController =
        TextEditingController(text: widget.provider.phoneNumber ?? '');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit Profile'.tr()),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Full Name'.tr(),
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'Phone Number'.tr(),
                border: const OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'.tr()),
          ),
          ElevatedButton(
            onPressed: () {
              widget.onUpdateProfile(nameController.text, phoneController.text);
              Navigator.pop(context);
            },
            child: Text('Save'.tr()),
          ),
        ],
      ),
    );
  }

  void _showPaymentWallet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Payment Wallet'.tr(),
              style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.green, Colors.green.shade700],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(15.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Available Balance'.tr(),
                    style: TextStyle(color: Colors.white70, fontSize: 14.sp),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    '\$${widget.provider.walletBalance.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _showWithdrawDialog,
                    icon: const Icon(Icons.download),
                    label: Text('Withdraw'.tr()),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.history),
                    label: Text('History'.tr()),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Text(
              'Recent Transactions'.tr(),
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 10.h),
            Expanded(
              child: ListView.builder(
                itemCount: widget.transactions.length,
                itemBuilder: (context, index) {
                  final transaction = widget.transactions[index];
                  final isEarning = transaction.type == 'earning';
                  return ListTile(
                    leading: Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: (isEarning ? Colors.green : Colors.red)
                            .withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        isEarning ? Icons.add : Icons.remove,
                        color: isEarning ? Colors.green : Colors.red,
                      ),
                    ),
                    title: Text(transaction.description),
                    subtitle: Text(
                      '${transaction.date.day}/${transaction.date.month}/${transaction.date.year} ${transaction.date.hour}:${transaction.date.minute.toString().padLeft(2, '0')}',
                    ),
                    trailing: Text(
                      '${isEarning ? '+' : ''}\$${transaction.amount.abs().toStringAsFixed(2)}',
                      style: TextStyle(
                        color: isEarning ? Colors.green : Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showWithdrawDialog() {
    final TextEditingController amountController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Withdraw Money'.tr()),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
                'Available Balance: \$${widget.provider.walletBalance.toStringAsFixed(2)}'),
            const SizedBox(height: 15),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Amount to withdraw'.tr(),
                border: const OutlineInputBorder(),
                prefixText: '\$',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'.tr()),
          ),
          ElevatedButton(
            onPressed: () {
              final amount = double.tryParse(amountController.text) ?? 0;
              if (amount > 0 && amount <= widget.provider.walletBalance) {
                widget.onWithdraw(amount);
                Navigator.pop(context);
                Navigator.pop(context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Invalid amount'.tr()),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            child: Text('Withdraw'.tr()),
          ),
        ],
      ),
    );
  }

  void _showSettings() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Settings screen would open here')),
    );
  }

  void _showHelpSupport() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Help & Support screen would open here')),
    );
  }
}

// Example Usage in Main
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.green,
            useMaterial3: true,
          ),
          home: child,
        );
      },
      child: const ProfileScreenDemo(),
    );
  }
}

class ProfileScreenDemo extends StatefulWidget {
  const ProfileScreenDemo({super.key});

  @override
  _ProfileScreenDemoState createState() => _ProfileScreenDemoState();
}

class _ProfileScreenDemoState extends State<ProfileScreenDemo> {
  late ServiceProvider provider;
  late List<Transaction> transactions;

  @override
  void initState() {
    super.initState();
    provider = ServiceProvider(
      name: "Hatem Nasser",
      profession: "Plumber",
      rating: 4.8,
      completedOrders: 127,
      uniqueClients: 98,
      walletBalance: 2450.50,
      phoneNumber: "01271964322",
    );

    transactions = [
      Transaction(
        id: "1",
        description: "Kitchen pipe repair",
        amount: 150.0,
        date: DateTime.now().subtract(const Duration(hours: 2)),
        type: 'earning',
        orderId: "ORD001",
      ),
      Transaction(
        id: "2",
        description: "Bank withdrawal",
        amount: -500.0,
        date: DateTime.now().subtract(const Duration(days: 3)),
        type: 'withdrawal',
      ),
      Transaction(
        id: "3",
        description: "Bathroom shower repair",
        amount: 200.0,
        date: DateTime.now().subtract(const Duration(days: 5)),
        type: 'earning',
        orderId: "ORD002",
      ),
    ];
  }

  void _updateProfile(String name, String phone) {
    setState(() {
      provider = provider.copyWith(
        name: name,
        phoneNumber: phone,
      );
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Profile updated successfully!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _toggleAvailability(bool isAvailable) {
    setState(() {
      provider = provider.copyWith(isAvailable: isAvailable);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isAvailable
              ? 'You are now available for new orders'
              : 'You are now unavailable',
        ),
        backgroundColor: isAvailable ? Colors.green : Colors.orange,
      ),
    );
  }

  void _withdrawMoney(double amount) {
    if (amount <= provider.walletBalance && amount > 0) {
      setState(() {
        provider =
            provider.copyWith(walletBalance: provider.walletBalance - amount);
        transactions.insert(
          0,
          Transaction(
            id: "T${DateTime.now().millisecondsSinceEpoch}",
            description: "Bank withdrawal",
            amount: -amount,
            date: DateTime.now(),
            type: 'withdrawal',
          ),
        );
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Withdrawal successful! \$${amount.toStringAsFixed(2)} transferred to your bank.'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FreeProfileScreen(
      provider: provider,
      transactions: transactions,
      onUpdateProfile: _updateProfile,
      onToggleAvailability: _toggleAvailability,
      onWithdraw: _withdrawMoney,
    );
  }
}

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:home_ease/core/routing/routes.dart';
import 'package:home_ease/translations/locale_keys.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:home_ease/features/free_lance_ui/profile_screen/ui/profile_screen.dart';

class ServiceProviderRegisterScreen extends StatefulWidget {
  const ServiceProviderRegisterScreen({super.key});

  @override
  _ServiceProviderRegisterScreenState createState() =>
      _ServiceProviderRegisterScreenState();
}

class _ServiceProviderRegisterScreenState
    extends State<ServiceProviderRegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final _fullNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _experienceController = TextEditingController();
  final _bioController = TextEditingController();

  String? _selectedService;
  File? _profileImage;
  File? _idCard;
  File? _license;
  bool _isLoading = false;

  final List<String> _services = [
    'Plumber',
    'Carpenter',
    'Electrician',
    'AC Maintenance',
    'Painter',
    'Cleaner',
    'Appliance Repair',
    'Handyman',
  ];

  Future<void> _pickImage(String type) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        switch (type) {
          case 'profile':
            _profileImage = File(image.path);
            break;
          case 'id':
            _idCard = File(image.path);
            break;
          case 'license':
            _license = File(image.path);
            break;
        }
      });
    }
  }

  Future<void> _submitApplication() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      await Future.delayed(const Duration(seconds: 2)); // محاكاة طلب API

      setState(() {
        _isLoading = false;
      });

      // الانتقال إلى شاشة نجاح الإرسال
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ApplicationSubmittedScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Service Provider Register".tr()),
        centerTitle: true,
        backgroundColor: const Color(0xFF4CAF50),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // الصورة الشخصية
              Center(
                child: GestureDetector(
                  onTap: () => _pickImage('profile'),
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.grey[200],
                    backgroundImage: _profileImage != null
                        ? FileImage(_profileImage!)
                        : null,
                    child: _profileImage == null
                        ? const Icon(Icons.camera_alt,
                            size: 40, color: Color(0xFF4CAF50))
                        : null,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // الاسم الكامل
              _buildTextField(
                  controller: _fullNameController,
                  label: "Name".tr(),
                  icon: Icons.person,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your full name';
                    }
                    return null;
                  }),

              const SizedBox(height: 16),

              // رقم الهاتف
              _buildTextField(
                  controller: _phoneController,
                  label: "Phone Number".tr(),
                  icon: Icons.phone,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  }),

              const SizedBox(height: 16),

              // البريد الإلكتروني
              _buildTextField(
                controller: _emailController,
                label: "Email".tr(),
                icon: Icons.email,
                keyboardType: TextInputType.emailAddress,
              ),

              const SizedBox(height: 16),

              // كلمة المرور
              _buildTextField(
                  controller: _passwordController,
                  label: "Password".tr(),
                  icon: Icons.lock,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  }),

              const SizedBox(height: 16),

              // تأكيد كلمة المرور
              _buildTextField(
                  controller: _confirmPasswordController,
                  label: "Confirm Password".tr(),
                  icon: Icons.lock_outline,
                  obscureText: true,
                  validator: (value) {
                    if (value != _passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  }),

              const SizedBox(height: 16),

              // نوع الخدمة
              DropdownButtonFormField<String>(
                value: _selectedService,
                decoration: InputDecoration(
                  labelText: "Service Type".tr(),
                  prefixIcon: const Icon(Icons.work, color: Color(0xFF4CAF50)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                items: _services
                    .map((service) => DropdownMenuItem(
                          value: service,
                          child: Text(service),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedService = value;
                  });
                },
                validator: (value) {
                  if (value == null) return 'Please select a service type';
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // سنوات الخبرة
              _buildTextField(
                controller: _experienceController,
                label: "Years of Experience".tr(),
                icon: Icons.timeline,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter years of experience';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // نبذة عن نفسك
              _buildTextField(
                controller: _bioController,
                label: "About You".tr(),
                icon: Icons.info,
                maxLines: 4,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please tell us about yourself';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 24),

              // رفع المستندات
              _buildDocumentUpload("Upload ID".tr(), Icons.credit_card, _idCard,
                  () => _pickImage('id')),

              const SizedBox(height: 12),

              _buildDocumentUpload("Upload License".tr(), Icons.description,
                  _license, () => _pickImage('license')),

              const SizedBox(height: 32),

              // زر الإرسال
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _submitApplication,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4CAF50),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text("Submit Application".tr()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 🔧 TextField Widget
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      maxLines: maxLines,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: const Color(0xFF4CAF50)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  // 🔧 رفع المستندات
  Widget _buildDocumentUpload(
      String label, IconData icon, File? file, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(
              color: file != null ? const Color(0xFF4CAF50) : Colors.grey),
          borderRadius: BorderRadius.circular(8),
          color: file != null
              ? const Color(0xFF4CAF50).withOpacity(0.1)
              : Colors.grey[100],
        ),
        child: Row(
          children: [
            Icon(icon,
                color: file != null ? const Color(0xFF4CAF50) : Colors.grey),
            const SizedBox(width: 12),
            Expanded(
              child: Text(file != null ? "File Uploaded".tr() : label),
            ),
            Icon(file != null ? Icons.check_circle : Icons.upload_file,
                color: file != null ? const Color(0xFF4CAF50) : Colors.grey),
          ],
        ),
      ),
    );
  }
}

// شاشة نجاح الإرسال
class ApplicationSubmittedScreen extends StatelessWidget {
  const ApplicationSubmittedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check_circle,
                  size: 100, color: Color(0xFF4CAF50)),
              const SizedBox(height: 24),
              Text(
                "Application Submitted".tr(),
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Navigate to the FreeProfileScreen with dummy data
                  final provider = ServiceProvider(
                    name: "Hatem Nasser",
                    profession: "Plumber",
                    rating: 4.8,
                    completedOrders: 127,
                    uniqueClients: 98,
                    walletBalance: 2450.50,
                    phoneNumber: "01271964322",
                  );

                  final transactions = [
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

                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    Routes.freeProfileScreen,
                    (route) => false,
                    arguments: {
                      'provider': provider,
                      'transactions': transactions,
                      'onUpdateProfile': (String name, String phone) {},
                      'onToggleAvailability': (bool isAvailable) {},
                      'onWithdraw': (double amount) {},
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4CAF50),
                ),
                child: const Text('Back to Home'),
              )
            ],
          ),
        ),
      ),
    );
  }
}

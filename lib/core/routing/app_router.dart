import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_ease/core/routing/routes.dart';
import 'package:home_ease/core/di/dependency_injection.dart';
import 'package:home_ease/features/home/ui/home_screen.dart';
import 'package:home_ease/features/history/history_screen.dart';
import 'package:home_ease/features/splash/ui/splash_screen.dart';
import 'package:home_ease/features/company/ui/company_screen.dart';
import 'package:home_ease/features/payment/ui/payment_screen.dart';
import 'package:home_ease/features/profile/ui/profile_screen.dart';
import 'package:home_ease/features/profile/ui/edit_profile_screen.dart';
import 'package:home_ease/features/auth/login/ui/login_screen.dart';
import 'package:home_ease/features/address/ui/address_screen.dart'; 
import 'package:home_ease/features/mywallet/ui/my_wallet_screen.dart';
import 'package:home_ease/features/categorie/ui/categories_scraan.dart';
import 'package:home_ease/features/auth/register/ui/register_screen.dart';
import 'package:home_ease/features/contact_us/ui/contact_us_screen.dart'; 
import 'package:home_ease/features/contact_us/logic/contactus_cubit.dart';
import 'package:home_ease/features/service/ui/hourly_service_screen.dart';
import 'package:home_ease/features/on_boarding/ui/on_boarding_screen.dart';
import 'package:home_ease/features/add_address/ui/add_address_screen.dart';
import 'package:home_ease/features/home_layout/ui/home_layout_scraan.dart'; 
import 'package:home_ease/features/service/service_type/service_type.dart'; 
import 'package:home_ease/features/home_layout/logic/home_layout_cubit.dart';
import 'package:home_ease/features/service/ui/contract _service_screen.dart';
import 'package:home_ease/features/notification/ui/notification_screen.dart';
import 'package:home_ease/features/categorie/data/models/category_model.dart';
import 'package:home_ease/features/resetpassword/ui/reset_password_screen.dart';
import 'package:home_ease/features/select_address/ui/select_address_screen.dart';
import 'package:home_ease/features/select_language/ui/terms_and_conditions.dart';
import 'package:home_ease/features/select_language/ui/select_language_screen.dart';
import 'package:home_ease/features/free_lance_ui/profile_screen/ui/profile_screen.dart';
import 'package:home_ease/features/free_lance_ui/auth_choice_screen/ui/auth_choices_screen.dart';
import 'package:home_ease/features/free_lance_ui/user_type_selection/ui/user_type_selection_screen.dart';
import 'package:home_ease/features/free_lance_ui/service_provider_register/ui/service_provider_register_screen.dart';
// import 'package:home_ease/features/orderdetalis/ui/order_detalis_screen.dart';
// ignore_for_file: depend_on_referenced_packages



class AppRouter {
  AppRouter();

  Route<dynamic> generateRoute(RouteSettings settings) {
    // ignore: non_constant_identifier_names

    switch (settings.name) {
      case Routes.splashScreen:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );

      case Routes.homeScreen:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        );

      case Routes.contactUsScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<ContactUsCubit>(),
            child: const ContactUS(),
          ),
        );

      case Routes.historyScreen:
        return MaterialPageRoute(
          builder: (context) => const HistoryScreen(),
        );

      case Routes.serviceType:
        final category = settings.arguments as Categories;
        return MaterialPageRoute(
          builder: (context) => ServiceType(
            category: category,
          ),
        );
 
      case Routes.selectLanguageScreen:
        return MaterialPageRoute(
          builder: (context) => const SelectLanguageScreen(),
        );
  
      case Routes.resetPasswordScreen:
        return MaterialPageRoute(
          builder: (context) => const ResetPasswordScreen(),
        );

      case Routes.notificationScreen:
        return MaterialPageRoute(
          builder: (context) => const NotificationScreen(),
        );
      case Routes.paymentScreenScreen:
        return MaterialPageRoute(
          builder: (context) => const PaymentScreen(),
        );

      case Routes.selectAddressScreen:
        return MaterialPageRoute(
          builder: (context) => const SelectAddress(),
        );
      case Routes.addAddressScreen:
        return MaterialPageRoute(
          builder: (context) => const AddAddressScreen(),
        );
      case Routes.hourlyServiceScreen:
        final category = settings.arguments as Categories;
        return MaterialPageRoute(
          builder: (context) => HourlyServiceScreen(
            category: category,
          ),
        );
      case Routes.contractServiceScreen:
        final category = settings.arguments as Categories;

        return MaterialPageRoute(
          builder: (context) => ContractServiceScreen(
            category: category,
          ),
        );

      case Routes.companyscreen:
        return MaterialPageRoute(
          builder: (context) => const CompanyScreen(),
        );
      case Routes.mywalletscreen:
        return MaterialPageRoute(
          builder: (context) => const MyWalletScreen(),
        );
      // case Routes.orderDetalisScreen:
      //   return MaterialPageRoute(
      //     // builder: (context) => const OrderDetalis(),
      //   );

      // case Routes.dashbordscreen:
      //   return MaterialPageRoute(
      //     builder: (context) => const DashBordScreen(),
      //   );

      // case Routes.addcategoriesdashbordscreen:
      //   return MaterialPageRoute(
      //     builder: (context) => const AddCategores(),
      //   );

      case Routes.forgetPasswordScreen:
        return MaterialPageRoute(
          builder: (context) => const ResetPasswordScreen(),
        );
      
      case Routes.profileScreen:
        return MaterialPageRoute(
          builder: (context) => const ProfileScreen(),
        );

      case Routes.addressScreenScreen:
        return MaterialPageRoute(
          builder: (context) => const AddressScreen(),
        );

      case Routes.editProfileScreen:
        return MaterialPageRoute(
          builder: (context) => const EditProfileScreen(),
        );
      case Routes.categoriesScreen:
        return MaterialPageRoute(
          builder: (context) => const CategoriesScreen(),
        );

          case Routes.registerScreen:
        return MaterialPageRoute(
          builder: (context) => const RegisterScreen(),
        );

           case Routes.userTypeSelectionScreen:
        return MaterialPageRoute(
          builder: (context) => const UserTypeSelectionScreen(),
        );

      case Routes.serviceProviderRegisterScreen:
        return MaterialPageRoute(
          builder: (context) => const ServiceProviderRegisterScreen(),
        );
         case Routes.freeProfileScreen:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => FreeProfileScreen(
            provider: args['provider'],
            transactions: args['transactions'],
            onUpdateProfile: args['onUpdateProfile'],
            onToggleAvailability: args['onToggleAvailability'],
            onWithdraw: args['onWithdraw'],
          ),
        );
        
      case Routes.authChoiceScreen:
        return MaterialPageRoute(
          builder: (context) => const AuthChoiceScreen(),
        );



      // case Routes.adminCategoriesScreen:
      //   return MaterialPageRoute(
      //     builder: (context) => BlocProvider(
      //       create: (context) => CategorieCubit(),
      //       child: const AdminCategoriesScreen(),
      //     ),
      //   );
      case Routes.homeLayout:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => HomeLayoutCubit(),
            child: const HomeLayoutScreen(),
          ),
        );

      case Routes.termsAndConditions:
        return MaterialPageRoute(
          builder: (context) => const TermsAndConditions(),
        );
        case Routes.onBoardingScreen:
        return MaterialPageRoute(
          builder: (context) => const OnBoardingScreen(),
        );
         case Routes.loginScreen:
        return MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}

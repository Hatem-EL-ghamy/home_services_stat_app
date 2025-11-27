import 'package:get_it/get_it.dart'; 
import 'package:home_ease/features/home/logic/home_cubit.dart';
import 'package:home_ease/features/service/logic/company_cubit.dart';
import 'package:home_ease/features/categorie/logic/categorie_cubit.dart';
import 'package:home_ease/features/contact_us/logic/contactus_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  // //login
  // getIt.registerFactory<LoginCubit>(() => LoginCubit());

  // //Register
  // getIt.registerFactory<RegisterCubit>(() => RegisterCubit());

  getIt.registerFactory<HomeCubit>(() => HomeCubit());

  getIt.registerFactory<CategoryCubit>(() => CategoryCubit());

  getIt.registerFactory<ContactUsCubit>(() => ContactUsCubit());

  getIt.registerFactory<CompanyCubit>(() => CompanyCubit());

  // getIt.registerFactory<ResetpasswordCubit>(() => ResetpasswordCubit(getIt()));

  // getIt.registerFactory<ProfileCubit>(() => ProfileCubit(getIt()));
}

// ignore_for_file: non_constant_identifier_names

import 'package:bloc/bloc.dart';
import 'package:home_ease/core/networking/local/cache_helper.dart';
import 'package:home_ease/features/service/logic/company_state.dart';
import 'package:home_ease/features/service/data/models/product_company.dart';
import 'package:home_ease/features/service/data/models/order_response.dart';

class CompanyCubit extends Cubit<CompanyState> {
  CompanyCubit() : super(const CompanyState.initial());

  int? companyId;
  int? companyIdHourly;

  List contractCompanies = [];
  
  // Static contract companies data
  static final List<Companies> _staticContractCompanies = [
    Companies(
      id: '1',
      name: 'Premium Cleaning Service',
      image: 'assets/images/company1.png',
      description: 'Professional cleaning service',
      path: 'assets/images/company1.png',
      price: '500',
      nationality: 'Egyptian',
      numbers: '10',
    ),
    Companies(
      id: '2',
      name: 'Expert Plumbing Co.',
      image: 'assets/images/company2.png',
      description: '24/7 plumbing services',
      path: 'assets/images/company2.png',
      price: '300',
      nationality: 'Egyptian',
      numbers: '8',
    ),
    Companies(
      id: '3',
      name: 'Electric Solutions',
      image: 'assets/images/company3.png',
      description: 'Certified electricians',
      path: 'assets/images/company3.png',
      price: '400',
      nationality: 'Egyptian',
      numbers: '12',
    ),
  ];
  
  Future<void> emitGetContractAllCompaniesStates() async {
    emit(const CompanyState.getContractAllCompaniesLoading());

    // Static data - simulate API call
    await Future.delayed(const Duration(seconds: 1));
    
    contractCompanies = _staticContractCompanies;
    final companyModel = ProductCompanyModel(companies: _staticContractCompanies);
    emit(CompanyState.getContractAllCompaniesSuccess(companyModel));
  }

  List hourlyCompanies = [];

  // Static hourly companies data
  static final List<Companies> _staticHourlyCompanies = [
    Companies(
      id: '4',
      name: 'Quick Clean',
      image: 'assets/images/company4.png',
      description: 'Hourly cleaning service',
      path: 'assets/images/company4.png',
      price: '50',
      nationality: 'Egyptian',
      numbers: '15',
    ),
    Companies(
      id: '5',
      name: 'Fast Plumbing',
      image: 'assets/images/company5.png',
      description: 'On-demand plumbing',
      path: 'assets/images/company5.png',
      price: '80',
      nationality: 'Egyptian',
      numbers: '6',
    ),
  ];

  Future<void> emitGetHourlyAllCompaniesStates() async {
    emit(const CompanyState.getHourlyAllCompaniesLoading());

    // Static data - simulate API call
    await Future.delayed(const Duration(seconds: 1));
    
    hourlyCompanies = _staticHourlyCompanies;
    final companyModel = ProductCompanyModel(companies: _staticHourlyCompanies);
    emit(CompanyState.getHourlyAllCompaniesSuccess(companyModel));
  }

  var token = CacheHelper.getData(key: 'token');

  Future<void> orderContractAllCompanies({
    String? numberOfMonths,
    String? city,
    String? address,
    String? nationality,
    String? companyId,
    String? categorieId,
    DateTime? date,
  }) async {
    emit(const CompanyState.orderContractAllCompaniesLoading());

    // Static data - simulate API call
    await Future.delayed(const Duration(seconds: 1));
    
    // Mock static response
    final mockResponse = OrderResponse(
      message: 'Contract order placed successfully',
      status: 200,
      orderData: {
        'orderId': 'ORD_${DateTime.now().millisecondsSinceEpoch}',
        'companyId': companyId,
        'numberOfMonths': numberOfMonths,
        'city': city,
        'address': address,
      },
    );
    
    emit(CompanyState.orderContractAllCompaniesSuccess(mockResponse));
  }

  Future<void> orderHourlyAllCompanies({
    String? numberOfHours,
    String? city,
    String? address,
    String? nationality,
    String? companyId,
    String? categorieId,
    DateTime? date,
    String? period,
    String? time,
  }) async {
    emit(const CompanyState.orderHourlyAllCompaniesLoading());

    // Static data - simulate API call
    await Future.delayed(const Duration(seconds: 1));
    
    // Mock static response
    final mockResponse = OrderResponse(
      message: 'Hourly order placed successfully',
      status: 200,
      orderData: {
        'orderId': 'ORD_${DateTime.now().millisecondsSinceEpoch}',
        'companyId': companyId,
        'numberOfHours': numberOfHours,
        'city': city,
        'address': address,
        'date': date?.toString(),
        'period': period,
        'time': time,
      },
    );
    
    emit(CompanyState.orderHourlyAllCompaniesSuccess(mockResponse));
  }
}

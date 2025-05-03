// ignore_for_file: non_constant_identifier_names

import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:home_ease/core/networking/local/cache_helper.dart';
import 'package:home_ease/features/service/data/models/contract_order_model.dart';
import 'package:home_ease/features/service/data/models/hourly_order_model.dart';
import 'package:home_ease/features/service/data/repo/company_repo.dart';

import 'package:home_ease/features/service/logic/company_state.dart';

class CompanyCubit extends Cubit<CompanyState> {
  CompanyCubit(this._CompanyRepo) : super(const CompanyState.initial());

  final CompanyRepo _CompanyRepo;

  int? companyId;


  int? companyIdHourly;
  // int index=-1;

  List contractCompanies = [];
  Future<void> emitGetContractAllCompaniesStates() async {
    emit(const CompanyState.getContractAllCompaniesLoading());

    final response = await _CompanyRepo.getContractAllCompanies();
    response.when(success: (response) {
      // companyId = response.companies![index].id!;
      log(response.toString());
      contractCompanies = response.companies!;
      emit(CompanyState.getContractAllCompaniesSuccess(response));
    }, failure: (error) {
      emit(CompanyState.getContractAllCompaniesError(
          error: error.apiErrorModel.message ?? ''));
    });
  }

  List hourlyCompanies = [];

  Future<void> emitGetHourlyAllCompaniesStates() async {
    emit(const CompanyState.getHourlyAllCompaniesLoading());

    final response = await _CompanyRepo.getHourlyAllCompanies();
    response.when(success: (response) {
      log(response.toString());
      hourlyCompanies = response.companies!;
      emit(CompanyState.getHourlyAllCompaniesSuccess(response));
    }, failure: (error) {
      emit(CompanyState.getHourlyAllCompaniesError(
          error: error.apiErrorModel.message ?? ''));
    });
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

    final response = await _CompanyRepo.contractOrderAllCompanies(
      token: "Bearer $token",
      contractOrder: ContractOrder(
        address: address,
        companyId: companyId,
        date: date,
        nationality: nationality,
        numberOfMonths: numberOfMonths,
        city: city,
        categorieId: categorieId,
      ),
    );
    response.when(success: (response) {
      log(response.toString());

      emit(CompanyState.orderContractAllCompaniesSuccess(response));
    }, failure: (error) {
      emit(CompanyState.orderContractAllCompaniesError(
          error: error.apiErrorModel.message ?? ''));
    });
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

    final response = await _CompanyRepo.hourlyOrderAllCompanies(
      token: "Bearer $token",
      hourlyOrder: HourlyOrder(
        address: address,
        companyId: companyId,
        date: date,
        nationality: nationality,
        city: city,
        categorieId: categorieId,
        numberOfHours: numberOfHours,
        period: period,
        time: time,
      ),
    );
    response.when(success: (response) {
      log(response.toString());

      emit(CompanyState.orderHourlyAllCompaniesSuccess(response));
    }, failure: (error) {
      emit(CompanyState.orderHourlyAllCompaniesError(
          error: error.apiErrorModel.message ?? ''));
    });
  }
}

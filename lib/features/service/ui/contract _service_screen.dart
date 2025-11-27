// ignore_for_file: unused_element, unrelated_type_equality_checks, library_private_types_in_public_api, depend_on_referenced_packages, unnecessary_import, override_on_non_overriding_member

import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_ease/core/di/dependency_injection.dart';
import 'package:home_ease/core/helpers/app_regex.dart';
import 'package:home_ease/core/helpers/constants.dart';
import 'package:home_ease/core/helpers/navigation_extensions.dart';
import 'package:home_ease/core/networking/local/cache_helper.dart';
import 'package:home_ease/core/routing/routes.dart';
import 'package:home_ease/core/theming/colors.dart';
import 'package:home_ease/core/theming/text_styles%20.dart';
import 'package:home_ease/core/widgets/custom_button.dart';
import 'package:home_ease/core/widgets/setup_error_state.dart';
import 'package:home_ease/core/widgets/show_progress_indicator.dart';
import 'package:home_ease/features/categorie/data/models/category_model.dart';
import 'package:home_ease/features/service/logic/company_cubit.dart';
import 'package:home_ease/features/service/logic/company_state.dart';
import 'package:home_ease/features/service/ui/widget/contract _service/container_step.3.dart';
import 'package:home_ease/features/service/ui/widget/contract _service/container_step_2.dart';
import 'package:home_ease/features/service/ui/widget/contract _service/containet_step_1.dart';

class ContractServiceScreen extends StatefulWidget {
  final Categories? category;

  const ContractServiceScreen({key, required this.category}) : super(key: key);

  @override
  _HourlyCleaningScreen createState() => _HourlyCleaningScreen();
}

class _HourlyCleaningScreen extends State<ContractServiceScreen> {
  late CompanyCubit _companyCubit;

  @override
  void initState() {
    super.initState();
    _companyCubit = getIt<CompanyCubit>();
    _companyCubit.emitGetContractAllCompaniesStates();
  }

  @override
  void dispose() {
    _companyCubit.close();
    super.dispose();
  }

  int _currentStep = 0;
  bool isCompleted = false; //check completeness of inputs
  final formKey =
      GlobalKey<FormState>(); //form object to be used for form validation

  final numberOfMonths = TextEditingController();

  final nationality = TextEditingController();

  final city = TextEditingController();

  final address = TextEditingController();

  DateTime? selectedDate = DateTime.now();

  @override
  void _goToNextStep() {
    final isLastStep = _currentStep == _mySteps().length - 1;
    formKey.currentState!.validate();
    bool isDetailValid =
        isDetailComplete(); //this check if ok to move on to next screen

    if (isDetailValid) {
      if (isLastStep) {
        setState(() {
          isCompleted = true;
          _companyCubit.orderContractAllCompanies(
            city: city.text,
            address: address.text,
            nationality: nationality.text,
            numberOfMonths: numberOfMonths.text,
            categorieId: widget.category!.id.toString(),
            companyId: _companyCubit.companyId.toString(),
            date: selectedDate,
          );
        });
      } else {
        setState(() {
          _currentStep += 1;
        });
      }
    }
  }

  void _goToPreviousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep -= 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _companyCubit,
      child: BlocListener<CompanyCubit, CompanyState>(
        listenWhen: (previous, current) =>
            current is OrderContractAllCompaniesLoading ||
            current is OrderContractAllCompaniesSuccess ||
            current is OrderContractAllCompaniesError,
        listener: (context, state) {
          state.whenOrNull(orderContractAllCompaniesSuccess: (response) {
            context.pop();
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                icon: const Icon(
                  Icons.check_circle_sharp,
                  color: Colors.green,
                  size: 50,
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Your request is under review",
                      style: TextStyles.font18Black700,
                    ),
                    Text(
                      " A confirmation message will be sent when your offer is accepted by the company",
                      style: TextStyles.font14Bgray500,
                    ),
                  ],
                ),
                actions: [
                  CustomButton(
                    onPressed: () {
                      context.pushReplacementNamed(Routes.homeLayout);
                    },
                    text: 'Go Home',
                  ),
                ],
              ),
            );
          }, orderContractAllCompaniesError: (error) {
            log(error.toString());
            setupErrorState(context, error);
          }, orderContractAllCompaniesLoading: () {
            showProgressIndicator(context);
          });
        },
        child: Scaffold(
          backgroundColor: ColorsApp.lightGreen,
          appBar: AppBar(
            backgroundColor: ColorsApp.white,
          ),
          body: Theme(
            data: Theme.of(context).copyWith(
                colorScheme:
                    const ColorScheme.light(primary: ColorsApp.mainGreen)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 24.w, right: 20),
                  child: Container(
                    color: ColorsApp.white,
                    child: Row(
                      children: [
                        Text(
                          '${widget.category!.name}'.tr(),
                          style: TextStyles.font24mainGreen700,
                        ),
                        const Spacer(),
                        Image.network(
                          '$serverPhotoURL/${widget.category!.path}',
                          width: 100,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Form(
                    key: formKey,
                    child: Stepper(
                      elevation: 0,
                      type: StepperType.horizontal,
                      steps: _mySteps(),
                      currentStep: _currentStep,
                      onStepTapped: (step) {
                        formKey.currentState!
                            .validate(); //this will trigger validation
                        setState(() {
                          _currentStep = step;
                        });
                      },
                      onStepContinue: () {
                        setState(
                          () {
                            _goToNextStep();
                          },
                        );
                      },
                      onStepCancel: () {
                        setState(() {
                          _goToPreviousStep();
                        });
                      },
                      controlsBuilder: (BuildContext context,
                          ControlsDetails controlsDetails) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 20.h),
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              if (_currentStep >= 1)
                                Expanded(
                                  child: CustomButton(
                                    text: 'Back'.tr(),
                                    onPressed: _goToPreviousStep,
                                  ),
                                ),
                              SizedBox(width: 10.w),
                              Expanded(
                                child: CustomButton(
                                  onPressed: _goToNextStep,
                                  text: 'Next'.tr(),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool isDetailComplete() {
    if (_currentStep == 0) {
      //check sender fields
      if (numberOfMonths.text.isEmpty ||
          nationality.text.isEmpty ||
          city.text.isEmpty ||
          city.text.length < 3 ||
          nationality.text.length < 3 ||
          AppRegex.isText(nationality.text) == false ||
          AppRegex.isText(city.text) == false ||
          AppRegex.hasNumber(numberOfMonths.text) == false) {
        return false;
      } else {
        return true; //if all fields are not empty
      }
    } else if (_currentStep == 1) {
      if (CacheHelper.getData(key: "selectIndex") < 0) {
        return false;
      }
      //check receiver fields
      // if (receiverName.text.isEmpty || receiverAddress.text.isEmpty) {
      //   return false;
      else {
        return true;
      }
    } else if (_currentStep == 2) {
      //check receiver fields
      if (address.text.isEmpty ||
          address.text.length < 3 ||
          AppRegex.isText(address.text) == false) {
        return false;
      } else {
        return true;
      }
    }
    return false;
  }

  List<Step> _mySteps() {
    List<Step> steps = [
      Step(
        title: Text(
          'Step 1'.tr(),
          style: TextStyles.font12mainGreen700,
        ),
        content: ContainerStepOneContractService(
          numberOfMonths: numberOfMonths,
          City: city,
          Nationality: nationality,
        ),
        isActive: _currentStep >= 0,
        state: _currentStep >= 0 ? StepState.indexed : StepState.disabled,
      ),
      Step(
        title: Text(
          'Step 2'.tr(),
          style: TextStyles.font12mainGreen700,
        ),
        content: ContainerStepTowContractService(),
        isActive: _currentStep >= 1,
      ),
      Step(
        title: Text(
          'Step 3'.tr(),
          style: TextStyles.font12mainGreen700,
        ),
        content: ContainerStepThreeContractService(
          selectedDate: selectedDate,
          address: address,
        ),
        isActive: _currentStep >= 2,
      ),
    ];
    return steps;
  }
}

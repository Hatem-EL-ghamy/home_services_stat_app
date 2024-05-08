// ignore_for_file: unused_local_variable, non_constant_identifier_names, unnecessary_string_interpolations

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_ease/core/networking/local/cache_helper.dart';
import 'package:home_ease/core/theming/colors.dart';
import 'package:home_ease/core/theming/text_styles%20.dart';
import 'package:home_ease/features/service/logic/company_cubit.dart';
import 'package:home_ease/features/service/logic/company_state.dart';
import 'package:home_ease/features/service/ui/widget/card_detils_step2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContainerStepTowContractService extends StatefulWidget {
 
  ContainerStepTowContractService({
    super.key,
    

  });

  @override
  State<ContainerStepTowContractService> createState() =>
      _ContainerStepTowContractServiceState();
}

class _ContainerStepTowContractServiceState
    extends State<ContainerStepTowContractService> {

        int selectIndex=-1;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompanyCubit, CompanyState>(
      builder: (context, state) {
        var contractCompanies =
            BlocProvider.of<CompanyCubit>(context).contractCompanies;

   var cuibt =
            BlocProvider.of<CompanyCubit>(context);
           
           

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Fliter'.tr(), style: TextStyles.font16Black700),
            SizedBox(height: 8.h),
            SizedBox(
              height: 28.h,
            ),
            if (state is GetContractAllCompaniesLoading)
              const Center(
                  child: CircularProgressIndicator(
                color: ColorsApp.mainGreen,
              )),
            if (state is GetContractAllCompaniesSuccess)
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (itemBuilder, index) {
                  return CardDetails(
                    onTap: () {
                      setState(() {
                        selectIndex = index;

                        CacheHelper.saveData(
                            key: "selectIndex",
                            value: selectIndex);

                      
                        cuibt.companyId = contractCompanies[index].id!;

                         CacheHelper.saveData(
                            key: "contractCompanyId",
                            value: contractCompanies[index].id.toString());

                        log("id++++++++++${cuibt.companyId.toString()}");

                     
                      });
                    },
                    width: selectIndex == index ? 2.0 : 1.0,
                    color: selectIndex == index
                        ? ColorsApp.mainGreen
                        : Colors.grey,
                    type: "Months",
                    companies: contractCompanies[index],
                  );
                },
                separatorBuilder: (separatorBuilder, index) {
                  return SizedBox(
                    height: 18.h,
                  );
                },
                itemCount: contractCompanies.length,
              ),
            SizedBox(
              height: 40.h,
            ),
          ],
        );
      },
    );
  }
}

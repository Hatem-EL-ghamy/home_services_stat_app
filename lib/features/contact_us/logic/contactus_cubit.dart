import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_ease/core/networking/local/cache_helper.dart';
import 'package:home_ease/features/contact_us/logic/contactus_state.dart';
import 'package:home_ease/features/contact_us/data/models/contact_us_response.dart';

class ContactUsCubit extends Cubit<ContactUsState> {
  ContactUsCubit() : super(const ContactUsState.initial());

  final formKey = GlobalKey<FormState>();
  TextEditingController messageController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  TextEditingController phoneController = TextEditingController();
  
  var token = CacheHelper.getData(key: 'token');

  Future<void> emitSentMassageStates() async {
    emit(const ContactUsState.loading());

    // Static data - simulate API call
    await Future.delayed(const Duration(seconds: 1));
    
    // Mock static response
    final mockResponse = ContactUsResponse(
      message: 'Message sent successfully',
      status: 200,
    );
    
    emit(ContactUsState.sentMassageSuccess(mockResponse));
  }
}

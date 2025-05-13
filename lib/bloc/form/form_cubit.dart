import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/form_data.dart';
import 'form_state.dart';

class FormCubit extends Cubit<FormState> {
  FormCubit() : super(FormInitial());
  
  void resetForm() {
    emit(FormInitial());
  }
  
  void submitForm(String name, String email) {
    String? nameError;
    if (name.isEmpty) {
      nameError = "Nama tidak boleh kosong";
    }
    
    String? emailError;
    if (email.isEmpty) {
      emailError = "Email tidak boleh kosong";
    } else if (!isValidEmail(email)) {
      emailError = "Email harus valid";
    }
    
    if (nameError != null || emailError != null) {
      emit(FormInvalid(nameError: nameError, emailError: emailError));
    } else {
      emit(FormSubmitted(FormData(name: name, email: email)));
    }
  }

   bool isValidEmail(String email) {
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegExp.hasMatch(email);
  }
  
 
}
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
      nameError = "Name cannot be empty";
    }
    
    String? emailError;
    if (email.isEmpty) {
      emailError = "Email cannot be empty";
    }
    
    if (nameError != null || emailError != null) {
      emit(FormInvalid(nameError: nameError, emailError: emailError));
    } else {
      emit(FormSubmitted(FormData(name: name, email: email)));
    }
  }
  
 
}
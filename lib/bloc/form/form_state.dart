import 'package:equatable/equatable.dart';
import '../../models/form_data.dart';

abstract class FormState extends Equatable {
  const FormState();
  
  @override
  List<Object?> get props => [];
}

class FormInitial extends FormState {}

class FormInvalid extends FormState {
  final String? nameError;
  final String? emailError;
  
  const FormInvalid({
    this.nameError, 
    this.emailError,
  });
  
  @override
  List<Object?> get props => [nameError, emailError];
}

class FormSubmitted extends FormState {
  final FormData formData;
  
  const FormSubmitted(this.formData);
  
  @override
  List<Object> get props => [formData];
}
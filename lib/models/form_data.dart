import 'package:equatable/equatable.dart';

class FormData extends Equatable {
  final String name;
  final String email;
  
  const FormData({
    required this.name,
    required this.email,
  });
  
  @override
  List<Object> get props => [name, email];
}
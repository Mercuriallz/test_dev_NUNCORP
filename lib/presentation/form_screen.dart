import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_mobile_dev/bloc/form/form_cubit.dart';
import 'package:test_mobile_dev/bloc/form/form_state.dart' as form;

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Validasi Form"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<FormCubit, form.FormState>(
          listener: (context, state) {
            if (state is form.FormSubmitted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Form berhasil terkirim"),
                  backgroundColor: Colors.green,
                ),
              );
            }
          },
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: "Nama Lengkap *",
                    errorText: state is form.FormInvalid ? state.nameError : null,
                  ),
                ),
                const SizedBox(height: 16),
                
                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "Email *",
                    errorText: state is form.FormInvalid ? state.emailError : null,
                  ),
                ),
                const SizedBox(height: 24),
                
                ElevatedButton(
                  onPressed: () {
                    context.read<FormCubit>().submitForm(
                      nameController.text,
                      emailController.text,
                    );
                  },
                  child: const Text("Kirim / Submit"),
                ),
                
                const SizedBox(height: 24),
                
                if (state is form.FormSubmitted) ...[
                  const Divider(),
                  const Text(
                    "Data yang di submit",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text("Name: ${state.formData.name}"),
                  Text("Email: ${state.formData.email}"),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      nameController.clear();
                      emailController.clear();
                      context.read<FormCubit>().resetForm();
                    },
                    child: const Text("Reset Form"),
                  ),
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}
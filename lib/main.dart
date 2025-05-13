import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_mobile_dev/bloc/counter/counter_cubit.dart';
import 'package:test_mobile_dev/bloc/form/form_cubit.dart';
import 'package:test_mobile_dev/bloc/post/post_cubit.dart';
import 'package:test_mobile_dev/presentation/counter_screen.dart';
import 'package:test_mobile_dev/presentation/form_screen.dart';
import 'package:test_mobile_dev/presentation/post_list_screen.dart';
import 'package:test_mobile_dev/repository/post_repo.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Test App',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Test Flutter Dev"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 24),
            buildNavigationButton(
              context,
              "Soal 1: Daftar Post dari API",
              () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider(
                    create: (_) => PostCubit(repository: PostRepository()),
                    child: const PostListScreen(),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            buildNavigationButton(
              context,
              "Soal 2: Validasi form",
              () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider(
                    create: (_) => FormCubit(),
                    child: const FormScreen(),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            buildNavigationButton(
              context,
              "Soal 3: Hitungan / Counter",
              () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider(
                    create: (_) => CounterCubit(),
                    child: const CounterScreen(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildNavigationButton(
    BuildContext context,
    String title,
    VoidCallback onPressed,
  ) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
      child: Text(
        title,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}

// saya menggunakan equable untuk penyederhanaan proses perbandingan objek dalam dart nya
// saya menggunakan shared_preferences untuk menyimpan data kecil di device menggunakan key_value sebagai pairing data
// bisa juga menggunakan flutter_secure_storage sebagai pengganti shared_preferences untuk menyimpan data kecil 
// tetapi memiliki kekurangan performa dikarenakan encrypt data tetapi lebih aman dibanding shared preferences

// Terima Kasih 
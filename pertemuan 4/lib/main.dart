import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'widgets/app_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Profile Card',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme, // penerapan tema
      home: const ProfilePage(),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Personal Profile Card')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Card(
            // Rounded card = 8 + 0 = 8
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              // Padding card = 16 + 0 = 16
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Ukuran avatar = 40 + (2 x 0) = 40 (diameter)
                  // CircleAvatar memakai radius, jadi radius = 40 / 2 = 20
                  const Center(
                    child: CircleAvatar(
                      radius: 20,
                      child: Icon(Icons.person),
                    ),
                  ),
                  const SizedBox(height: 16),

                  const Text('Pramudya Swanarta Angga Buana Soti'),

                  // Jarak nama dan NIM = 8 + 0 = 8
                  const SizedBox(height: 8),

                  const Text('NIM: 20240801020'),
                  const SizedBox(height: 16),

                  const Text('Program Studi: Tehnik Informatika'),
                  const SizedBox(height: 16),

                  const Text(
                    'Mahasiswa Teknik Informatika yang sedang belajar '
                    'pengembangan aplikasi mobile dengan Flutter.',
                  ),
                  const SizedBox(height: 16),

                  // Tinggi tombol = 40 + 0 = 40
                  // Rounded tombol = 4 + 0 = 4
                  const AppButton(
                    label: 'Kunjungi GitHub Saya',
                    icon: Icons.code,
                    url: 'https://github.com/PramudyaAngga',
                    height: 40,
                    borderRadius: 4,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

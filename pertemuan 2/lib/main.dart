import 'package:flutter/material.dart';
import 'profile_card.dart'; // Ini penting buat manggil file yang lu bikin di Langkah 1

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // NIM Asli Lu
    const String myNim = "20240801020";
    int lastDigit = int.parse(myNim.substring(myNim.length - 1));

    // Logika warna Ganjil/Genap (0 itu genap, jadi akan masuk ke amber[100])
    Color bgColor = (lastDigit % 2 == 0)
        ? Colors.amber[100]! // Genap
        : Colors.tealAccent[100]!; // Ganjil

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tugas Layout Flutter',
      theme: ThemeData(
        scaffoldBackgroundColor:
            bgColor, // Set background dari perhitungan di atas
      ),
      home: const HomePage(nim: myNim),
    );
  }
}

class HomePage extends StatelessWidget {
  final String nim;
  const HomePage({super.key, required this.nim});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Scaffold nggak butuh AppBar atau BottomNav lagi sesuai soal
      body: Center(
        // Menampilkan Kartu persis di tengah layar
        child: ProfileCard(
          nama: "Pramudya Swanarta Angga Buana Soti",
          nim: nim,
          hobi: "Programming & Bisnis Sepatu",
          skorAktivitas: 0,
        ),
      ),
    );
  }
}

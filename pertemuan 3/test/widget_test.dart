import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:pertemuan_3_pemob/main.dart';
import 'package:pertemuan_3_pemob/profile_card.dart';

void main() {
  testWidgets('HomePage menampilkan ProfileCard dengan data praktikan',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.byType(ProfileCard), findsOneWidget);
    expect(find.text('Pramudya Swanarta Angga Buana Soti'), findsOneWidget);
    expect(find.text('20240801020'), findsOneWidget);
    expect(find.text('Kartu Praktikan'), findsOneWidget);
  });

  testWidgets('Skor aktivitas dihitung dari NIM (20 + 50 = 70)',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: Center(
          child: ProfileCard(
            nama: 'Pramudya Swanarta Angga Buana Soti',
            nim: '20240801020',
            hobi: 'Programming & Bisnis Sepatu',
            skorAktivitas: 0,
          ),
        ),
      ),
    ));

    expect(find.text('Skor Aktivitas'), findsOneWidget);
    expect(find.text('70'), findsOneWidget);
  });

  testWidgets('Lebar kartu = 330.0 dari digit ke-2 NIM',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: Center(
          child: ProfileCard(
            nama: 'Pramudya',
            nim: '20240801020',
            hobi: 'Coding',
            skorAktivitas: 0,
          ),
        ),
      ),
    ));

    // Container terluar ProfileCard memakai lebar hasil formula.
    final container = tester.widget<Container>(
      find.descendant(
        of: find.byType(ProfileCard),
        matching: find.byType(Container),
      ).first,
    );
    expect(container.constraints?.maxWidth, 330.0);
  });
}

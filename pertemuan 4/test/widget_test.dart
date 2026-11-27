import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:pertemuan_4_pemob/main.dart';
import 'package:pertemuan_4_pemob/theme/app_theme.dart';
import 'package:pertemuan_4_pemob/widgets/app_button.dart';

void main() {
  testWidgets('ProfilePage menampilkan identitas praktikan',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Personal Profile Card'), findsOneWidget);
    expect(find.text('Pramudya Swanarta Angga Buana Soti'), findsOneWidget);
    expect(find.text('NIM: 20240801020'), findsOneWidget);
    expect(find.textContaining('Program Studi'), findsOneWidget);
  });

  testWidgets('AppButton tampil dengan label dan ikon yang benar',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: AppButton(
          label: 'Kunjungi GitHub Saya',
          icon: Icons.code,
          url: 'https://github.com/PramudyaAngga',
          height: 40,
          borderRadius: 4,
        ),
      ),
    ));

    expect(find.text('Kunjungi GitHub Saya'), findsOneWidget);
    expect(find.byIcon(Icons.code), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);
  });

  testWidgets('Tinggi AppButton sesuai parameter', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: Center(
          child: AppButton(
            label: 'Test',
            icon: Icons.link,
            url: 'https://example.com',
            height: 40,
            borderRadius: 4,
          ),
        ),
      ),
    ));

    final box = tester.getSize(find.byType(AppButton));
    expect(box.height, 40);
  });

  test('AppTheme memakai Material 3', () {
    expect(AppTheme.lightTheme.useMaterial3, isTrue);
  });
}

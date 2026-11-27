import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pertemuan_8/main.dart';
import 'package:pertemuan_8/models/user.dart';

Future<Finder> showUserList(WidgetTester tester) async {
  await tester.pumpWidget(MaterialApp(
    home: Scaffold(
      body: UserList(
        future: Future.value(const [
          User(
              id: 1,
              name: 'Alya Sari',
              email: 'alya@example.com',
              city: 'Bandung'),
          User(
              id: 12,
              name: 'Bima Putra',
              email: 'bima@example.com',
              city: 'Jakarta'),
        ]),
        onDetail: (_) async {},
        onUpdate: (_) async {},
        onPatch: (_) async {},
        onDelete: (_) async {},
      ),
    ),
  ));
  await tester.pumpAndSettle();
  return find.byType(TextField);
}

void main() {
  testWidgets('Cari lewat nama, email, kota, atau ID', (tester) async {
    final field = await showUserList(tester);
    expect(find.text('Alya Sari'), findsOneWidget);
    expect(find.text('Bima Putra'), findsOneWidget);

    for (final query in ['  ALYA  ', 'ALYA@', 'bandung', '1']) {
      await tester.enterText(field, query);
      await tester.pumpAndSettle();
      expect(find.text('Alya Sari'), findsOneWidget, reason: query);
      expect(find.text('Bima Putra'), findsNothing, reason: query);
    }
  });

  testWidgets('Pencarian kosong hasil bisa dibersihkan', (tester) async {
    final field = await showUserList(tester);
    await tester.enterText(field, 'tidak-ada');
    await tester.pumpAndSettle();
    expect(find.text('User tidak ditemukan'), findsOneWidget);
    expect(find.text('Alya Sari'), findsNothing);
    expect(find.text('Bima Putra'), findsNothing);

    await tester.tap(find.byTooltip('Hapus pencarian'));
    await tester.pumpAndSettle();
    expect(find.text('User tidak ditemukan'), findsNothing);
    expect(find.text('Alya Sari'), findsOneWidget);
    expect(find.text('Bima Putra'), findsOneWidget);
  });
}

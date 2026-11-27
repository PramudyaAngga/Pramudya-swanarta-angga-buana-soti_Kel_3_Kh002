import 'package:flutter_test/flutter_test.dart';

import 'package:pertemuan_8/models/admin.dart';
import 'package:pertemuan_8/models/user.dart';

void main() {
  test('Model User mengonversi JSON dengan benar', () {
    final user = User.fromJson({
      'id': 1501,
      'name': 'Pramudya',
      'email': 'pramudya@example.com',
      'address': {'city': 'Jakarta'},
    });

    expect(user.id, 1501);
    expect(user.name, 'Pramudya');
    expect(user.city, 'Jakarta');
  });

  test('Model Admin mengonversi company menjadi department', () {
    final admin = Admin.fromJson({
      'id': 794,
      'name': 'Admin Demo',
      'email': 'admin@example.com',
      'company': {'name': 'IT Department'},
    });

    expect(admin.id, 794);
    expect(admin.department, 'IT Department');
  });
}

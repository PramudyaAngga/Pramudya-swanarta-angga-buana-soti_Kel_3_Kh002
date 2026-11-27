# Pertemuan 8 — CRUD API (User & Admin) dengan Flutter

Nama: **Pramudya Swanarta Angga Buana Soti** — NIM: **20240801020**

## Isi folder

| Item | Keterangan |
|---|---|
| `Laporan_Praktikum_Pemob_Pertemuan_8_20240801020.pdf` | Laporan praktikum (versi PDF) |
| `Laporan_Praktikum_Pemob_Pertemuan_8_20240801020.docx` | Laporan versi Word (bisa diedit) |
| `lib/main.dart` | `CrudApiApp` → `HomePage`, list user & admin |
| `lib/models/user.dart`, `lib/models/admin.dart` | Model + `fromJson` |
| `lib/services/user_service.dart`, `lib/services/admin_service.dart` | HTTP client, hit `jsonplaceholder.typicode.com` |
| `test/user_search_test.dart`, `test/widget_test.dart` | Unit & widget test |
| `pubspec.yaml` | `name: pertemuan_8`, dependency `http` |

## ID dari NIM

```dart
const int userIdFromNim = 1501;   // 1500 + NIM dua digit terakhir (20) → dicocokkan ke ID API
const int adminIdFromNim = 794;
```

## Cara jalanin

```bash
flutter pub get
flutter run
```

Butuh koneksi internet — datanya diambil live dari `https://jsonplaceholder.typicode.com`.

## Test

```bash
flutter test
```

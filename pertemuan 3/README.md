# Pertemuan 3 — Layout Flutter & Profile Card Berbasis NIM

Nama: **Pramudya Swanarta Angga Buana Soti** — NIM: **20240801020**

## Isi folder

| Item | Keterangan |
|---|---|
| `Laporan_Praktikum_Pemob_Pertemuan_3_20240801020.pdf` | Laporan praktikum (analisis widget + implementasi) |
| `lib/main.dart` | Entry point, atur `scaffoldBackgroundColor` dari digit terakhir NIM |
| `lib/profile_card.dart` | Widget `ProfileCard` — semua ukuran dihitung dari digit NIM |
| `android/ ios/ linux/ macos/ web/ windows/` | Platform folder Flutter |
| `pubspec.yaml` | `name: pertemuan_3_pemob` |

## Rumus yang dipakai (NIM 20240801020)

Digit terakhir = **0**, digit ke-2 dari belakang = **2**, 2 digit terakhir = **20**.

| Properti | Formula | Hasil |
|---|---|---|
| `Container.width` | 320.0 + (digit ke-2 × 5) | **330.0** |
| `BorderRadius.circular` | 12.0 + (digit terakhir × 1.5) | **12.0** |
| `FlutterLogo.size` | 60.0 + (digit terakhir × 2) | **60.0** |
| `SizedBox.width` | 15.0 + digit terakhir | **15.0** |
| `skorAktivitas` | 2 digit terakhir + 50 | **70** |

Warna background: digit terakhir genap (0) → `Colors.amber[100]`.

## Cara jalanin

```bash
flutter pub get
flutter run
```

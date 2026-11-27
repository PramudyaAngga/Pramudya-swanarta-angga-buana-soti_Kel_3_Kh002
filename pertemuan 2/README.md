# Pertemuan 2 — Flutter Profile Card

Nama: **Pramudya Swanarta Angga Buana Soti**
NIM: **20240801020**

## Isi

```
pertemuan 2/
├── lib/
│   ├── main.dart          # entry point, atur warna background dari digit terakhir NIM
│   └── profile_card.dart  # widget kartu profil (nama, NIM, hobi, skor aktivitas)
├── design/                # 9 PNG mockup UI mobile (keranjang, profil, notifikasi, dll)
├── android/ ios/ linux/ macos/ web/ windows/   # platform folder Flutter
└── pubspec.yaml
```

## Logika warna

Digit terakhir NIM = `0` (genap) → background `Colors.amber[100]`.
Kalau ganjil → `Colors.tealAccent[100]`. Logikanya ada di `lib/main.dart`.

## Cara jalanin

```bash
flutter pub get
flutter run
```

Butuh Flutter SDK. Cek dulu: `flutter doctor`.

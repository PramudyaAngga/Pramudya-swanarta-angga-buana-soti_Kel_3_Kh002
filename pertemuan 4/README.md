# Pertemuan 4 — Custom Widget, Theme & Personal Profile Card

Nama: **Pramudya Swanarta Angga Buana Soti** — NIM: **20240801020**

## Isi folder

| Item | Keterangan |
|---|---|
| `Laporan_Praktikum_Pemob_Pertemuan_4_20240801020.pdf` | Laporan praktikum |
| `lib/main.dart` | `ProfilePage` — halaman profil |
| `lib/theme/app_theme.dart` | `AppTheme.lightTheme` — Material 3, seed color indigo |
| `lib/widgets/app_button.dart` | `Application` — custom button yang buka URL via `url_launcher` |
| `pubspec.yaml` | `name: pertemuan_4_pemob`, dependency `url_launcher` |

## Konsep

- **Pemisahan tema** — semua warna & style di `AppTheme`, bukan hardcode di widget.
- **Custom widget reusable** — `Application` nerima `icon`, `url`, `height`, `borderRadius`.
- **`url_launcher`** — tombol "Kunjungi GitHub Saya" buka browser; kalau gagal muncul `SnackBar`.

## Cara jalanin

```bash
flutter pub get
flutter run
```

Di web/desktop tombol URL tetap jalan. Di Android/iOS `url_launcher` butuh konfigurasi `AndroidManifest.xml` / `Info.plist` (sudah disertakan di project ini).

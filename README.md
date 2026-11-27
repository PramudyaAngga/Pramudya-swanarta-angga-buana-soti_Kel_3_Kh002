# Praktikum Pemrograman Mobile — Kelas KH002, Kelompok 3

**Pramudya Swanarta Angga Buana Soti** — NIM 20240801020
Universitas Esa Unggul

Repo ini isinya kumpulan tugas praktikum Pemrograman Mobile, disusun per pertemuan.

## Struktur

| Folder | Isi | Laporan |
|---|---|---|
| [`pertemuan 1/`](pertemuan%201/) | Java dasar — `Main.java` (perulangan & output) | — |
| [`pertemuan 2/`](pertemuan%202/) | Flutter **Profile Card** + `design/` (9 mockup UI) | — |
| [`pertemuan 3/`](pertemuan%203/) | Flutter **Profile Card berbasis NIM** (rumus lebar/radius/logo) | ✅ PDF |
| [`pertemuan 4/`](pertemuan%204/) | Flutter **Personal Profile Card** — custom theme & widget, `url_launcher` | ✅ PDF |
| [`pertemuan 5/`](pertemuan%205/) | Laporan praktikum | ✅ PDF |
| [`pertemuan 8/`](pertemuan%208/) | Flutter **CRUD API** User & Admin (`http`, JSONPlaceholder) | ✅ PDF + DOCX |

## Ringkasan tiap pertemuan

**Pertemuan 1 — Java dasar**
`System.out.print` + perulangan `for` 1..5.

**Pertemuan 2 — Flutter Profile Card**
Widget `ProfileCard` dengan nama, NIM, hobi, skor aktivitas. Background ditentukan digit terakhir NIM (genap → `amber[100]`, ganjil → `tealAccent[100]`).

**Pertemuan 3 — Layout & formula berbasis NIM**
Semua ukuran dihitung dari NIM 20240801020: lebar kartu 330.0, radius 12.0, logo 60.0, `skorAktivitas` 70.

**Pertemuan 4 — Theme & custom widget**
Tema dipisah ke `AppTheme.lightTheme`, tombol reusable `Application` dengan `url_launcher`, plus analisis `child` vs `children` dan overflow `RenderFlex`.

**Pertemuan 8 — CRUD API**
Ambil data user & admin dari JSONPlaceholder lewat `package:http`, dengan model, service layer, dan test.

## Cara jalanin

**Pertemuan 1 (Java)**
```bash
cd "pertemuan 1/src"
javac Main.java && java Main
```

**Pertemuan 2 – 8 (Flutter)** — tiap folder punya `pubspec.yaml` sendiri:
```bash
cd "pertemuan 3"    # atau "pertemuan 4", "pertemuan 8"
flutter pub get
flutter run
```

**Test (pertemuan 8)**
```bash
cd "pertemuan 8"
flutter test
```

## Catatan

- Tiap folder pertemuan punya README sendiri yang jelasin isi + rumus + cara jalannya.
- Nama folder pakai spasi, jadi kalau lewat terminal pakai tanda kutip: `cd "pertemuan 3"`.
- `build/`, `.dart_tool/`, `.idea/`, dan `*.iml` tidak di-commit — jalankan `flutter pub get` dulu setelah clone.

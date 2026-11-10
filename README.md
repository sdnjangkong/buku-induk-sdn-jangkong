# Buku Induk Siswa — SDN Jangkong

Aplikasi administrasi buku induk berbasis HTML, CSS, dan JavaScript. Frontend dapat di-host gratis di GitHub Pages, sedangkan data bersama disimpan di Supabase agar dapat diakses dari komputer maupun HP.

## Fitur
- Dashboard jumlah siswa, laki-laki/perempuan, dan sebaran Kelas 1–6.
- Tambah, lihat, edit, hapus, cari, dan filter data siswa.
- Impor workbook Excel Dapodik (`Daftar Peserta Didik`, data mulai baris 7) dan pemetaan data ayah/ibu/wali.
- Ekspor daftar siswa ke CSV.
- Lembar biodata siswa dan cetak melalui browser / simpan sebagai PDF.
- Pengaturan identitas sekolah.
- Mode demo lokal untuk mencoba tampilan. Mode ini menyimpan data di browser saja, bukan sinkron antar perangkat.

## Struktur folder

```text
buku-induk-sdn-jangkong/
├── index.html
├── styles.css
├── app.js
├── config.example.js
├── README.md
├── .gitignore
├── assets/
│   └── logo.svg
└── sql/
    └── schema.sql
```

## A. Menyiapkan database online (Supabase)

1. Buat project baru di [Supabase](https://supabase.com/).
2. Buka **SQL Editor**, lalu jalankan seluruh isi `sql/schema.sql`.
3. Buka **Project Settings → API**. Salin Project URL dan anon/publishable key.
4. Salin `config.example.js` menjadi file bernama `config.js`.
5. Isi `SUPABASE_URL` dan `SUPABASE_ANON_KEY` pada `config.js`.
6. Di **Authentication → Providers → Email**, aktifkan Email. Buat akun admin dari **Authentication → Users → Add user**.
7. Untuk aplikasi sekolah, matikan **Allow new users to sign up** agar orang umum tidak dapat membuat akun sendiri. Bagikan akun hanya kepada petugas yang berwenang.

> Penting: `config.js` berisi anon/publishable key yang memang digunakan di browser. Jangan pernah menaruh `service_role` key di file frontend. Kebijakan RLS pada SQL membatasi akses tabel untuk pengguna yang sudah login. Pada versi awal ini, semua akun terautentikasi memiliki hak kelola data; buat akun hanya untuk petugas tepercaya. Untuk pembatasan peran admin/operator yang lebih rinci, tambahkan tabel profil/role dan policy RLS khusus sebelum membuka akses lebih luas.

## B. Menjalankan di komputer

- Setelah `config.js` terisi, buka `index.html` melalui server lokal (misalnya ekstensi VS Code Live Server), bukan `file://` jika browser membatasi modul/koneksi.
- Login menggunakan akun admin Supabase.
- Mode demo lokal tersedia bila Supabase belum diatur. Data mode demo hanya tersimpan di browser/perangkat yang sama.

## C. Upload ke GitHub dan aktifkan GitHub Pages

1. Buat repository GitHub baru, misalnya `buku-induk-sdn-jangkong`.
2. Upload file aplikasi. Jangan upload Excel berisi data pribadi siswa, file backup database, atau kredensial rahasia.
3. Jika menggunakan `config.js`, pastikan isinya hanya URL project dan anon/publishable key; jangan pernah mengunggah `service_role` key. Untuk repository publik, pertimbangkan mengatur konfigurasi melalui proses deployment privat atau memakai repository privat.
4. Buka **Settings → Pages**.
5. Pada **Build and deployment**, pilih **Deploy from a branch**, branch `main`, folder `/ (root)`, lalu Save.
6. Tunggu proses selesai. Aplikasi akan tersedia di alamat GitHub Pages repository.

Catatan: GitHub Pages bersifat publik untuk file frontend. Login Supabase tetap diperlukan untuk membuka data. Jangan simpan NIK, KK, alamat, atau data anak di file HTML/JS atau repository.

## D. Impor Excel Dapodik

- Gunakan file Excel asli yang memiliki sheet `Daftar Peserta Didik`.
- Aplikasi membaca baris data mulai baris ke-7 pada sheet utama, sesuai format file yang diberikan.
- Data akan dicocokkan berdasarkan NISN untuk memperbarui data yang sudah ada; bila NISN kosong, pencocokan memakai nama dan kelas.
- Periksa hasil impor dan kelengkapan data setelah proses selesai. Simpan file Excel asli secara aman sebagai arsip sekolah.

## Catatan keamanan dan operasional

- Gunakan HTTPS (GitHub Pages sudah HTTPS).
- Buat akun hanya bagi staf yang berwenang dan gunakan kata sandi kuat.
- Aktifkan MFA pada akun pengelola Supabase jika tersedia.
- Lakukan backup berkala dari Supabase dan simpan di media yang aman.
- Data anak adalah data pribadi. Pastikan dasar kewenangan, pembatasan akses, dan prosedur backup/pemulihan disepakati sekolah.
- Jangan menganggap mode demo sebagai database online. Sinkronisasi lintas perangkat hanya aktif setelah Supabase dikonfigurasi.

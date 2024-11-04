# CRUD_DS

Aplikasi CRUD sederhana menggunakan Flutter yang terhubung dengan server dummy JSONPlaceholder untuk operasi **Create**, **Read**, **Update**, dan **Delete**.

### API Dummy Server
Menggunakan JSONPlaceholder sebagai server dummy untuk data. Link dapat mengakses API-nya di:  
[https://jsonplaceholder.typicode.com](https://jsonplaceholder.typicode.com)

### Membuat Proyek Flutter Baru
Ikuti langkah-langkah berikut untuk membuat proyek Flutter baru, sehingga folder `build` dan `gradle` akan otomatis dibuat:

1. **Buka terminal atau command prompt**.
2. Jalankan perintah berikut untuk membuat proyek Flutter baru dengan nama `CRUD_DS`:

   ```bash
   flutter create CRUD_DS
   ```

3. Setelah proyek berhasil dibuat, pindah ke direktori proyek:

   ```bash
   cd CRUD_DS
   ```

4. **Jalankan aplikasi** pertama kali untuk memastikan folder `build` dan `gradle` terbuat otomatis:

   ```bash
   flutter run
   ```

5. Jika folder `build` atau `gradle` belum muncul, coba bersihkan proyek dengan:

   ```bash
   flutter clean
   ```

   Lalu, ulangi perintah `flutter run` untuk membangun ulang proyek.

### Deskripsi
Aplikasi ini cocok untuk dipelajari oleh siapa saja yang ingin memahami implementasi dasar CRUD di Flutter menggunakan API RESTful. Dengan aplikasi ini, Anda dapat mempelajari cara mengambil data dari server, menambah data baru, mengedit data, serta menghapus data.

### Penggunaan
1. **Buka** file `main.dart`.
2. **Jalankan** aplikasi pada Android Studio menggunakan emulator, misalnya Pixel 5 API 31.
3. **Tes Fungsi CRUD** untuk memastikan semua fitur berjalan sesuai harapan.

### Catatan
- Aplikasi ini menggunakan server dummy, sehingga data tidak akan benar-benar tersimpan atau terhapus pada JSONPlaceholder.
- Cocok sebagai bahan belajar dasar integrasi API di Flutter.

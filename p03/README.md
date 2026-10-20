# StudyTracker P03

Aplikasi Flutter sederhana buat nyatet daftar tugas belajar. Ada 3 layar: Daftar Tugas, Detail Tugas, dan Form Tambah Tugas. Datanya masih disimpen di memori (pakai `setState`), jadi kalau di-refresh atau ditutup aplikasinya bakal ilang, sesuai sama ketentuan tugas.

## Cerita Bug yang Bikin Pusing

Pas ngerjain bagian form tambah tugas, tiba-tiba `flutter analyze` ngasih error merah `Invalid constant value` di file `task_card.dart`. Padahal pas dijalanin (flutter run) aplikasinya aman-aman aja.

Awalnya bingung, tapi pas liat baris errornya, ternyata masalahnya di kata `const` yang nempel di widget `Icon`. Di dalam Icon itu kan ada variabel `task.completed` yang nilainya bisa berubah (centang atau nggak). Flutter nggak ngebolehin ada `const` kalau isinya data yang dinamis kayak gitu.

**Cara benerinnya:** Tinggal hapus aja kata `const` di depan `Icon` tersebut, terus pas dijalanin `flutter analyze` lagi langsung `No issues found!`.
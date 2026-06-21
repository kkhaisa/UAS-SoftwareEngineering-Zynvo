# UAS-SoftwareEngineering-Zynvo
# ZYNVO - Smart Campus Event Management

Zynzo adalah purwarupa aplikasi manajemen kegiatan kampus cerdas (*Smart Campus Event Management*) yang dirancang khusus untuk lingkungan akademis Universitas Pembangunan Jaya. Aplikasi ini mengusung pendekatan *Mobile-First responsive design* untuk memberikan pengalaman terbaik bagi mahasiswa dalam mengakses informasi dan partisipasi kegiatan kampus.

---

## 🚀 Fitur Utama (Modul Autentikasi)
* **Mobile-First UI/UX:** Antarmuka login modern dengan skema warna Ungu Pastel & Kuning cerah yang disesuaikan presisi berdasarkan rancangan desain Figma kelompok.
* **Validasi Domain Kampus:** Sistem keamanan backend otomatis menolak registrasi/login jika tidak menggunakan email resmi institusi (`@upj.ac.id` atau `@student.upj.ac.id`).
* **Enkripsi Kredensial:** Keamanan kata sandi dilindungi menggunakan algoritma *hashing* satu arah dari `bcryptjs`.
* **Stateful Token Session:** Otentikasi berbasis *JSON Web Token* (JWT) yang diterbitkan oleh server backend dan disimpan secara aman pada `LocalStorage` frontend.

---

## 🛠️ Arsitektur Teknologi

### Frontend (Antarmuka)
* HTML5 & CSS3 (Custom Layout)
* Bootstrap 5.3 (Framework CSS)
* Bootstrap Icons (Komponen Ikon Grafis)

### Backend (Server Samping)
* Node.js v22.x
* Express.js (Framework Router API)
* Bcryptjs (Library Enkripsi Password)
* Jsonwebtoken (Standard Token Keamanan JWT)
* CORS (Cross-Origin Resource Sharing)

---

## 💻 Cara Menjalankan Proyek di Lokal

### 1. Persiapan Awal
Pastikan laptop Anda sudah terinstal [Node.js](https://nodejs.org/). Kloning atau unduh repository ini ke dalam direktori lokal Anda.

### 2. Instalasi Dependensi
Buka Terminal/Command Prompt di folder proyek, lalu jalankan perintah berikut untuk mengunduh semua pustaka yang diperlukan:
```bash
npm install

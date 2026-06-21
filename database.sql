-- 1. Tabel Users (Menyimpan data pengguna dan akumulasi poin reward)
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email_kampus VARCHAR(100) UNIQUE NOT NULL,
    password_hash TEXT NOT NULL, -- Password di-hash dari sisi server via HTTPS
    role VARCHAR(20) NOT NULL, -- Validasi role (Mahasiswa, Panitia, Admin) di tingkat aplikasi
    total_poin INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. Tabel Event (Mengelola ketersediaan kuota acara kampus)
CREATE TABLE events (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nama_event VARCHAR(100) NOT NULL,
    deskripsi TEXT,
    waktu_event TIMESTAMP NOT NULL,
    lokasi VARCHAR(100) NOT NULL,
    kuota INT NOT NULL, -- Pengecekan kuota >= 0 dilakukan saat query Row-Level Locking
    poin_reward INT DEFAULT 0
);

-- 3. Tabel Tiket (QR Code Payload berisi token aman mencegah Spoofing)
CREATE TABLE tickets (
    id INT AUTO_INCREMENT PRIMARY KEY,
    event_id INT,
    user_id INT,
    status_pembayaran VARCHAR(20) DEFAULT 'Lunas',
    qr_code_payload TEXT NOT NULL, -- Token terenkripsi AES-256 untuk keamanan scan QR
    status_kehadiran VARCHAR(20) DEFAULT 'Belum Hadir',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (event_id) REFERENCES events(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- 4. Tabel Immutable Audit Logging (Memenuhi aspek Non-Repudiation)
CREATE TABLE audit_logs (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    aktivitas VARCHAR(100) NOT NULL, -- Contoh: 'WAR_TICKET_BOOKING', 'ATTENDANCE_SCAN'
    ip_address VARCHAR(45) NOT NULL,  -- Disimpan untuk tracking Rate Limiting
    detail_payload TEXT NOT NULL,     -- Format JSON string untuk menyimpan log aktivitas
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL
);
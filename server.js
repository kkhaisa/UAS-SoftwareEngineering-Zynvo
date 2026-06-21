const express = require("express");
const jwt = require("jsonwebtoken");
const bcrypt = require("bcryptjs");
const cors = require("cors"); // <-- 1. Memanggil pustaka CORS agar tidak diblokir browser
const app = express();

app.use(express.json());
app.use(cors()); // <-- 2. Mengaktifkan akses CORS untuk frontend kamu

const JWT_SECRET = "ZYNVO_SUPER_SECRET_KEY_2026";
const usersDatabase = [];

// Menambahkan data uji coba otomatis agar kamu bisa langsung tes login tanpa register dulu
(async () => {
  const salt = await bcrypt.genSalt(10);
  const hashedPassword = await bcrypt.hash("password123", salt);
  usersDatabase.push({
    id: 1,
    username: "Khairun Nisa",
    email_kampus: "khairun.nisaal@student.upj.ac.id",
    password_hash: hashedPassword,
    role: "Mahasiswa",
    total_poin: 0,
  });
})();

app.post("/api/register", async (req, res) => {
  try {
    const { username, email_kampus, password, role } = req.body;

    if (
      !email_kampus.endsWith("@upj.ac.id") &&
      !email_kampus.endsWith("@student.upj.ac.id")
    ) {
      return res.status(400).json({
        message: "Registrasi gagal. Harus menggunakan email resmi kampus!",
      });
    }

    const salt = await bcrypt.genSalt(10);
    const hashedPassword = await bcrypt.hash(password, salt);

    const newUser = {
      id: usersDatabase.length + 1,
      username,
      email_kampus,
      password_hash: hashedPassword,
      role: role || "Mahasiswa",
      total_poin: 0,
    };

    usersDatabase.push(newUser);
    res
      .status(201)
      .json({ message: "Registrasi berhasil!", userId: newUser.id });
  } catch (error) {
    res.status(500).json({ message: "Terjadi kesalahan pada server." });
  }
});

app.post("/api/login", async (req, res) => {
  const { email_kampus, password } = req.body;

  const user = usersDatabase.find((u) => u.email_kampus === email_kampus);
  if (!user) {
    return res.status(400).json({ message: "Email atau Password salah!" });
  }

  const isMatch = await bcrypt.compare(password, user.password_hash);
  if (!isMatch) {
    return res.status(400).json({ message: "Email atau Password salah!" });
  }

  const token = jwt.sign({ userId: user.id, role: user.role }, JWT_SECRET, {
    expiresIn: "1h",
  });

  res.json({
    message: "Login berhasil!",
    token: token,
    role: user.role,
  });
});

app.listen(3000, () => {
  console.log("Server Zynvo Backend berjalan aman di port 3000");
});

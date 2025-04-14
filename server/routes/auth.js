const express = require("express");
const router = express.Router();
const db = require("../db");
const bcrypt = require("bcrypt");

// Register route
router.post("/register", async (req, res) => {
  const { name, email, password, role, token } = req.body;

  if (!name || !email || !password || !role) {
    return res.status(400).json({ message: "All fields are required." });
  }

  try {
    // Check if token exists and is valid

    // Check if user already exists
    const [userCheck] = await db
      .promise()
      .query("SELECT id FROM users WHERE email = ?", [email]);
    if (userCheck.length > 0) {
      return res.status(409).json({ message: "Email already registered." });
    }

    // If doctor, check token
    if (role === "doctor") {
      const [doctorTokenCheck] = await db
        .promise()
        .query(
          "SELECT * FROM doctor_tokens WHERE token = ? AND is_valid = TRUE",
          [token]
        );
      if (doctorTokenCheck.length === 0) {
        return res
          .status(403)
          .json({ message: "Invalid or expired doctor token." });
      }
    }

    const hashedPassword = await bcrypt.hash(password, 10);
    const [result] = await db
      .promise()
      .query(
        "INSERT INTO users (name, email, password, role) VALUES (?, ?, ?, ?)",
        [name, email, hashedPassword, role]
      );

    const userId = result.insertId;

    // Insert into doctor or patient table
    if (role === "doctor") {
      await db.promise().query("INSERT INTO doctors (id) VALUES (?)", [userId]);
    } else {
      await db
        .promise()
        .query("INSERT INTO patients (id) VALUES (?)", [userId]);
    }

    return res
      .status(201)
      .json({ message: `${role} registered successfully.` });
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: "Server error during registration." });
  }
});

// Login route
router.post("/login", async (req, res) => {
  const { email, password } = req.body;

  try {
    const [rows] = await db
      .promise()
      .query("SELECT * FROM users WHERE email = ?", [email]);
    if (rows.length === 0) {
      return res.status(401).json({ message: "Invalid credentials." });
    }

    const user = rows[0];
    const match = await bcrypt.compare(password, user.password);
    if (!match) {
      return res.status(401).json({ message: "Invalid credentials." });
    }

    res.status(200).json({
      message: "Login successful.",
      user: {
        id: user.id,
        name: user.name,
        email: user.email,
        role: user.role,
      },
    });
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: "Server error during login." });
  }
});

module.exports = router;

-- Drop tables if needed
DROP TABLE IF EXISTS sensor_events, restock_requests, notifications, dispense_logs, medications, patients, doctors, doctor_tokens, users;

-- USERS
CREATE TABLE users (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(100),
  email VARCHAR(100) UNIQUE,
  password VARCHAR(255),
  role ENUM('doctor', 'patient'),
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- DOCTOR TOKENS
CREATE TABLE doctor_tokens (
  id INT PRIMARY KEY AUTO_INCREMENT,
  token VARCHAR(100) UNIQUE NOT NULL,
  is_valid BOOLEAN DEFAULT TRUE,
  description VARCHAR(255),
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- DOCTORS
CREATE TABLE doctors (
  id INT PRIMARY KEY,
  specialization VARCHAR(100),
  contact_info VARCHAR(255),
  FOREIGN KEY (id) REFERENCES users(id) ON DELETE CASCADE
);

-- PATIENTS
CREATE TABLE patients (
  id INT PRIMARY KEY,
  assigned_doctor_id INT,
  birth_date DATE,
  health_conditions TEXT,
  FOREIGN KEY (id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (assigned_doctor_id) REFERENCES doctors(id)
);

-- MEDICATIONS
CREATE TABLE medications (
  id INT PRIMARY KEY AUTO_INCREMENT,
  patient_id INT,
  doctor_id INT,
  name VARCHAR(100),
  dosage VARCHAR(100),
  frequency VARCHAR(50),
  start_date DATE,
  end_date DATE,
  dispense_time TEXT,
  pills_left INT,
  status ENUM('active', 'stopped') DEFAULT 'active',
  FOREIGN KEY (patient_id) REFERENCES patients(id),
  FOREIGN KEY (doctor_id) REFERENCES doctors(id)
);

-- DISPENSE LOGS
CREATE TABLE dispense_logs (
  id INT PRIMARY KEY AUTO_INCREMENT,
  medication_id INT,
  dispense_time DATETIME,
  dispense_type ENUM('automatic', 'manual'),
  was_taken BOOLEAN,
  confirmed_by_sensor BOOLEAN,
  FOREIGN KEY (medication_id) REFERENCES medications(id)
);

-- NOTIFICATIONS
CREATE TABLE notifications (
  id INT PRIMARY KEY AUTO_INCREMENT,
  user_id INT,
  type VARCHAR(50),
  message TEXT,
  is_read BOOLEAN DEFAULT FALSE,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id)
);

-- RESTOCK REQUESTS
CREATE TABLE restock_requests (
  id INT PRIMARY KEY AUTO_INCREMENT,
  medication_id INT,
  requested_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  approved_by_doctor BOOLEAN DEFAULT FALSE,
  approval_time DATETIME,
  FOREIGN KEY (medication_id) REFERENCES medications(id)
);

-- SENSOR EVENTS
CREATE TABLE sensor_events (
  id INT PRIMARY KEY AUTO_INCREMENT,
  dispense_log_id INT,
  sensor_type VARCHAR(50),
  value VARCHAR(100),
  detected_at DATETIME,
  FOREIGN KEY (dispense_log_id) REFERENCES dispense_logs(id)
);

-- DOCTOR TOKENS
INSERT INTO doctor_tokens (token, description) VALUES
  ('doctor2025', 'Main secure token for HealthGuard doctors'),
  ('doc-access-99', 'Internal testing key'),
  ('clinic-token-ALPHA', 'Partner clinic access'),
  ('dr-beta-test', 'Temporary test token');

-- USERS
INSERT INTO users (name, email, password, role) VALUES
  ('Dr. Smith', 'drsmith@hospital.com', 'hashed_pw_1', 'doctor'),
  ('Alice Patient', 'alice@patient.com', 'hashed_pw_2', 'patient');

-- DOCTORS
INSERT INTO doctors (id, specialization, contact_info) VALUES
  (1, 'Internal Medicine', 'clinic +123456');

-- PATIENTS
INSERT INTO patients (id, assigned_doctor_id, birth_date, health_conditions) VALUES
  (2, 1, '1995-03-15', 'Hypertension, Asthma');

-- MEDICATIONS
INSERT INTO medications (patient_id, doctor_id, name, dosage, frequency, start_date, end_date, dispense_time, pills_left, status) VALUES
  (2, 1, 'Aspirin', '100mg', 'Daily', '2025-04-01', '2025-04-30', '["08:00", "20:00"]', 10, 'active');

-- DISPENSE LOGS
INSERT INTO dispense_logs (medication_id, dispense_time, dispense_type, was_taken, confirmed_by_sensor) VALUES
  (1, '2025-04-12 08:01:00', 'automatic', TRUE, TRUE);

-- SENSOR EVENTS
INSERT INTO sensor_events (dispense_log_id, sensor_type, value, detected_at) VALUES
  (1, 'motion', 'detected', '2025-04-12 08:01:10');

-- NOTIFICATIONS
INSERT INTO notifications (user_id, type, message) VALUES
  (2, 'reminder', 'Time to take your Aspirin dose at 8:00 AM');

-- RESTOCK REQUESTS
INSERT INTO restock_requests (medication_id, requested_at, approved_by_doctor, approval_time) VALUES
  (1, '2025-04-10 09:00:00', TRUE, '2025-04-10 11:00:00');

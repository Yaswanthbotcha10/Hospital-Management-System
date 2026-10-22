USE hospital_management_db;

CREATE TABLE departments (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL UNIQUE,
    location VARCHAR(100),
    phone VARCHAR(20)
);

CREATE TABLE doctors (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    department_id INT NOT NULL,
    first_name VARCHAR(60) NOT NULL,
    last_name VARCHAR(60) NOT NULL,
    specialization VARCHAR(100) NOT NULL,
    phone VARCHAR(20) UNIQUE,
    email VARCHAR(120) UNIQUE,
    consultation_fee DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    hire_date DATE,
    active BOOLEAN NOT NULL DEFAULT TRUE,
    CONSTRAINT chk_doctor_fee CHECK (consultation_fee >= 0),
    CONSTRAINT fk_doctor_department FOREIGN KEY (department_id)
        REFERENCES departments(department_id)
);

CREATE TABLE patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(60) NOT NULL,
    last_name VARCHAR(60) NOT NULL,
    date_of_birth DATE NOT NULL,
    gender ENUM('Female','Male','Other','Prefer not to say') NOT NULL,
    phone VARCHAR(20) UNIQUE,
    email VARCHAR(120) UNIQUE,
    city VARCHAR(80),
    registered_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE rooms (
    room_id INT AUTO_INCREMENT PRIMARY KEY,
    room_number VARCHAR(10) NOT NULL UNIQUE,
    room_type ENUM('General','Semi-Private','Private','ICU') NOT NULL,
    daily_rate DECIMAL(10,2) NOT NULL,
    room_status ENUM('Available','Occupied','Maintenance') NOT NULL DEFAULT 'Available',
    CONSTRAINT chk_room_rate CHECK (daily_rate >= 0)
);

CREATE TABLE appointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_datetime DATETIME NOT NULL,
    reason VARCHAR(255),
    status ENUM('Scheduled','Completed','Cancelled','No-show') NOT NULL DEFAULT 'Scheduled',
    consultation_fee DECIMAL(10,2) NOT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_appointment_fee CHECK (consultation_fee >= 0),
    CONSTRAINT fk_appointment_patient FOREIGN KEY (patient_id)
        REFERENCES patients(patient_id),
    CONSTRAINT fk_appointment_doctor FOREIGN KEY (doctor_id)
        REFERENCES doctors(doctor_id)
);

CREATE TABLE admissions (
    admission_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    room_id INT NOT NULL,
    attending_doctor_id INT NOT NULL,
    admission_date DATE NOT NULL,
    discharge_date DATE,
    admission_reason VARCHAR(255) NOT NULL,
    status ENUM('Admitted','Discharged') NOT NULL DEFAULT 'Admitted',
    CONSTRAINT chk_admission_dates CHECK (discharge_date IS NULL OR discharge_date >= admission_date),
    CONSTRAINT fk_admission_patient FOREIGN KEY (patient_id)
        REFERENCES patients(patient_id),
    CONSTRAINT fk_admission_room FOREIGN KEY (room_id)
        REFERENCES rooms(room_id),
    CONSTRAINT fk_admission_doctor FOREIGN KEY (attending_doctor_id)
        REFERENCES doctors(doctor_id)
);

CREATE TABLE treatments (
    treatment_id INT AUTO_INCREMENT PRIMARY KEY,
    admission_id INT NOT NULL,
    treatment_name VARCHAR(150) NOT NULL,
    treatment_date DATE NOT NULL,
    description VARCHAR(255),
    cost DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    CONSTRAINT chk_treatment_cost CHECK (cost >= 0),
    CONSTRAINT fk_treatment_admission FOREIGN KEY (admission_id)
        REFERENCES admissions(admission_id)
);

CREATE TABLE prescriptions (
    prescription_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_id INT NULL,
    prescribed_date DATE NOT NULL,
    notes VARCHAR(255),
    CONSTRAINT fk_prescription_patient FOREIGN KEY (patient_id)
        REFERENCES patients(patient_id),
    CONSTRAINT fk_prescription_doctor FOREIGN KEY (doctor_id)
        REFERENCES doctors(doctor_id),
    CONSTRAINT fk_prescription_appointment FOREIGN KEY (appointment_id)
        REFERENCES appointments(appointment_id)
);

CREATE TABLE prescription_items (
    prescription_item_id INT AUTO_INCREMENT PRIMARY KEY,
    prescription_id INT NOT NULL,
    medicine_name VARCHAR(120) NOT NULL,
    dosage VARCHAR(80) NOT NULL,
    frequency VARCHAR(80) NOT NULL,
    duration_days INT NOT NULL,
    CONSTRAINT chk_duration CHECK (duration_days > 0),
    CONSTRAINT fk_item_prescription FOREIGN KEY (prescription_id)
        REFERENCES prescriptions(prescription_id) ON DELETE CASCADE
);

CREATE TABLE bills (
    bill_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    appointment_id INT NULL,
    admission_id INT NULL,
    bill_date DATE NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    notes VARCHAR(255),
    CONSTRAINT chk_bill_amount CHECK (amount >= 0),
    CONSTRAINT chk_bill_source CHECK (
        (appointment_id IS NOT NULL AND admission_id IS NULL)
        OR (appointment_id IS NULL AND admission_id IS NOT NULL)
    ),
    CONSTRAINT fk_bill_patient FOREIGN KEY (patient_id)
        REFERENCES patients(patient_id),
    CONSTRAINT fk_bill_appointment FOREIGN KEY (appointment_id)
        REFERENCES appointments(appointment_id),
    CONSTRAINT fk_bill_admission FOREIGN KEY (admission_id)
        REFERENCES admissions(admission_id)
);

CREATE TABLE payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    bill_id INT NOT NULL,
    payment_date DATE NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_method ENUM('Cash','Card','UPI','Insurance','Bank Transfer') NOT NULL,
    payment_status ENUM('Successful','Pending','Failed','Refunded') NOT NULL DEFAULT 'Successful',
    transaction_reference VARCHAR(100) UNIQUE,
    CONSTRAINT chk_payment_amount CHECK (amount > 0),
    CONSTRAINT fk_payment_bill FOREIGN KEY (bill_id)
        REFERENCES bills(bill_id)
);

CREATE TABLE appointment_status_history (
    history_id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id INT NOT NULL,
    old_status VARCHAR(20),
    new_status VARCHAR(20) NOT NULL,
    changed_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    remarks VARCHAR(255),
    CONSTRAINT fk_history_appointment FOREIGN KEY (appointment_id)
        REFERENCES appointments(appointment_id) ON DELETE CASCADE
);

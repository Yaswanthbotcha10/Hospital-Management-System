USE hospital_management_db;

-- 1. List all patients alphabetically.
SELECT patient_id, CONCAT(first_name, ' ', last_name) AS patient_name, date_of_birth, gender, city
FROM patients
ORDER BY last_name, first_name;

-- 2. Count registered patients by city.
SELECT city, COUNT(*) AS patient_count
FROM patients
GROUP BY city
ORDER BY patient_count DESC;

-- 3. Find patients who have never booked an appointment.
SELECT p.patient_id, CONCAT(p.first_name, ' ', p.last_name) AS patient_name
FROM patients p
LEFT JOIN appointments a ON a.patient_id = p.patient_id
WHERE a.appointment_id IS NULL;

-- 4. Show each patient's appointment count.
SELECT p.patient_id, CONCAT(p.first_name, ' ', p.last_name) AS patient_name,
       COUNT(a.appointment_id) AS appointment_count
FROM patients p
LEFT JOIN appointments a ON a.patient_id = p.patient_id
GROUP BY p.patient_id, patient_name
ORDER BY appointment_count DESC;

USE hospital_management_db;

-- 1. Appointments with patient, doctor, and department.
SELECT * FROM vw_appointment_details
ORDER BY appointment_datetime;

-- 2. Appointment counts by status.
SELECT status, COUNT(*) AS total
FROM appointments
GROUP BY status
ORDER BY total DESC;

-- 3. Doctors with the most appointments.
SELECT * FROM vw_doctor_workload
ORDER BY total_appointments DESC, doctor_name;

-- 4. Completed appointments by department.
SELECT dep.department_name, COUNT(*) AS completed_count
FROM appointments a
JOIN doctors d ON d.doctor_id = a.doctor_id
JOIN departments dep ON dep.department_id = d.department_id
WHERE a.status = 'Completed'
GROUP BY dep.department_id, dep.department_name
ORDER BY completed_count DESC;

-- 5. Appointments within a date range (edit the dates as needed).
SELECT appointment_id, patient_id, doctor_id, appointment_datetime, status
FROM appointments
WHERE appointment_datetime >= '2025-06-01'
  AND appointment_datetime < '2025-07-01'
ORDER BY appointment_datetime;

-- 6. Find doctors who have no appointments.
SELECT d.doctor_id, CONCAT(d.first_name, ' ', d.last_name) AS doctor_name
FROM doctors d
LEFT JOIN appointments a ON a.doctor_id = d.doctor_id
WHERE a.appointment_id IS NULL;

USE hospital_management_db;

-- 1. Current inpatients.
SELECT * FROM vw_current_admissions
ORDER BY admission_date;

-- 2. Number of admissions by status.
SELECT status, COUNT(*) AS admission_count
FROM admissions
GROUP BY status;

-- 3. Total treatment cost per admission.
SELECT ad.admission_id, CONCAT(p.first_name, ' ', p.last_name) AS patient_name,
       COALESCE(SUM(t.cost), 0) AS total_treatment_cost
FROM admissions ad
JOIN patients p ON p.patient_id = ad.patient_id
LEFT JOIN treatments t ON t.admission_id = ad.admission_id
GROUP BY ad.admission_id, patient_name
ORDER BY total_treatment_cost DESC;

-- 4. Rooms and their current status.
SELECT room_type, room_status, COUNT(*) AS room_count
FROM rooms
GROUP BY room_type, room_status
ORDER BY room_type, room_status;

-- 5. Average length of stay for discharged admissions.
SELECT ROUND(AVG(DATEDIFF(discharge_date, admission_date)), 2) AS average_stay_days
FROM admissions
WHERE status = 'Discharged' AND discharge_date IS NOT NULL;

-- 6. Most frequently used treatment types.
SELECT treatment_name, COUNT(*) AS times_used, SUM(cost) AS total_cost
FROM treatments
GROUP BY treatment_name
ORDER BY times_used DESC, total_cost DESC;

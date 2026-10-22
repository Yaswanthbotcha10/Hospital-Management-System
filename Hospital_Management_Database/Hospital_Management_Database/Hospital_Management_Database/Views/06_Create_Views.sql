USE hospital_management_db;

CREATE OR REPLACE VIEW vw_appointment_details AS
SELECT a.appointment_id, a.appointment_datetime, a.status,
       CONCAT(p.first_name, ' ', p.last_name) AS patient_name,
       CONCAT(d.first_name, ' ', d.last_name) AS doctor_name,
       dep.department_name, a.reason, a.consultation_fee
FROM appointments a
JOIN patients p ON p.patient_id = a.patient_id
JOIN doctors d ON d.doctor_id = a.doctor_id
JOIN departments dep ON dep.department_id = d.department_id;

CREATE OR REPLACE VIEW vw_bill_balances AS
SELECT b.bill_id, b.patient_id,
       CONCAT(p.first_name, ' ', p.last_name) AS patient_name,
       b.bill_date, b.amount AS bill_amount,
       COALESCE(SUM(CASE WHEN pay.payment_status = 'Successful' THEN pay.amount ELSE 0 END), 0) AS amount_paid,
       b.amount - COALESCE(SUM(CASE WHEN pay.payment_status = 'Successful' THEN pay.amount ELSE 0 END), 0) AS balance_due,
       CASE
         WHEN COALESCE(SUM(CASE WHEN pay.payment_status = 'Successful' THEN pay.amount ELSE 0 END), 0) >= b.amount THEN 'Paid'
         WHEN COALESCE(SUM(CASE WHEN pay.payment_status = 'Successful' THEN pay.amount ELSE 0 END), 0) = 0 THEN 'Unpaid'
         ELSE 'Partially Paid'
       END AS payment_state
FROM bills b
JOIN patients p ON p.patient_id = b.patient_id
LEFT JOIN payments pay ON pay.bill_id = b.bill_id
GROUP BY b.bill_id, b.patient_id, p.first_name, p.last_name, b.bill_date, b.amount;

CREATE OR REPLACE VIEW vw_doctor_workload AS
SELECT d.doctor_id, CONCAT(d.first_name, ' ', d.last_name) AS doctor_name,
       dep.department_name,
       COUNT(a.appointment_id) AS total_appointments,
       SUM(a.status = 'Completed') AS completed_appointments,
       SUM(a.status = 'Cancelled') AS cancelled_appointments
FROM doctors d
JOIN departments dep ON dep.department_id = d.department_id
LEFT JOIN appointments a ON a.doctor_id = d.doctor_id
GROUP BY d.doctor_id, doctor_name, dep.department_name;

CREATE OR REPLACE VIEW vw_current_admissions AS
SELECT ad.admission_id, CONCAT(p.first_name, ' ', p.last_name) AS patient_name,
       r.room_number, r.room_type, CONCAT(d.first_name, ' ', d.last_name) AS attending_doctor,
       ad.admission_date, DATEDIFF(COALESCE(ad.discharge_date, CURDATE()), ad.admission_date) AS days_admitted,
       ad.status
FROM admissions ad
JOIN patients p ON p.patient_id = ad.patient_id
JOIN rooms r ON r.room_id = ad.room_id
JOIN doctors d ON d.doctor_id = ad.attending_doctor_id
WHERE ad.status = 'Admitted';

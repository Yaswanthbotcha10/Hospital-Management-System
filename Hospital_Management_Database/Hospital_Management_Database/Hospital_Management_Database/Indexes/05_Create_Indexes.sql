USE hospital_management_db;

CREATE INDEX idx_doctors_department ON doctors(department_id);
CREATE INDEX idx_appointments_patient_datetime ON appointments(patient_id, appointment_datetime);
CREATE INDEX idx_appointments_doctor_datetime ON appointments(doctor_id, appointment_datetime);
CREATE INDEX idx_appointments_status_datetime ON appointments(status, appointment_datetime);
CREATE INDEX idx_admissions_patient_dates ON admissions(patient_id, admission_date, discharge_date);
CREATE INDEX idx_treatments_admission_date ON treatments(admission_id, treatment_date);
CREATE INDEX idx_bills_patient_date ON bills(patient_id, bill_date);
CREATE INDEX idx_payments_bill_status ON payments(bill_id, payment_status);

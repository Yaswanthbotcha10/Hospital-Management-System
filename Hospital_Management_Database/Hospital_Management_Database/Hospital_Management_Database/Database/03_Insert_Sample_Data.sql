USE hospital_management_db;

INSERT INTO departments (department_name, location, phone) VALUES
('Cardiology','Block A - Floor 2','080-4001001'),
('Pediatrics','Block B - Floor 1','080-4001002'),
('Orthopedics','Block A - Floor 3','080-4001003'),
('General Medicine','Block C - Floor 1','080-4001004'),
('Neurology','Block C - Floor 2','080-4001005');

INSERT INTO doctors (department_id, first_name, last_name, specialization, phone, email, consultation_fee, hire_date) VALUES
(1,'Ananya','Rao','Cardiologist','9000000001','ananya.rao@hospital.test',800,'2020-04-12'),
(2,'Rahul','Mehta','Pediatrician','9000000002','rahul.mehta@hospital.test',600,'2021-06-01'),
(3,'Kavya','Nair','Orthopedic Surgeon','9000000003','kavya.nair@hospital.test',750,'2019-09-15'),
(4,'Arjun','Reddy','General Physician','9000000004','arjun.reddy@hospital.test',500,'2022-02-10'),
(5,'Meera','Iyer','Neurologist','9000000005','meera.iyer@hospital.test',900,'2018-11-20'),
(1,'Vikram','Shah','Cardiologist','9000000006','vikram.shah@hospital.test',850,'2023-01-05');

INSERT INTO patients (first_name, last_name, date_of_birth, gender, phone, email, city, registered_at) VALUES
('Aarav','Kumar','1995-02-14','Male','9100000001','aarav.kumar@example.test','Visakhapatnam','2025-01-03 10:00:00'),
('Diya','Sharma','2012-07-22','Female','9100000002','diya.sharma@example.test','Vijayawada','2025-01-10 11:30:00'),
('Ishaan','Patel','1988-11-09','Male','9100000003','ishaan.patel@example.test','Hyderabad','2025-02-02 09:15:00'),
('Anika','Reddy','1974-05-30','Female','9100000004','anika.reddy@example.test','Visakhapatnam','2025-02-12 14:00:00'),
('Vivaan','Das','2001-12-01','Male','9100000005','vivaan.das@example.test','Rajahmundry','2025-03-08 08:45:00'),
('Sara','Joseph','1990-03-17','Female','9100000006','sara.joseph@example.test','Hyderabad','2025-03-21 13:10:00'),
('Kabir','Singh','1962-08-05','Male','9100000007','kabir.singh@example.test','Vijayawada','2025-04-01 10:20:00'),
('Mira','Krishna','2018-10-19','Female','9100000008','mira.krishna@example.test','Visakhapatnam','2025-04-15 12:00:00'),
('Aditya','Verma','1983-01-25','Male','9100000009','aditya.verma@example.test','Guntur','2025-05-07 16:40:00'),
('Nisha','Paul','1998-06-11','Female','9100000010','nisha.paul@example.test','Kakinada','2025-05-20 10:10:00');

INSERT INTO rooms (room_number, room_type, daily_rate, room_status) VALUES
('G101','General',1200,'Available'),
('G102','General',1200,'Available'),
('S201','Semi-Private',2200,'Occupied'),
('P301','Private',4000,'Occupied'),
('I401','ICU',8500,'Occupied'),
('P302','Private',4000,'Maintenance');

INSERT INTO appointments (patient_id, doctor_id, appointment_datetime, reason, status, consultation_fee) VALUES
(1,1,'2025-06-02 09:00:00','Chest discomfort','Completed',800),
(2,2,'2025-06-02 10:00:00','Routine child checkup','Completed',600),
(3,3,'2025-06-03 11:30:00','Knee pain','Completed',750),
(4,4,'2025-06-04 09:30:00','Fever and fatigue','Cancelled',500),
(5,4,'2025-06-05 15:00:00','Annual health check','No-show',500),
(6,5,'2025-06-06 12:00:00','Recurring headache','Completed',900),
(7,1,'2025-06-07 10:30:00','Blood pressure review','Scheduled',800),
(8,2,'2025-06-08 09:45:00','Seasonal allergy','Completed',600),
(9,3,'2025-06-09 14:00:00','Shoulder pain','Scheduled',750),
(10,5,'2025-06-10 16:00:00','Migraine follow-up','Completed',900),
(1,4,'2025-06-12 09:15:00','General follow-up','Scheduled',500),
(3,1,'2025-06-13 11:00:00','Cardiac screening','Cancelled',800);

INSERT INTO admissions (patient_id, room_id, attending_doctor_id, admission_date, discharge_date, admission_reason, status) VALUES
(1,5,1,'2025-05-01','2025-05-04','Cardiac observation','Discharged'),
(3,3,3,'2025-05-10','2025-05-15','Knee surgery recovery','Discharged'),
(4,4,4,'2025-06-01',NULL,'Monitoring and diagnostic tests','Admitted'),
(7,5,1,'2025-06-05',NULL,'Cardiac monitoring','Admitted'),
(6,2,5,'2025-04-20','2025-04-22','Neurological observation','Discharged');

INSERT INTO treatments (admission_id, treatment_name, treatment_date, description, cost) VALUES
(1,'ECG','2025-05-01','Electrocardiogram test',1200),
(1,'Blood Panel','2025-05-02','Routine laboratory tests',1800),
(2,'Physiotherapy','2025-05-12','Post-operative rehabilitation',3500),
(2,'X-Ray','2025-05-10','Knee imaging',1600),
(3,'Blood Panel','2025-06-01','Diagnostic blood tests',1800),
(3,'Ultrasound','2025-06-02','Abdominal imaging',2500),
(4,'ECG','2025-06-05','Cardiac monitoring test',1200),
(5,'Neurological Assessment','2025-04-20','Clinical assessment',2200);

INSERT INTO prescriptions (patient_id, doctor_id, appointment_id, prescribed_date, notes) VALUES
(1,1,1,'2025-06-02','Follow the care plan and attend follow-up'),
(2,2,2,'2025-06-02','Routine pediatric advice'),
(3,3,3,'2025-06-03','Rest and follow-up review'),
(6,5,6,'2025-06-06','Track symptoms and return for review'),
(8,2,8,'2025-06-08','Avoid known seasonal triggers');

INSERT INTO prescription_items (prescription_id, medicine_name, dosage, frequency, duration_days) VALUES
(1,'Medicine A','10 mg','Once daily',14),
(1,'Medicine B','One tablet','After meals',7),
(2,'Medicine C','5 ml','Twice daily',5),
(3,'Medicine D','250 mg','Twice daily',5),
(4,'Medicine E','One tablet','At bedtime',10),
(5,'Medicine F','10 mg','Once daily',7);

INSERT INTO bills (patient_id, appointment_id, admission_id, bill_date, amount, notes) VALUES
(1,1,NULL,'2025-06-02',800,'Consultation bill'),
(2,2,NULL,'2025-06-02',600,'Consultation bill'),
(3,3,NULL,'2025-06-03',750,'Consultation bill'),
(6,6,NULL,'2025-06-06',900,'Consultation bill'),
(8,8,NULL,'2025-06-08',600,'Consultation bill'),
(10,10,NULL,'2025-06-10',900,'Consultation bill'),
(1,NULL,1,'2025-05-04',16000,'Inpatient stay and tests'),
(3,NULL,2,'2025-05-15',28500,'Surgery recovery and treatment'),
(4,NULL,3,'2025-06-03',9000,'Current inpatient charges'),
(7,NULL,4,'2025-06-06',12500,'Cardiac monitoring charges'),
(6,NULL,5,'2025-04-22',11000,'Neurological observation');

INSERT INTO payments (bill_id, payment_date, amount, payment_method, payment_status, transaction_reference) VALUES
(1,'2025-06-02',800,'UPI','Successful','TXN-H001'),
(2,'2025-06-02',300,'Cash','Successful','TXN-H002'),
(3,'2025-06-03',750,'Card','Successful','TXN-H003'),
(4,'2025-06-06',900,'Insurance','Successful','TXN-H004'),
(5,'2025-06-08',600,'UPI','Successful','TXN-H005'),
(6,'2025-06-10',400,'Card','Successful','TXN-H006'),
(7,'2025-05-04',16000,'Insurance','Successful','TXN-H007'),
(8,'2025-05-15',20000,'Bank Transfer','Successful','TXN-H008'),
(9,'2025-06-03',3000,'UPI','Successful','TXN-H009'),
(10,'2025-06-06',5000,'Insurance','Pending','TXN-H010'),
(11,'2025-04-22',11000,'Card','Successful','TXN-H011');

INSERT INTO appointment_status_history (appointment_id, old_status, new_status, changed_at, remarks) VALUES
(1,NULL,'Scheduled','2025-05-25 09:00:00','Appointment created'),
(1,'Scheduled','Completed','2025-06-02 10:00:00','Consultation completed'),
(4,NULL,'Scheduled','2025-05-28 10:00:00','Appointment created'),
(4,'Scheduled','Cancelled','2025-06-03 15:00:00','Patient cancelled');

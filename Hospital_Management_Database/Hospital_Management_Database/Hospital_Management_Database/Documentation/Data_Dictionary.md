# Data Dictionary

## departments
| Column | Type | Meaning |
|---|---|---|
| department_id | INT, PK | Unique department identifier |
| department_name | VARCHAR(100), UNIQUE | Department name |
| location | VARCHAR(100) | Building/floor location |
| phone | VARCHAR(20) | Department contact |

## doctors
| Column | Type | Meaning |
|---|---|---|
| doctor_id | INT, PK | Unique doctor identifier |
| department_id | INT, FK | Doctor's department |
| first_name, last_name | VARCHAR(60) | Doctor's name |
| specialization | VARCHAR(100) | Clinical specialization |
| phone, email | VARCHAR | Unique contact details |
| consultation_fee | DECIMAL(10,2) | Standard consultation fee |
| hire_date | DATE | Employment start date |
| active | BOOLEAN | Whether the doctor is active |

## patients
| Column | Type | Meaning |
|---|---|---|
| patient_id | INT, PK | Unique patient identifier |
| first_name, last_name | VARCHAR(60) | Patient's name |
| date_of_birth | DATE | Birth date |
| gender | ENUM | Gender category |
| phone, email | VARCHAR | Unique contact details |
| city | VARCHAR(80) | Patient city |
| registered_at | DATETIME | Registration timestamp |

## rooms
| Column | Type | Meaning |
|---|---|---|
| room_id | INT, PK | Unique room identifier |
| room_number | VARCHAR(10), UNIQUE | Room label |
| room_type | ENUM | General, Semi-Private, Private, ICU |
| daily_rate | DECIMAL(10,2) | Daily room charge |
| room_status | ENUM | Available, Occupied, Maintenance |

## appointments
| Column | Type | Meaning |
|---|---|---|
| appointment_id | INT, PK | Unique appointment identifier |
| patient_id | INT, FK | Patient attending |
| doctor_id | INT, FK | Doctor assigned |
| appointment_datetime | DATETIME | Appointment date/time |
| reason | VARCHAR(255) | Visit reason |
| status | ENUM | Scheduled, Completed, Cancelled, No-show |
| consultation_fee | DECIMAL(10,2) | Fee snapshot for this appointment |
| created_at | DATETIME | Record creation timestamp |

## admissions
| Column | Type | Meaning |
|---|---|---|
| admission_id | INT, PK | Unique admission identifier |
| patient_id | INT, FK | Admitted patient |
| room_id | INT, FK | Assigned room |
| attending_doctor_id | INT, FK | Responsible doctor |
| admission_date, discharge_date | DATE | Stay dates |
| admission_reason | VARCHAR(255) | Reason for admission |
| status | ENUM | Admitted or Discharged |

## treatments
| Column | Type | Meaning |
|---|---|---|
| treatment_id | INT, PK | Unique treatment identifier |
| admission_id | INT, FK | Related admission |
| treatment_name | VARCHAR(150) | Procedure/test name |
| treatment_date | DATE | Date performed |
| description | VARCHAR(255) | Details |
| cost | DECIMAL(10,2) | Treatment cost |

## prescriptions and prescription_items
`prescriptions` stores the prescription header (patient, doctor, optional appointment, date, notes). `prescription_items` stores each medicine, dosage, frequency, and duration. One prescription can contain many items.

## bills
| Column | Type | Meaning |
|---|---|---|
| bill_id | INT, PK | Unique bill identifier |
| patient_id | INT, FK | Patient billed |
| appointment_id | INT, nullable FK | Appointment source, when applicable |
| admission_id | INT, nullable FK | Admission source, when applicable |
| bill_date | DATE | Issue date |
| amount | DECIMAL(10,2) | Total bill amount |
| notes | VARCHAR(255) | Bill description |

## payments
`payments` records each payment against a bill, including date, amount, method, status, and optional unique transaction reference. Only `Successful` payments count toward collected revenue.

## appointment_status_history
Stores the appointment ID, previous status, new status, timestamp, and remarks for status auditing.

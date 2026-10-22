# Hospital Management Database

A beginner-to-intermediate SQL project built with **MySQL 8.0+** to manage hospital departments, doctors, patients, appointments, admissions, treatments, prescriptions, billing, and payments.

## Project goals
- Model a realistic hospital workflow with relational tables and constraints.
- Practice primary keys, foreign keys, unique constraints, checks, joins, aggregates, subqueries, views, stored procedures, triggers, and indexes.
- Answer business questions about appointments, doctor workload, admissions, treatment costs, and revenue.

## Database scope
| Table | Purpose |
|---|---|
| `departments` | Hospital departments such as Cardiology and Pediatrics |
| `doctors` | Doctor profile, department, and consultation fee |
| `patients` | Patient demographics and contact details |
| `rooms` | Inpatient rooms, room type, and daily rate |
| `appointments` | Patient appointments with doctors and appointment status |
| `admissions` | Inpatient stays and assigned rooms |
| `treatments` | Treatments/procedures associated with an admission |
| `prescriptions` | Prescription header linked to a patient and doctor |
| `prescription_items` | Medicines and dosage details in a prescription |
| `bills` | Charges associated with an appointment or admission |
| `payments` | Payments made against bills |
| `appointment_status_history` | Audit trail of appointment status changes |

## Folder structure
```text
Hospital_Management_Database/
├── README.md
├── 00_Run_Order.txt
├── Database/
│   ├── 01_Create_Database.sql
│   ├── 02_Create_Tables.sql
│   ├── 03_Insert_Sample_Data.sql
│   └── 04_Constraints_Notes.sql
├── Indexes/05_Create_Indexes.sql
├── Views/06_Create_Views.sql
├── Stored_Procedures/07_Create_Procedures.sql
├── Triggers/08_Create_Triggers.sql
├── Analysis/
│   ├── 09_Patient_Analysis.sql
│   ├── 10_Appointment_Analysis.sql
│   ├── 11_Admission_Treatment_Analysis.sql
│   └── 12_Revenue_Analysis.sql
└── Documentation/
    ├── Business_Requirements.md
    ├── Data_Dictionary.md
    └── ER_Diagram.mmd
```

## How to run
Use MySQL Workbench or the MySQL command line. Execute files in the order shown in `00_Run_Order.txt`. The scripts use the database name `hospital_management_db`.

> The sample records are fictional and intended only for SQL practice. This is not a production-ready clinical system and contains no real patient data.

## Main relationships
- One department has many doctors.
- One patient can have many appointments, admissions, and prescriptions.
- One doctor can handle many appointments and write many prescriptions.
- One room can be used for many admissions over time, but an admission references one room.
- One admission can have many treatments.
- One prescription has many prescription items.
- One bill can have multiple payments.
- Appointment status changes are recorded in a history table.

## SQL concepts demonstrated
- DDL: `CREATE DATABASE`, `CREATE TABLE`, `ALTER TABLE`
- DML: `INSERT`, `UPDATE`
- Querying: filtering, sorting, joins, grouping, aggregate functions, subqueries
- Integrity: primary keys, foreign keys, `UNIQUE`, `NOT NULL`, `CHECK`
- Database objects: indexes, views, stored procedures, triggers
- Reporting: patient activity, appointment status, doctor workload, bed occupancy, treatment costs, revenue and outstanding balances

## Important assumptions
- Appointment statuses: `Scheduled`, `Completed`, `Cancelled`, `No-show`.
- Admission statuses: `Admitted`, `Discharged`.
- Bill status is derived from the total amount paid versus the bill amount in the views.
- A bill can relate to an appointment or an admission, but not both at once.
- Sample dates are fixed historical dates so reports return repeatable results.
- Medication and treatment details are simplified for learning purposes.

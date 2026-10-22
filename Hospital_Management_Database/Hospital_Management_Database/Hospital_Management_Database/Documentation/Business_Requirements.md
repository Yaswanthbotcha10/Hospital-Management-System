# Business Requirements

## Problem statement
A hospital needs a structured way to track patients, clinical staff, appointments, inpatient admissions, treatments, prescriptions, and payments. Separate spreadsheets can cause duplication and make reporting difficult.

## Objectives
1. Maintain patient and doctor information in related tables.
2. Organize doctors by department.
3. Schedule and track appointments and appointment status changes.
4. Track inpatient admissions, room assignments, and treatment costs.
5. Store prescriptions and their medicine instructions.
6. Issue bills and record payments.
7. Generate operational and financial reports using SQL.

## Users
- Receptionist: registers patients and schedules appointments.
- Doctor: reviews appointments and creates prescriptions.
- Ward administrator: tracks admissions and room assignments.
- Billing staff: creates bills and records payments.
- Hospital manager: reviews workload, occupancy, and revenue reports.

## Functional requirements
- Each doctor belongs to one department.
- Each appointment belongs to one patient and one doctor.
- Appointment status must be one of the supported values.
- Each admission belongs to one patient, one room, and one attending doctor.
- Treatments must be linked to an admission.
- A prescription may contain multiple medicine items.
- A bill belongs to a patient and must refer to either an appointment or an admission.
- Payments are recorded against bills.
- Appointment status changes should be audited.

## Non-functional / learning requirements
- Use primary and foreign keys to preserve referential integrity.
- Add indexes to common filtering and join columns.
- Use views to simplify repeated reports.
- Use procedures for reusable operations.
- Use triggers to audit status changes and reject overpayments.
- Keep sample data fictional.

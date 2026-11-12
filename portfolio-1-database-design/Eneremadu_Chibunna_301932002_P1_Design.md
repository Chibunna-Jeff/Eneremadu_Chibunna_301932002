# Hospital / Clinic System — database design

My case study records patient, clinician, appointment.

## Users

- Clinic reception staff
- Clinicians
- Clinic administrators

## Main operations

- Register patients and clinicians using synthetic records.
- Schedule, reschedule, cancel, and review appointments.
- Benchmark plan: compare a date-range search with and without the scheduled_at B-tree index on the same synthetic 20,000-row appointment dataset; verify identical results and record the measurement method without presuming an outcome.

## Entities

| Entity | Information stored |
| --- | --- |
| patient | Stores a clinic patient's basic synthetic identity. |
| clinician | Stores a clinician's basic synthetic directory information. |
| appointment | Records a scheduled encounter between one patient and one clinician. |

## patient

| Field | Type | Key | Required |
| --- | --- | --- | --- |
| patient_id | BIGINT | PK | Yes |
| medical_record_number | TEXT | Unique | Yes |
| full_name | TEXT |  | Yes |
| birth_date | DATE |  | Yes |
- Unique key: (medical_record_number).

## clinician

| Field | Type | Key | Required |
| --- | --- | --- | --- |
| clinician_id | BIGINT | PK | Yes |
| display_name | TEXT |  | Yes |
| specialty | TEXT |  | Yes |
| active | BOOLEAN |  | Yes |


## appointment

| Field | Type | Key | Required |
| --- | --- | --- | --- |
| appointment_id | BIGINT | PK | Yes |
| patient_id | BIGINT | FK | Yes |
| clinician_id | BIGINT | FK | Yes |
| scheduled_at | TIMESTAMPTZ |  | Yes |
| status | TEXT |  | Yes |
| reason | TEXT |  | No |
- patient_id → patient.patient_id
- clinician_id → clinician.clinician_id

## Relationships and business rules

- Every patient must have a distinct medical record number.
- Every appointment must reference an existing patient.
- Every appointment must reference an existing clinician.
- Appointment status must be scheduled, completed, or cancelled.
- A clinician may have at most one non-cancelled appointment at an exact scheduled timestamp.

## Assumptions

- Each appointment has exactly one patient and one clinician.
- Appointment status is scheduled, completed, or cancelled.
- For this exercise, a clinician can have at most one non-cancelled appointment at an exact scheduled timestamp.
- All timestamps use UTC; all names, dates, and records are synthetic.


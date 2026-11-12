# Hospital / Clinic System — normalisation

The example uses the saved sample records. The full set of fields is in the design and schema.

## Starting grouped records

| patient_id | appointment records (list) |
| --- | --- |
| 1101 | [3301] |


The record IDs are grouped in a list. In 1NF, each record has its own row and each cell holds one value.

## 1NF: one value per cell

| appointment.appointment_id | appointment.patient_id | appointment.clinician_id | appointment.status | patient.patient_id | patient.medical_record_number | clinician.clinician_id | clinician.display_name |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 3301 | 1101 | 2201 | scheduled | 1101 | SYN-MRN-1101 | 2201 | Jordan Sample |

Key: appointment_id.

## 2NF: depend on the whole key

The declared candidate keys do not introduce a partial dependency here, so the 1NF rows stay unchanged at this step.

## appointment_example

| appointment.appointment_id | appointment.patient_id | appointment.clinician_id | appointment.status | patient.patient_id | patient.medical_record_number | clinician.clinician_id | clinician.display_name |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 3301 | 1101 | 2201 | scheduled | 1101 | SYN-MRN-1101 | 2201 | Jordan Sample |

## 3NF: store each entity’s details once

The entity keys determine their own descriptions. Related records keep foreign keys rather than repeating those descriptions.

## patient

| patient_id | medical_record_number | full_name | birth_date |
| --- | --- | --- | --- |
| 1101 | SYN-MRN-1101 | Avery Example | 1985-04-12 |

## clinician

| clinician_id | display_name | specialty | active |
| --- | --- | --- | --- |
| 2201 | Jordan Sample | Family Medicine | true |

## appointment

| appointment_id | patient_id | clinician_id | scheduled_at | status | reason |
| --- | --- | --- | --- | --- | --- |
| 3301 | 1101 | 2201 | 2030-04-15T09:00:00+00:00 | scheduled | Routine synthetic consultation |

## Dependencies

- patient: (patient_id) → medical_record_number, full_name, birth_date
- clinician: (clinician_id) → display_name, specialty, active
- appointment: (appointment_id) → patient_id, clinician_id, scheduled_at, status, reason

Joining the decomposed sample tables reproduces the original 1 example rows. The design assumes the declared keys describe the relevant business dependencies.

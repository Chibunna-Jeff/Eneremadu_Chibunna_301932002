-- Fictional sample records for Hospital / Clinic System.
BEGIN;
SET LOCAL standard_conforming_strings = on;
INSERT INTO portfolio."patient" ("patient_id", "medical_record_number", "full_name", "birth_date") VALUES (1101, 'SYN-MRN-1101', 'Avery Example', '1985-04-12');
INSERT INTO portfolio."clinician" ("clinician_id", "display_name", "specialty", "active") VALUES (2201, 'Jordan Sample', 'Family Medicine', TRUE);
INSERT INTO portfolio."appointment" ("appointment_id", "patient_id", "clinician_id", "scheduled_at", "status", "reason") VALUES (3301, 1101, 2201, '2030-04-15T09:00:00Z', 'scheduled', 'Routine synthetic consultation');
COMMIT;

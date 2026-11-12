-- Run these deliberately invalid statements one at a time, outside a transaction.
-- Each should fail at the named constraint; the sample rows should remain unchanged.

-- 1. patient pk. Expected: pk_patient, SQLSTATE 23505.
INSERT INTO portfolio."patient" ("patient_id", "medical_record_number", "full_name", "birth_date")
VALUES (1101, 'SYN-MRN-9001', 'Case Patient', '1986-05-13');

-- 2. patient unique. Expected: uq_patient_0, SQLSTATE 23505.
INSERT INTO portfolio."patient" ("patient_id", "medical_record_number", "full_name", "birth_date")
VALUES (9002, 'SYN-MRN-1101', 'Case Patient', '1986-05-13');

-- 3. patient null id. Expected: patient_id, SQLSTATE 23502.
INSERT INTO portfolio."patient" ("patient_id", "medical_record_number", "full_name", "birth_date")
VALUES (NULL, 'SYN-MRN-9003', 'Case Patient', '1986-05-13');

-- 4. patient null mrn. Expected: medical_record_number, SQLSTATE 23502.
INSERT INTO portfolio."patient" ("patient_id", "medical_record_number", "full_name", "birth_date")
VALUES (9004, NULL, 'Case Patient', '1986-05-13');

-- 5. patient null name. Expected: full_name, SQLSTATE 23502.
INSERT INTO portfolio."patient" ("patient_id", "medical_record_number", "full_name", "birth_date")
VALUES (9005, 'SYN-MRN-9005', NULL, '1986-05-13');

-- 6. patient null birth. Expected: birth_date, SQLSTATE 23502.
INSERT INTO portfolio."patient" ("patient_id", "medical_record_number", "full_name", "birth_date")
VALUES (9006, 'SYN-MRN-9006', 'Case Patient', NULL);

-- 7. clinician pk. Expected: pk_clinician, SQLSTATE 23505.
INSERT INTO portfolio."clinician" ("clinician_id", "display_name", "specialty", "active")
VALUES (2201, 'Case Clinician', 'General Practice', TRUE);

-- 8. clinician null id. Expected: clinician_id, SQLSTATE 23502.
INSERT INTO portfolio."clinician" ("clinician_id", "display_name", "specialty", "active")
VALUES (NULL, 'Case Clinician', 'General Practice', TRUE);

-- 9. clinician null name. Expected: display_name, SQLSTATE 23502.
INSERT INTO portfolio."clinician" ("clinician_id", "display_name", "specialty", "active")
VALUES (9008, NULL, 'General Practice', TRUE);

-- 10. clinician null specialty. Expected: specialty, SQLSTATE 23502.
INSERT INTO portfolio."clinician" ("clinician_id", "display_name", "specialty", "active")
VALUES (9009, 'Case Clinician', NULL, TRUE);

-- 11. clinician null active. Expected: active, SQLSTATE 23502.
INSERT INTO portfolio."clinician" ("clinician_id", "display_name", "specialty", "active")
VALUES (9010, 'Case Clinician', 'General Practice', NULL);

-- 12. appointment pk. Expected: pk_appointment, SQLSTATE 23505.
INSERT INTO portfolio."appointment" ("appointment_id", "patient_id", "clinician_id", "scheduled_at", "status", "reason")
VALUES (3301, 1101, 2201, '2030-04-15T10:00:00Z', 'scheduled', 'Primary key test');

-- 13. appointment fk patient. Expected: fk_appointment_0, SQLSTATE 23503.
INSERT INTO portfolio."appointment" ("appointment_id", "patient_id", "clinician_id", "scheduled_at", "status", "reason")
VALUES (9012, 90120, 2201, '2030-04-15T11:00:00Z', 'scheduled', 'Foreign key test');

-- 14. appointment fk clinician. Expected: fk_appointment_1, SQLSTATE 23503.
INSERT INTO portfolio."appointment" ("appointment_id", "patient_id", "clinician_id", "scheduled_at", "status", "reason")
VALUES (9013, 1101, 90130, '2030-04-15T12:00:00Z', 'scheduled', 'Foreign key test');

-- 15. appointment null id. Expected: appointment_id, SQLSTATE 23502.
INSERT INTO portfolio."appointment" ("appointment_id", "patient_id", "clinician_id", "scheduled_at", "status", "reason")
VALUES (NULL, 1101, 2201, '2030-04-15T13:00:00Z', 'scheduled', 'Not null test');

-- 16. appointment null patient. Expected: patient_id, SQLSTATE 23502.
INSERT INTO portfolio."appointment" ("appointment_id", "patient_id", "clinician_id", "scheduled_at", "status", "reason")
VALUES (9015, NULL, 2201, '2030-04-15T14:00:00Z', 'scheduled', 'Not null test');

-- 17. appointment null clinician. Expected: clinician_id, SQLSTATE 23502.
INSERT INTO portfolio."appointment" ("appointment_id", "patient_id", "clinician_id", "scheduled_at", "status", "reason")
VALUES (9016, 1101, NULL, '2030-04-15T15:00:00Z', 'scheduled', 'Not null test');

-- 18. appointment null time. Expected: scheduled_at, SQLSTATE 23502.
INSERT INTO portfolio."appointment" ("appointment_id", "patient_id", "clinician_id", "scheduled_at", "status", "reason")
VALUES (9017, 1101, 2201, NULL, 'scheduled', 'Not null test');

-- 19. appointment null status. Expected: status, SQLSTATE 23502.
INSERT INTO portfolio."appointment" ("appointment_id", "patient_id", "clinician_id", "scheduled_at", "status", "reason")
VALUES (9018, 1101, 2201, '2030-04-15T16:00:00Z', NULL, 'Not null test');

-- 20. appointment check status. Expected: appointment_status_valid, SQLSTATE 23514.
INSERT INTO portfolio."appointment" ("appointment_id", "patient_id", "clinician_id", "scheduled_at", "status", "reason")
VALUES (9019, 1101, 2201, '2030-04-15T17:00:00Z', 'pending', 'Check test');

-- 21. appointment partial unique. Expected: clinician_time_unique, SQLSTATE 23505.
INSERT INTO portfolio."appointment" ("appointment_id", "patient_id", "clinician_id", "scheduled_at", "status", "reason")
VALUES (9020, 1101, 2201, '2030-04-15T09:00:00Z', 'scheduled', 'Partial unique test');

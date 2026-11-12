-- Show related patient, appointment records (up to 20).
SELECT t0."patient_id" AS "patient_patient_id",
       t0."medical_record_number" AS "patient_medical_record_number",
       t1."appointment_id" AS "appointment_appointment_id",
       t1."scheduled_at" AS "appointment_scheduled_at"
FROM portfolio."patient" t0
JOIN portfolio."appointment" t1 ON t1."patient_id" = t0."patient_id"
ORDER BY t0."patient_id", t1."appointment_id"
LIMIT 20;

EXPLAIN (ANALYZE, BUFFERS, FORMAT JSON)
SELECT t0."patient_id" AS "patient_patient_id",
       t0."medical_record_number" AS "patient_medical_record_number",
       t1."appointment_id" AS "appointment_appointment_id",
       t1."scheduled_at" AS "appointment_scheduled_at"
FROM portfolio."patient" t0
JOIN portfolio."appointment" t1 ON t1."patient_id" = t0."patient_id"
ORDER BY t0."patient_id", t1."appointment_id"
LIMIT 20;

-- Find appointment records where scheduled_at matches "2030-04-15T09:00:00Z" (up to 20).
SELECT * FROM portfolio."appointment"
WHERE "scheduled_at" IS NOT DISTINCT FROM '2030-04-15T09:00:00Z'
ORDER BY "appointment_id"
LIMIT 20;

EXPLAIN (ANALYZE, BUFFERS, FORMAT JSON)
SELECT * FROM portfolio."appointment"
WHERE "scheduled_at" IS NOT DISTINCT FROM '2030-04-15T09:00:00Z'
ORDER BY "appointment_id"
LIMIT 20;

-- Count appointment records for each patient_id (up to 20 groups).
SELECT "patient_id", count(*) AS record_count
FROM portfolio."appointment"
GROUP BY "patient_id"
ORDER BY record_count DESC, "patient_id" NULLS LAST
LIMIT 20;

EXPLAIN (ANALYZE, BUFFERS, FORMAT JSON)
SELECT "patient_id", count(*) AS record_count
FROM portfolio."appointment"
GROUP BY "patient_id"
ORDER BY record_count DESC, "patient_id" NULLS LAST
LIMIT 20;

# Hospital / Clinic System — SQL queries

## 1. Show related patient, appointment records (up to 20).

```sql
SELECT t0."patient_id" AS "patient_patient_id",
       t0."medical_record_number" AS "patient_medical_record_number",
       t1."appointment_id" AS "appointment_appointment_id",
       t1."scheduled_at" AS "appointment_scheduled_at"
FROM portfolio."patient" t0
JOIN portfolio."appointment" t1 ON t1."patient_id" = t0."patient_id"
ORDER BY t0."patient_id", t1."appointment_id"
LIMIT 20;
```

| patient_patient_id | patient_medical_record_number | appointment_appointment_id | appointment_scheduled_at |
| --- | --- | --- | --- |
| 1101 | SYN-MRN-1101 | 3301 | 2030-04-15T09:00:00+00:00 |

## 2. Find appointment records where scheduled_at matches "2030-04-15T09:00:00Z" (up to 20).

```sql
SELECT * FROM portfolio."appointment"
WHERE "scheduled_at" IS NOT DISTINCT FROM '2030-04-15T09:00:00Z'
ORDER BY "appointment_id"
LIMIT 20;
```

| appointment_id | patient_id | clinician_id | scheduled_at | status | reason |
| --- | --- | --- | --- | --- | --- |
| 3301 | 1101 | 2201 | 2030-04-15T09:00:00+00:00 | scheduled | Routine synthetic consultation |

## 3. Count appointment records for each patient_id (up to 20 groups).

```sql
SELECT "patient_id", count(*) AS record_count
FROM portfolio."appointment"
GROUP BY "patient_id"
ORDER BY record_count DESC, "patient_id" NULLS LAST
LIMIT 20;
```

| patient_id | record_count |
| --- | --- |
| 1101 | 1 |


## Index comparison

| Phase | Median (ms) | Three runs (ms) | Plan nodes | Buffer hits |
| --- | --- | --- | --- | --- |
| Before index | 0.989 | 0.989, 0.989, 0.989 | Sort → Seq Scan | 112 |
| After index | 0.17 | 0.166, 0.17, 0.171 | Sort → Bitmap Heap Scan → Bitmap Index Scan | 25 |

The median execution time changed from 0.989 ms to 0.17 ms. The measured plan used p2_filter_idx. The results matched in both phases. An index adds storage and write-maintenance costs; timings depend on the selected lookup and environment.

## Execution plans

### Before index, run 1

```text
Sort (actual time=0.959..0.96 rows=20 loops=1)
  Seq Scan on appointment (actual time=0.013..0.925 rows=20 loops=1)
Planning Time: 0.327 ms
Execution Time: 0.989 ms
```

### Before index, run 2

```text
Sort (actual time=0.96..0.962 rows=20 loops=1)
  Seq Scan on appointment (actual time=0.013..0.927 rows=20 loops=1)
Planning Time: 0.32 ms
Execution Time: 0.989 ms
```

### Before index, run 3

```text
Sort (actual time=0.96..0.961 rows=20 loops=1)
  Seq Scan on appointment (actual time=0.014..0.927 rows=20 loops=1)
Planning Time: 0.348 ms
Execution Time: 0.989 ms
```

### After index, run 1

```text
Sort (actual time=0.115..0.116 rows=20 loops=1)
  Bitmap Heap Scan on appointment (actual time=0.025..0.081 rows=20 loops=1)
    Bitmap Index Scan using p2_filter_idx (actual time=0.013..0.014 rows=20 loops=1)
Planning Time: 0.578 ms
Execution Time: 0.166 ms
```

### After index, run 2

```text
Sort (actual time=0.116..0.118 rows=20 loops=1)
  Bitmap Heap Scan on appointment (actual time=0.025..0.083 rows=20 loops=1)
    Bitmap Index Scan using p2_filter_idx (actual time=0.013..0.013 rows=20 loops=1)
Planning Time: 0.549 ms
Execution Time: 0.17 ms
```

### After index, run 3

```text
Sort (actual time=0.118..0.119 rows=20 loops=1)
  Bitmap Heap Scan on appointment (actual time=0.026..0.083 rows=20 loops=1)
    Bitmap Index Scan using p2_filter_idx (actual time=0.013..0.014 rows=20 loops=1)
Planning Time: 0.571 ms
Execution Time: 0.171 ms
```

## Reproduce

Use a fresh database with the Portfolio 1 schema and sample data. Run Eneremadu_Chibunna_301932002_P2_Queries.sql, then Eneremadu_Chibunna_301932002_P2_Optimisation.sql. The optimisation script creates a separate performance table and runs EXPLAIN (ANALYZE, BUFFERS).

[Query screenshot](screenshots/Eneremadu_Chibunna_301932002_P2_QueryResults.png) · [Index comparison](screenshots/Eneremadu_Chibunna_301932002_P2_IndexComparison.png)

## References

- [PostgreSQL — EXPLAIN](https://www.postgresql.org/docs/17/using-explain.html)


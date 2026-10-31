# Hotel Reservation System — SQL queries

## 1. Show related reservation, guest, room, hotel records (up to 20).

```sql
SELECT t0."reservation_id" AS "reservation_reservation_id",
       t0."booking_ref" AS "reservation_booking_ref",
       t1."guest_id" AS "guest_guest_id",
       t1."full_name" AS "guest_full_name",
       t2."room_id" AS "room_room_id",
       t2."room_number" AS "room_room_number",
       t3."hotel_id" AS "hotel_hotel_id",
       t3."name" AS "hotel_name"
FROM portfolio."reservation" t0
JOIN portfolio."guest" t1 ON t0."guest_id" = t1."guest_id"
JOIN portfolio."room" t2 ON t0."room_id" = t2."room_id"
JOIN portfolio."hotel" t3 ON t2."hotel_id" = t3."hotel_id"
ORDER BY t0."reservation_id", t1."guest_id", t2."room_id", t3."hotel_id"
LIMIT 20;
```

| reservation_reservation_id | reservation_booking_ref | guest_guest_id | guest_full_name | room_room_id | room_room_number | hotel_hotel_id | hotel_name |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 401 | BK-1001 | 301 | Avery Morgan | 201 | 101 | 101 | Harbor Hotel |
| 402 | BK-1002 | 302 | Jordan Lee | 202 | 12A | 102 | Pine Lodge |

## 2. Find reservation records where check_in_date matches "2026-11-10" (up to 20).

```sql
SELECT * FROM portfolio."reservation"
WHERE "check_in_date" IS NOT DISTINCT FROM '2026-11-10'
ORDER BY "reservation_id"
LIMIT 20;
```

| reservation_id | guest_id | room_id | booking_ref | check_in_date | check_out_date | status | created_at |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 401 | 301 | 201 | BK-1001 | 2026-11-10 | 2026-11-13 | confirmed | 2026-10-20T14:30:00+00:00 |

## 3. Count reservation records for each guest_id (up to 20 groups).

```sql
SELECT "guest_id", count(*) AS record_count
FROM portfolio."reservation"
GROUP BY "guest_id"
ORDER BY record_count DESC, "guest_id" NULLS LAST
LIMIT 20;
```

| guest_id | record_count |
| --- | --- |
| 301 | 1 |
| 302 | 1 |


## Index comparison

| Phase | Median (ms) | Three runs (ms) | Plan nodes | Buffer hits |
| --- | --- | --- | --- | --- |
| Before index | 0.88 | 0.933, 0.812, 0.88 | Sort → Seq Scan | 112 |
| After index | 0.174 | 0.177, 0.174, 0.168 | Sort → Bitmap Heap Scan → Bitmap Index Scan | 25 |

The median execution time changed from 0.88 ms to 0.174 ms. The measured plan used p2_filter_idx. The results matched in both phases. An index adds storage and write-maintenance costs; timings depend on the selected lookup and environment.

## Execution plans

### Before index, run 1

```text
Sort (actual time=0.906..0.908 rows=20 loops=1)
  Seq Scan on reservation (actual time=0.015..0.87 rows=20 loops=1)
Planning Time: 0.341 ms
Execution Time: 0.933 ms
```

### Before index, run 2

```text
Sort (actual time=0.785..0.786 rows=20 loops=1)
  Seq Scan on reservation (actual time=0.015..0.75 rows=20 loops=1)
Planning Time: 0.338 ms
Execution Time: 0.812 ms
```

### Before index, run 3

```text
Sort (actual time=0.852..0.854 rows=20 loops=1)
  Seq Scan on reservation (actual time=0.015..0.819 rows=20 loops=1)
Planning Time: 0.317 ms
Execution Time: 0.88 ms
```

### After index, run 1

```text
Sort (actual time=0.128..0.129 rows=20 loops=1)
  Bitmap Heap Scan on reservation (actual time=0.028..0.093 rows=20 loops=1)
    Bitmap Index Scan using p2_filter_idx (actual time=0.015..0.016 rows=20 loops=1)
Planning Time: 0.537 ms
Execution Time: 0.177 ms
```

### After index, run 2

```text
Sort (actual time=0.128..0.13 rows=20 loops=1)
  Bitmap Heap Scan on reservation (actual time=0.028..0.094 rows=20 loops=1)
    Bitmap Index Scan using p2_filter_idx (actual time=0.015..0.015 rows=20 loops=1)
Planning Time: 0.537 ms
Execution Time: 0.174 ms
```

### After index, run 3

```text
Sort (actual time=0.123..0.125 rows=20 loops=1)
  Bitmap Heap Scan on reservation (actual time=0.028..0.09 rows=20 loops=1)
    Bitmap Index Scan using p2_filter_idx (actual time=0.015..0.016 rows=20 loops=1)
Planning Time: 0.63 ms
Execution Time: 0.168 ms
```

## Reproduce

Use a fresh database with the Portfolio 1 schema and sample data. Run Adewumi_yinka_301902434_P2_Queries.sql, then Adewumi_yinka_301902434_P2_Optimisation.sql. The optimisation script creates a separate performance table and runs EXPLAIN (ANALYZE, BUFFERS).

[Query screenshot](screenshots/Adewumi_yinka_301902434_P2_QueryResults.png) · [Index comparison](screenshots/Adewumi_yinka_301902434_P2_IndexComparison.png)

## References

- [PostgreSQL — EXPLAIN](https://www.postgresql.org/docs/17/using-explain.html)


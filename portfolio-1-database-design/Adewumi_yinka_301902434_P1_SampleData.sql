-- Fictional sample records for Hotel Reservation System.
BEGIN;
SET LOCAL standard_conforming_strings = on;
INSERT INTO portfolio."hotel" ("hotel_id", "name", "city", "star_rating") VALUES (101, 'Harbor Hotel', 'Portland', 4);
INSERT INTO portfolio."hotel" ("hotel_id", "name", "city", "star_rating") VALUES (102, 'Pine Lodge', 'Bend', 3);
INSERT INTO portfolio."guest" ("guest_id", "full_name", "email", "phone") VALUES (301, 'Avery Morgan', 'avery.morgan@example.test', '+1-503-555-0142');
INSERT INTO portfolio."guest" ("guest_id", "full_name", "email", "phone") VALUES (302, 'Jordan Lee', 'jordan.lee@example.test', NULL);
INSERT INTO portfolio."room" ("room_id", "hotel_id", "room_number", "capacity", "nightly_rate", "is_active") VALUES (201, 101, '101', 2, 145.5, TRUE);
INSERT INTO portfolio."room" ("room_id", "hotel_id", "room_number", "capacity", "nightly_rate", "is_active") VALUES (202, 102, '12A', 3, 189, TRUE);
INSERT INTO portfolio."reservation" ("reservation_id", "guest_id", "room_id", "booking_ref", "check_in_date", "check_out_date", "status", "created_at") VALUES (401, 301, 201, 'BK-1001', '2026-11-10', '2026-11-13', 'confirmed', '2026-10-20T14:30:00Z');
INSERT INTO portfolio."reservation" ("reservation_id", "guest_id", "room_id", "booking_ref", "check_in_date", "check_out_date", "status", "created_at") VALUES (402, 302, 202, 'BK-1002', '2026-12-02', '2026-12-05', 'pending', '2026-10-21T09:15:00+00:00');
COMMIT;

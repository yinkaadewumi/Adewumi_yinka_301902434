-- Run these deliberately invalid statements one at a time, outside a transaction.
-- Each should fail at the named constraint; the sample rows should remain unchanged.

-- 1. hotel pk. Expected: pk_hotel, SQLSTATE 23505.
INSERT INTO portfolio."hotel" ("hotel_id", "name", "city", "star_rating")
VALUES (101, 'Cedar House', 'Salem', 2);

-- 2. hotel hotel id not null. Expected: hotel_id, SQLSTATE 23502.
INSERT INTO portfolio."hotel" ("hotel_id", "name", "city", "star_rating")
VALUES (NULL, 'Maple Inn', 'Salem', 2);

-- 3. hotel name not null. Expected: name, SQLSTATE 23502.
INSERT INTO portfolio."hotel" ("hotel_id", "name", "city", "star_rating")
VALUES (501, NULL, 'Salem', 2);

-- 4. hotel city not null. Expected: city, SQLSTATE 23502.
INSERT INTO portfolio."hotel" ("hotel_id", "name", "city", "star_rating")
VALUES (502, 'Maple Inn', NULL, 2);

-- 5. hotel star rating not null. Expected: star_rating, SQLSTATE 23502.
INSERT INTO portfolio."hotel" ("hotel_id", "name", "city", "star_rating")
VALUES (503, 'Maple Inn', 'Salem', NULL);

-- 6. hotel rating check. Expected: hotel_rating_range, SQLSTATE 23514.
INSERT INTO portfolio."hotel" ("hotel_id", "name", "city", "star_rating")
VALUES (504, 'Summit Inn', 'Eugene', 6);

-- 7. room pk. Expected: pk_room, SQLSTATE 23505.
INSERT INTO portfolio."room" ("room_id", "hotel_id", "room_number", "capacity", "nightly_rate", "is_active")
VALUES (201, 102, '99', 1, 99, TRUE);

-- 8. room unique. Expected: uq_room_0, SQLSTATE 23505.
INSERT INTO portfolio."room" ("room_id", "hotel_id", "room_number", "capacity", "nightly_rate", "is_active")
VALUES (505, 101, '101', 1, 99, TRUE);

-- 9. room fk. Expected: fk_room_0, SQLSTATE 23503.
INSERT INTO portfolio."room" ("room_id", "hotel_id", "room_number", "capacity", "nightly_rate", "is_active")
VALUES (506, 999999, '77', 1, 99, TRUE);

-- 10. room room id not null. Expected: room_id, SQLSTATE 23502.
INSERT INTO portfolio."room" ("room_id", "hotel_id", "room_number", "capacity", "nightly_rate", "is_active")
VALUES (NULL, 101, '88', 1, 99, TRUE);

-- 11. room hotel id not null. Expected: hotel_id, SQLSTATE 23502.
INSERT INTO portfolio."room" ("room_id", "hotel_id", "room_number", "capacity", "nightly_rate", "is_active")
VALUES (507, NULL, '88', 1, 99, TRUE);

-- 12. room room number not null. Expected: room_number, SQLSTATE 23502.
INSERT INTO portfolio."room" ("room_id", "hotel_id", "room_number", "capacity", "nightly_rate", "is_active")
VALUES (508, 101, NULL, 1, 99, TRUE);

-- 13. room capacity not null. Expected: capacity, SQLSTATE 23502.
INSERT INTO portfolio."room" ("room_id", "hotel_id", "room_number", "capacity", "nightly_rate", "is_active")
VALUES (509, 101, '88', NULL, 99, TRUE);

-- 14. room nightly rate not null. Expected: nightly_rate, SQLSTATE 23502.
INSERT INTO portfolio."room" ("room_id", "hotel_id", "room_number", "capacity", "nightly_rate", "is_active")
VALUES (510, 101, '88', 1, NULL, TRUE);

-- 15. room is active not null. Expected: is_active, SQLSTATE 23502.
INSERT INTO portfolio."room" ("room_id", "hotel_id", "room_number", "capacity", "nightly_rate", "is_active")
VALUES (511, 101, '88', 1, 99, NULL);

-- 16. guest pk. Expected: pk_guest, SQLSTATE 23505.
INSERT INTO portfolio."guest" ("guest_id", "full_name", "email", "phone")
VALUES (301, 'Casey Reed', 'casey.reed@example.test', NULL);

-- 17. guest unique. Expected: uq_guest_0, SQLSTATE 23505.
INSERT INTO portfolio."guest" ("guest_id", "full_name", "email", "phone")
VALUES (512, 'Avery Morgan Duplicate', 'avery.morgan@example.test', NULL);

-- 18. guest guest id not null. Expected: guest_id, SQLSTATE 23502.
INSERT INTO portfolio."guest" ("guest_id", "full_name", "email", "phone")
VALUES (NULL, 'Casey Reed', 'casey.reed@example.test', NULL);

-- 19. guest full name not null. Expected: full_name, SQLSTATE 23502.
INSERT INTO portfolio."guest" ("guest_id", "full_name", "email", "phone")
VALUES (513, NULL, 'casey.reed@example.test', NULL);

-- 20. guest email not null. Expected: email, SQLSTATE 23502.
INSERT INTO portfolio."guest" ("guest_id", "full_name", "email", "phone")
VALUES (514, 'Casey Reed', NULL, NULL);

-- 21. reservation pk. Expected: pk_reservation, SQLSTATE 23505.
INSERT INTO portfolio."reservation" ("reservation_id", "guest_id", "room_id", "booking_ref", "check_in_date", "check_out_date", "status", "created_at")
VALUES (401, 302, 202, 'BK-2001', '2027-01-10', '2027-01-12', 'confirmed', '2026-10-22T11:00:00Z');

-- 22. reservation unique. Expected: uq_reservation_0, SQLSTATE 23505.
INSERT INTO portfolio."reservation" ("reservation_id", "guest_id", "room_id", "booking_ref", "check_in_date", "check_out_date", "status", "created_at")
VALUES (515, 301, 201, 'BK-1001', '2027-01-10', '2027-01-12', 'confirmed', '2026-10-22T11:00:00Z');

-- 23. reservation guest fk. Expected: fk_reservation_0, SQLSTATE 23503.
INSERT INTO portfolio."reservation" ("reservation_id", "guest_id", "room_id", "booking_ref", "check_in_date", "check_out_date", "status", "created_at")
VALUES (516, 999999, 201, 'BK-2002', '2027-01-10', '2027-01-12', 'confirmed', '2026-10-22T11:00:00Z');

-- 24. reservation room fk. Expected: fk_reservation_1, SQLSTATE 23503.
INSERT INTO portfolio."reservation" ("reservation_id", "guest_id", "room_id", "booking_ref", "check_in_date", "check_out_date", "status", "created_at")
VALUES (517, 301, 999999, 'BK-2003', '2027-01-10', '2027-01-12', 'confirmed', '2026-10-22T11:00:00Z');

-- 25. reservation reservation id not null. Expected: reservation_id, SQLSTATE 23502.
INSERT INTO portfolio."reservation" ("reservation_id", "guest_id", "room_id", "booking_ref", "check_in_date", "check_out_date", "status", "created_at")
VALUES (NULL, 301, 201, 'BK-2004', '2027-01-10', '2027-01-12', 'confirmed', '2026-10-22T11:00:00Z');

-- 26. reservation guest id not null. Expected: guest_id, SQLSTATE 23502.
INSERT INTO portfolio."reservation" ("reservation_id", "guest_id", "room_id", "booking_ref", "check_in_date", "check_out_date", "status", "created_at")
VALUES (518, NULL, 201, 'BK-2005', '2027-01-10', '2027-01-12', 'confirmed', '2026-10-22T11:00:00Z');

-- 27. reservation room id not null. Expected: room_id, SQLSTATE 23502.
INSERT INTO portfolio."reservation" ("reservation_id", "guest_id", "room_id", "booking_ref", "check_in_date", "check_out_date", "status", "created_at")
VALUES (519, 301, NULL, 'BK-2006', '2027-01-10', '2027-01-12', 'confirmed', '2026-10-22T11:00:00Z');

-- 28. reservation booking ref not null. Expected: booking_ref, SQLSTATE 23502.
INSERT INTO portfolio."reservation" ("reservation_id", "guest_id", "room_id", "booking_ref", "check_in_date", "check_out_date", "status", "created_at")
VALUES (520, 301, 201, NULL, '2027-01-10', '2027-01-12', 'confirmed', '2026-10-22T11:00:00Z');

-- 29. reservation check in date not null. Expected: check_in_date, SQLSTATE 23502.
INSERT INTO portfolio."reservation" ("reservation_id", "guest_id", "room_id", "booking_ref", "check_in_date", "check_out_date", "status", "created_at")
VALUES (521, 301, 201, 'BK-2007', NULL, '2027-01-12', 'confirmed', '2026-10-22T11:00:00Z');

-- 30. reservation check out date not null. Expected: check_out_date, SQLSTATE 23502.
INSERT INTO portfolio."reservation" ("reservation_id", "guest_id", "room_id", "booking_ref", "check_in_date", "check_out_date", "status", "created_at")
VALUES (522, 301, 201, 'BK-2008', '2027-01-10', NULL, 'confirmed', '2026-10-22T11:00:00Z');

-- 31. reservation status not null. Expected: status, SQLSTATE 23502.
INSERT INTO portfolio."reservation" ("reservation_id", "guest_id", "room_id", "booking_ref", "check_in_date", "check_out_date", "status", "created_at")
VALUES (523, 301, 201, 'BK-2009', '2027-01-10', '2027-01-12', NULL, '2026-10-22T11:00:00Z');

-- 32. reservation created at not null. Expected: created_at, SQLSTATE 23502.
INSERT INTO portfolio."reservation" ("reservation_id", "guest_id", "room_id", "booking_ref", "check_in_date", "check_out_date", "status", "created_at")
VALUES (524, 301, 201, 'BK-2010', '2027-01-10', '2027-01-12', 'confirmed', NULL);

-- 33. reservation dates check. Expected: reservation_dates_ordered, SQLSTATE 23514.
INSERT INTO portfolio."reservation" ("reservation_id", "guest_id", "room_id", "booking_ref", "check_in_date", "check_out_date", "status", "created_at")
VALUES (525, 301, 201, 'BK-2011', '2027-02-12', '2027-02-12', 'confirmed', '2026-10-22T11:00:00Z');

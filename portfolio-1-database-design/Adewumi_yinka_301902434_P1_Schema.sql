-- Hotel Reservation System: tables, keys and business constraints.
-- Run once in a fresh PostgreSQL database.
BEGIN;
SET LOCAL standard_conforming_strings = on;
CREATE SCHEMA portfolio;
CREATE TABLE portfolio."hotel" (
  "hotel_id" bigint NOT NULL,
  "name" text NOT NULL,
  "city" text NOT NULL,
  "star_rating" bigint NOT NULL,
  CONSTRAINT "pk_hotel" PRIMARY KEY ("hotel_id")
);
CREATE TABLE portfolio."room" (
  "room_id" bigint NOT NULL,
  "hotel_id" bigint NOT NULL,
  "room_number" text NOT NULL,
  "capacity" bigint NOT NULL,
  "nightly_rate" numeric(18,2) NOT NULL,
  "is_active" boolean NOT NULL,
  CONSTRAINT "pk_room" PRIMARY KEY ("room_id"),
  CONSTRAINT "uq_room_0" UNIQUE ("hotel_id", "room_number")
);
CREATE TABLE portfolio."guest" (
  "guest_id" bigint NOT NULL,
  "full_name" text NOT NULL,
  "email" text NOT NULL,
  "phone" text,
  CONSTRAINT "pk_guest" PRIMARY KEY ("guest_id"),
  CONSTRAINT "uq_guest_0" UNIQUE ("email")
);
CREATE TABLE portfolio."reservation" (
  "reservation_id" bigint NOT NULL,
  "guest_id" bigint NOT NULL,
  "room_id" bigint NOT NULL,
  "booking_ref" text NOT NULL,
  "check_in_date" date NOT NULL,
  "check_out_date" date NOT NULL,
  "status" text NOT NULL,
  "created_at" timestamptz NOT NULL,
  CONSTRAINT "pk_reservation" PRIMARY KEY ("reservation_id"),
  CONSTRAINT "uq_reservation_0" UNIQUE ("booking_ref")
);
ALTER TABLE portfolio."room" ADD CONSTRAINT "fk_room_0" FOREIGN KEY ("hotel_id") REFERENCES portfolio."hotel" ("hotel_id");
ALTER TABLE portfolio."reservation" ADD CONSTRAINT "fk_reservation_0" FOREIGN KEY ("guest_id") REFERENCES portfolio."guest" ("guest_id");
ALTER TABLE portfolio."reservation" ADD CONSTRAINT "fk_reservation_1" FOREIGN KEY ("room_id") REFERENCES portfolio."room" ("room_id");
ALTER TABLE portfolio."hotel" ADD CONSTRAINT "hotel_rating_range" CHECK (("star_rating" >= 1) AND ("star_rating" <= 5));
ALTER TABLE portfolio."reservation" ADD CONSTRAINT "reservation_dates_ordered" CHECK ("check_out_date" > "check_in_date");
COMMIT;

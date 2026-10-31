# Hotel Reservation System — normalisation

The example uses the saved sample records. The full set of fields is in the design and schema.

## Starting grouped records

| guest_id | reservation records (list) |
| --- | --- |
| 301 | [401] |
| 302 | [402] |


The record IDs are grouped in a list. In 1NF, each record has its own row and each cell holds one value.

## 1NF: one value per cell

| reservation.reservation_id | reservation.guest_id | reservation.room_id | reservation.booking_ref | guest.guest_id | guest.full_name | room.room_id | room.hotel_id |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 401 | 301 | 201 | BK-1001 | 301 | Avery Morgan | 201 | 101 |
| 402 | 302 | 202 | BK-1002 | 302 | Jordan Lee | 202 | 102 |

Key: reservation_id.

## 2NF: depend on the whole key

The declared candidate keys do not introduce a partial dependency here, so the 1NF rows stay unchanged at this step.

## reservation_example

| reservation.reservation_id | reservation.guest_id | reservation.room_id | reservation.booking_ref | guest.guest_id | guest.full_name | room.room_id | room.hotel_id |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 401 | 301 | 201 | BK-1001 | 301 | Avery Morgan | 201 | 101 |
| 402 | 302 | 202 | BK-1002 | 302 | Jordan Lee | 202 | 102 |

## 3NF: store each entity’s details once

The entity keys determine their own descriptions. Related records keep foreign keys rather than repeating those descriptions.

## hotel

| hotel_id | name | city | star_rating |
| --- | --- | --- | --- |
| 101 | Harbor Hotel | Portland | 4 |
| 102 | Pine Lodge | Bend | 3 |

## room

| room_id | hotel_id | room_number | capacity | nightly_rate | is_active |
| --- | --- | --- | --- | --- | --- |
| 201 | 101 | 101 | 2 | 145.5 | true |
| 202 | 102 | 12A | 3 | 189 | true |

## guest

| guest_id | full_name | email | phone |
| --- | --- | --- | --- |
| 301 | Avery Morgan | avery.morgan@example.test | +1-503-555-0142 |
| 302 | Jordan Lee | jordan.lee@example.test | NULL |

## reservation

| reservation_id | guest_id | room_id | booking_ref | check_in_date | check_out_date | status | created_at |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 401 | 301 | 201 | BK-1001 | 2026-11-10 | 2026-11-13 | confirmed | 2026-10-20T14:30:00+00:00 |
| 402 | 302 | 202 | BK-1002 | 2026-12-02 | 2026-12-05 | pending | 2026-10-21T09:15:00+00:00 |

## Dependencies

- hotel: (hotel_id) → name, city, star_rating
- room: (room_id) → hotel_id, room_number, capacity, nightly_rate, is_active
- guest: (guest_id) → full_name, email, phone
- reservation: (reservation_id) → guest_id, room_id, booking_ref, check_in_date, check_out_date, status, created_at

Joining the decomposed sample tables reproduces the original 2 example rows. The design assumes the declared keys describe the relevant business dependencies.

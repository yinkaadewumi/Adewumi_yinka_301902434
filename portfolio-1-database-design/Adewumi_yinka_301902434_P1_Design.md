# Hotel Reservation System — database design

My case study records hotel, room, guest, reservation.

## Users

- Reservation staff managing bookings
- Guests reviewing reservation details
- Analysts reviewing room demand

## Main operations

- Create and review reservations with their guest, room, and hotel details.
- Filter reservations by stay dates and status.
- Aggregate reservation counts by hotel for a requested date window.
- Separate benchmark plan: generate 20000 synthetic reservations, run the same date-window filter before and after adding the specified B-tree index, and compare the query access paths without returning benchmark results.

## Entities

| Entity | Information stored |
| --- | --- |
| hotel | A hotel that offers rooms for reservation. |
| room | A bookable room belonging to one hotel. |
| guest | A guest who may make reservations. |
| reservation | A guest's booking of one room for a date-bounded stay. |

## hotel

| Field | Type | Key | Required |
| --- | --- | --- | --- |
| hotel_id | BIGINT | PK | Yes |
| name | TEXT |  | Yes |
| city | TEXT |  | Yes |
| star_rating | INTEGER |  | Yes |


## room

| Field | Type | Key | Required |
| --- | --- | --- | --- |
| room_id | BIGINT | PK | Yes |
| hotel_id | BIGINT | FK | Yes |
| room_number | TEXT |  | Yes |
| capacity | INTEGER |  | Yes |
| nightly_rate | NUMERIC(18,2) |  | Yes |
| is_active | BOOLEAN |  | Yes |
- hotel_id → hotel.hotel_id
- Unique key: (hotel_id, room_number).

## guest

| Field | Type | Key | Required |
| --- | --- | --- | --- |
| guest_id | BIGINT | PK | Yes |
| full_name | TEXT |  | Yes |
| email | TEXT | Unique | Yes |
| phone | TEXT |  | No |
- Unique key: (email).

## reservation

| Field | Type | Key | Required |
| --- | --- | --- | --- |
| reservation_id | BIGINT | PK | Yes |
| guest_id | BIGINT | FK | Yes |
| room_id | BIGINT | FK | Yes |
| booking_ref | TEXT | Unique | Yes |
| check_in_date | DATE |  | Yes |
| check_out_date | DATE |  | Yes |
| status | TEXT |  | Yes |
| created_at | TIMESTAMPTZ |  | Yes |
- guest_id → guest.guest_id
- room_id → room.room_id
- Unique key: (booking_ref).

## Relationships and business rules

- A hotel's star rating must be between one and five inclusive.
- A room number must be unique within its hotel.
- Each guest email address identifies at most one guest.
- Each reservation booking reference is unique; concurrent attempts to reuse one must not both succeed.
- A reservation's check-out date must be later than its check-in date.
- Every reservation references an existing guest.
- Every reservation references an existing room.

## Assumptions

- Each reservation is for exactly one room and one guest.
- Check-in dates are inclusive and check-out dates are exclusive for room occupancy.
- A reservation's check-out date must be later than its check-in date.
- Room numbers are unique within a hotel, not across all hotels.
- All records and benchmark rows are synthetic.


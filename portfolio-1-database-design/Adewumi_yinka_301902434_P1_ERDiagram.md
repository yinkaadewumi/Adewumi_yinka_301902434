# Hotel Reservation System — ER diagram

```mermaid
erDiagram
    direction LR
    hotel {
        bigint hotel_id PK
        text name
        text city
        integer star_rating
    }
    room {
        bigint room_id PK
        bigint hotel_id FK
        text room_number
        integer capacity
        numeric nightly_rate
        boolean is_active
    }
    guest {
        bigint guest_id PK
        text full_name
        text email UK
        text phone "Optional"
    }
    reservation {
        bigint reservation_id PK
        bigint guest_id FK
        bigint room_id FK
        text booking_ref UK
        date check_in_date
        date check_out_date
        text status
        timestamptz created_at
    }
    hotel ||--o{ room : "hotel_id"
    guest ||--o{ reservation : "guest_id"
    room ||--o{ reservation : "room_id"
```

PK identifies a record; FK links to another table; UK marks a single-field unique value. The relationship ends show exactly one, zero or one, or zero or many records. Composite unique keys and conditional rules are listed in the schema and design.

[Diagram image](../images/Adewumi_yinka_301902434_ERDiagram.png)

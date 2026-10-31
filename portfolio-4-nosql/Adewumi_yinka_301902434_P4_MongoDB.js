// Run once in mongosh against a fresh exercise database.
// These records are fictional events for the case study.
(async function () {
  db = db.getSiblingDB('portfolio_nosql');
  if ((await db.getCollectionNames()).includes("reservation_events")) {
    throw new Error('The exercise collection already exists. Use a fresh database.');
  }

  // The validator checks the stable event fields while details can vary.
  await db.createCollection("reservation_events", {
    validator: {
    "$jsonSchema": {
        "bsonType": "object",
        "required": [
            "_id",
            "schemaVersion",
            "simulation",
            "eventType",
            "occurredAt",
            "source",
            "embedded",
            "references",
            "details"
        ],
        "properties": {
            "_id": {
                "bsonType": "string",
                "minLength": 1
            },
            "schemaVersion": {
                "enum": [
                    1
                ]
            },
            "simulation": {
                "enum": [
                    true
                ]
            },
            "eventType": {
                "bsonType": "string",
                "enum": [
                    "reservation_created",
                    "reservation_confirmed"
                ]
            },
            "occurredAt": {
                "bsonType": "date"
            },
            "source": {
                "bsonType": "object",
                "required": [
                    "entity",
                    "key",
                    "snapshot"
                ],
                "properties": {
                    "entity": {
                        "enum": [
                            "reservation"
                        ]
                    },
                    "key": {
                        "bsonType": "object",
                        "required": [
                            "reservation_id"
                        ]
                    },
                    "snapshot": {
                        "bsonType": "object"
                    }
                }
            },
            "embedded": {
                "bsonType": "object"
            },
            "references": {
                "bsonType": "object"
            },
            "details": {
                "bsonType": "object"
            }
        }
    }
},
    validationLevel: 'strict', validationAction: 'error'
  });

  // Insert the four example events and show their IDs.
  printjson(await db.getCollection("reservation_events").insertMany([
    {
        "_id": "event_000001",
        "schemaVersion": 1,
        "simulation": true,
        "eventType": "reservation_created",
        "occurredAt": ISODate("2030-01-01T10:00:00Z"),
        "source": {
            "entity": "reservation",
            "key": {
                "reservation_id": 401
            },
            "snapshot": {
                "reservation_id": 401,
                "guest_id": 301,
                "room_id": 201,
                "booking_ref": "BK-1001",
                "check_in_date": "2026-11-10",
                "check_out_date": "2026-11-13",
                "status": "confirmed",
                "created_at": "2026-10-20T14:30:00Z"
            }
        },
        "embedded": {
            "guest": [
                {
                    "key": {
                        "guest_id": 301
                    },
                    "snapshot": {
                        "guest_id": 301,
                        "full_name": "Avery Morgan",
                        "email": "avery.morgan@example.test",
                        "phone": "+1-503-555-0142"
                    },
                    "via": [
                        "reservation.guest_id → guest"
                    ]
                }
            ],
            "room": [
                {
                    "key": {
                        "room_id": 201
                    },
                    "snapshot": {
                        "room_id": 201,
                        "hotel_id": 101,
                        "room_number": "101",
                        "capacity": 2,
                        "nightly_rate": 145.5,
                        "is_active": true
                    },
                    "via": [
                        "reservation.room_id → room"
                    ]
                }
            ]
        },
        "references": {
            "hotel": [
                {
                    "key": {
                        "hotel_id": 101
                    },
                    "via": [
                        "reservation.room_id → room.hotel_id → hotel"
                    ]
                }
            ]
        },
        "details": {
            "channel": "web"
        }
    },
    {
        "_id": "event_000002",
        "schemaVersion": 1,
        "simulation": true,
        "eventType": "reservation_confirmed",
        "occurredAt": ISODate("2030-01-01T10:01:00Z"),
        "source": {
            "entity": "reservation",
            "key": {
                "reservation_id": 401
            },
            "snapshot": {
                "reservation_id": 401,
                "guest_id": 301,
                "room_id": 201,
                "booking_ref": "BK-1001",
                "check_in_date": "2026-11-10",
                "check_out_date": "2026-11-13",
                "status": "confirmed",
                "created_at": "2026-10-20T14:30:00Z"
            }
        },
        "embedded": {
            "guest": [
                {
                    "key": {
                        "guest_id": 301
                    },
                    "snapshot": {
                        "guest_id": 301,
                        "full_name": "Avery Morgan",
                        "email": "avery.morgan@example.test",
                        "phone": "+1-503-555-0142"
                    },
                    "via": [
                        "reservation.guest_id → guest"
                    ]
                }
            ],
            "room": [
                {
                    "key": {
                        "room_id": 201
                    },
                    "snapshot": {
                        "room_id": 201,
                        "hotel_id": 101,
                        "room_number": "101",
                        "capacity": 2,
                        "nightly_rate": 145.5,
                        "is_active": true
                    },
                    "via": [
                        "reservation.room_id → room"
                    ]
                }
            ]
        },
        "references": {
            "hotel": [
                {
                    "key": {
                        "hotel_id": 101
                    },
                    "via": [
                        "reservation.room_id → room.hotel_id → hotel"
                    ]
                }
            ]
        },
        "details": {
            "channel": "mobile",
            "note": "Illustrative event-specific metadata",
            "examples": {
                "special_requests": "illustrative special_requests",
                "change_reason": "illustrative change_reason",
                "status_details": "illustrative status_details"
            }
        }
    },
    {
        "_id": "event_000003",
        "schemaVersion": 1,
        "simulation": true,
        "eventType": "reservation_created",
        "occurredAt": ISODate("2030-01-01T10:02:00Z"),
        "source": {
            "entity": "reservation",
            "key": {
                "reservation_id": 402
            },
            "snapshot": {
                "reservation_id": 402,
                "guest_id": 302,
                "room_id": 202,
                "booking_ref": "BK-1002",
                "check_in_date": "2026-12-02",
                "check_out_date": "2026-12-05",
                "status": "pending",
                "created_at": "2026-10-21T09:15:00+00:00"
            }
        },
        "embedded": {
            "guest": [
                {
                    "key": {
                        "guest_id": 302
                    },
                    "snapshot": {
                        "guest_id": 302,
                        "full_name": "Jordan Lee",
                        "email": "jordan.lee@example.test",
                        "phone": null
                    },
                    "via": [
                        "reservation.guest_id → guest"
                    ]
                }
            ],
            "room": [
                {
                    "key": {
                        "room_id": 202
                    },
                    "snapshot": {
                        "room_id": 202,
                        "hotel_id": 102,
                        "room_number": "12A",
                        "capacity": 3,
                        "nightly_rate": 189,
                        "is_active": true
                    },
                    "via": [
                        "reservation.room_id → room"
                    ]
                }
            ]
        },
        "references": {
            "hotel": [
                {
                    "key": {
                        "hotel_id": 102
                    },
                    "via": [
                        "reservation.room_id → room.hotel_id → hotel"
                    ]
                }
            ]
        },
        "details": {
            "channel": "web"
        }
    },
    {
        "_id": "event_000004",
        "schemaVersion": 1,
        "simulation": true,
        "eventType": "reservation_confirmed",
        "occurredAt": ISODate("2030-01-01T10:03:00Z"),
        "source": {
            "entity": "reservation",
            "key": {
                "reservation_id": 402
            },
            "snapshot": {
                "reservation_id": 402,
                "guest_id": 302,
                "room_id": 202,
                "booking_ref": "BK-1002",
                "check_in_date": "2026-12-02",
                "check_out_date": "2026-12-05",
                "status": "pending",
                "created_at": "2026-10-21T09:15:00+00:00"
            }
        },
        "embedded": {
            "guest": [
                {
                    "key": {
                        "guest_id": 302
                    },
                    "snapshot": {
                        "guest_id": 302,
                        "full_name": "Jordan Lee",
                        "email": "jordan.lee@example.test",
                        "phone": null
                    },
                    "via": [
                        "reservation.guest_id → guest"
                    ]
                }
            ],
            "room": [
                {
                    "key": {
                        "room_id": 202
                    },
                    "snapshot": {
                        "room_id": 202,
                        "hotel_id": 102,
                        "room_number": "12A",
                        "capacity": 3,
                        "nightly_rate": 189,
                        "is_active": true
                    },
                    "via": [
                        "reservation.room_id → room"
                    ]
                }
            ]
        },
        "references": {
            "hotel": [
                {
                    "key": {
                        "hotel_id": 102
                    },
                    "via": [
                        "reservation.room_id → room.hotel_id → hotel"
                    ]
                }
            ]
        },
        "details": {
            "channel": "mobile",
            "note": "Illustrative event-specific metadata",
            "examples": {
                "special_requests": "illustrative special_requests",
                "change_reason": "illustrative change_reason",
                "status_details": "illustrative status_details"
            }
        }
    }
]));
  await db.getCollection("reservation_events").createIndex({eventType: 1, occurredAt: -1}, {name: 'event_type_time'});

  // 1. Find the first sample event type (up to five documents).
  printjson(await db.getCollection("reservation_events").find({"eventType":"reservation_created"}).sort({_id:1}).limit(5).toArray());

  // 2. Find events for the first source record using nested key fields (up to five).
  printjson(await db.getCollection("reservation_events").find({"source.key.reservation_id":401}).sort({_id:1}).limit(5).toArray());

  // 3. Find events in the sample time range using a MongoDB Date filter (up to five).
  printjson(await db.getCollection("reservation_events").find({"occurredAt":{"$gte":ISODate("2030-01-01T10:00:00Z"), "$lt":ISODate("2030-01-01T11:00:00Z")}}).sort({_id:1}).limit(5).toArray());

  // 4. Count documents for each event type.
  printjson(await db.getCollection("reservation_events").aggregate([{"$group":{"_id":"$eventType", "documentCount":{"$sum":1}}}, {"$sort":{"_id":1}}]).toArray());

  // A date stored as text should be rejected by the validator.
  try {
    await db.getCollection("reservation_events").insertOne({...{
    "_id": "event_000001",
    "schemaVersion": 1,
    "simulation": true,
    "eventType": "reservation_created",
    "occurredAt": ISODate("2030-01-01T10:00:00Z"),
    "source": {
        "entity": "reservation",
        "key": {
            "reservation_id": 401
        },
        "snapshot": {
            "reservation_id": 401,
            "guest_id": 301,
            "room_id": 201,
            "booking_ref": "BK-1001",
            "check_in_date": "2026-11-10",
            "check_out_date": "2026-11-13",
            "status": "confirmed",
            "created_at": "2026-10-20T14:30:00Z"
        }
    },
    "embedded": {
        "guest": [
            {
                "key": {
                    "guest_id": 301
                },
                "snapshot": {
                    "guest_id": 301,
                    "full_name": "Avery Morgan",
                    "email": "avery.morgan@example.test",
                    "phone": "+1-503-555-0142"
                },
                "via": [
                    "reservation.guest_id → guest"
                ]
            }
        ],
        "room": [
            {
                "key": {
                    "room_id": 201
                },
                "snapshot": {
                    "room_id": 201,
                    "hotel_id": 101,
                    "room_number": "101",
                    "capacity": 2,
                    "nightly_rate": 145.5,
                    "is_active": true
                },
                "via": [
                    "reservation.room_id → room"
                ]
            }
        ]
    },
    "references": {
        "hotel": [
            {
                "key": {
                    "hotel_id": 101
                },
                "via": [
                    "reservation.room_id → room.hotel_id → hotel"
                ]
            }
        ]
    },
    "details": {
        "channel": "web"
    }
}, _id: 'invalid_date_example', occurredAt: 'not-a-date'});
  } catch (error) { print('Invalid date error: ' + error.code); }

  // Reusing an event ID should be rejected by the unique _id index.
  try { await db.getCollection("reservation_events").insertOne({
    "_id": "event_000001",
    "schemaVersion": 1,
    "simulation": true,
    "eventType": "reservation_created",
    "occurredAt": ISODate("2030-01-01T10:00:00Z"),
    "source": {
        "entity": "reservation",
        "key": {
            "reservation_id": 401
        },
        "snapshot": {
            "reservation_id": 401,
            "guest_id": 301,
            "room_id": 201,
            "booking_ref": "BK-1001",
            "check_in_date": "2026-11-10",
            "check_out_date": "2026-11-13",
            "status": "confirmed",
            "created_at": "2026-10-20T14:30:00Z"
        }
    },
    "embedded": {
        "guest": [
            {
                "key": {
                    "guest_id": 301
                },
                "snapshot": {
                    "guest_id": 301,
                    "full_name": "Avery Morgan",
                    "email": "avery.morgan@example.test",
                    "phone": "+1-503-555-0142"
                },
                "via": [
                    "reservation.guest_id → guest"
                ]
            }
        ],
        "room": [
            {
                "key": {
                    "room_id": 201
                },
                "snapshot": {
                    "room_id": 201,
                    "hotel_id": 101,
                    "room_number": "101",
                    "capacity": 2,
                    "nightly_rate": 145.5,
                    "is_active": true
                },
                "via": [
                    "reservation.room_id → room"
                ]
            }
        ]
    },
    "references": {
        "hotel": [
            {
                "key": {
                    "hotel_id": 101
                },
                "via": [
                    "reservation.room_id → room.hotel_id → hotel"
                ]
            }
        ]
    },
    "details": {
        "channel": "web"
    }
}); }
  catch (error) { print('Duplicate ID error: ' + error.code); }

  print('Document count: ' + await db.getCollection("reservation_events").countDocuments());
})().catch(error => { print(error.stack || String(error)); quit(1); });

# Portfolio 1 — Database Design and Modelling

I organised the data into hotel, room, guest, reservation. The design document explains the fields, keys, relationships and business rules. The normalisation document shows the sample tables at 1NF, 2NF and 3NF.

## Database checks

| Table | Rows |
| --- | --- |
| hotel | 2 |
| room | 2 |
| guest | 2 |
| reservation | 2 |

The 33 invalid inserts were rejected at their expected constraints, and the valid sample rows remained unchanged.

## Files

- [Design](Adewumi_yinka_301902434_P1_Design.md)
- [ER diagram](Adewumi_yinka_301902434_P1_ERDiagram.md)
- [Normalisation](Adewumi_yinka_301902434_P1_Normalisation.md)
- [Schema](Adewumi_yinka_301902434_P1_Schema.sql)
- [Sample data](Adewumi_yinka_301902434_P1_SampleData.sql)
- [Constraint tests](Adewumi_yinka_301902434_P1_ConstraintTests.sql)
- [Table and constraint evidence](screenshots/Adewumi_yinka_301902434_P1_DatabaseResults.png)

## Run the SQL

Create a fresh PostgreSQL database. Run the schema first, then the sample data. Run the deliberately invalid statements in ConstraintTests.sql individually outside a transaction; each is expected to produce an error.

## References

- [PostgreSQL — constraints](https://www.postgresql.org/docs/17/ddl-constraints.html)


# Activity log logic

This is a primitive implementation of activity logging concern for models.

## Some comments
- `model_name` is reserved in Rails, so I just used default polymorphic association naming conventions
- deletion of records is not tracked, for this purpose I would need to have smth. like `activity_type` field
- the concern is not tested in isolation which might be a good idea for this generic functionality
- PostgreSQL was used as a database

## The most important files
```
app/models:
├── activity_log.rb
├── concerns
│   └── activity_logging.rb
└── patient.rb
```

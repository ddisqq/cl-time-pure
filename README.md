# cl-time-pure

Date/time handling for Common Lisp with ZERO external dependencies.

## Installation

```lisp
(asdf:load-system :cl-time-pure)
```

## API

### Timestamp Creation
- `now` - Current timestamp
- `encode-timestamp` - Create from components
- `universal-to-timestamp` - From universal time
- `parse-timestring` - Parse ISO 8601 string

### Timestamp Access
- `decode-timestamp` - Extract components
- `timestamp-to-universal` - To universal time
- `day-of-week` - Get day of week (0=Monday)

### Arithmetic
- `timestamp+` - Add duration
- `timestamp-` - Subtract duration or timestamps

### Comparison
- `timestamp<`, `timestamp<=` - Less than
- `timestamp>`, `timestamp>=` - Greater than
- `timestamp=` - Equality

### Formatting
- `format-timestring` - Format to string

## Example

```lisp
(let ((ts (now)))
  (format-timestring nil ts :format :iso-8601))
; => "2024-01-15T10:30:00Z"

(timestamp+ (now) :day 7) ; One week from now
```

## License

BSD-3-Clause. Copyright (c) 2024-2026 Parkian Company LLC.

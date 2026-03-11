;;;; Copyright (c) 2024-2026 Parkian Company LLC. All rights reserved.
;;;; SPDX-License-Identifier: BSD-3-Clause

;;;; package.lisp
;;;; cl-time-pure package definition

(defpackage #:cl-time-pure
  (:use #:cl)
  (:nicknames #:time-pure)
  (:export
   ;; Timestamp type
   #:timestamp
   #:timestamp-p
   ;; Creation
   #:now
   #:encode-timestamp
   #:universal-to-timestamp
   ;; Decoding
   #:decode-timestamp
   #:timestamp-to-universal
   #:timestamp-year
   #:timestamp-month
   #:timestamp-day
   #:timestamp-hour
   #:timestamp-minute
   #:timestamp-second
   #:timestamp-millisecond
   #:day-of-week
   ;; Arithmetic
   #:timestamp+
   #:timestamp-
   ;; Comparison
   #:timestamp<
   #:timestamp<=
   #:timestamp>
   #:timestamp>=
   #:timestamp=
   ;; Formatting and parsing
   #:format-timestring
   #:parse-timestring))

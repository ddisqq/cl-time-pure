;;;; Copyright (c) 2024-2026 Parkian Company LLC. All rights reserved.
;;;; SPDX-License-Identifier: Apache-2.0

;;;; package.lisp
;;;; cl-time-pure package definition

(defpackage #:cl-time-pure
  (:use #:cl)
  (:nicknames #:time-pure)
  (:export
   #:identity-list
   #:flatten
   #:map-keys
   #:now-timestamp
#:with-time-pure-timing
   #:time-pure-batch-process
   #:time-pure-health-check;; Timestamp type
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

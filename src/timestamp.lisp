;;;; Copyright (c) 2024-2026 Parkian Company LLC. All rights reserved.
;;;; SPDX-License-Identifier: Apache-2.0

;;;; src/timestamp.lisp
;;;; Timestamp type and basic operations

(in-package #:cl-time-pure)

;;; Timestamp structure - stores time as universal time + milliseconds

(defstruct (timestamp (:constructor %make-timestamp))
  "A timestamp with millisecond precision."
  (universal 0 :type integer :read-only t)
  (millisecond 0 :type (integer 0 999) :read-only t))

;;; Constants

(defconstant +unix-epoch-offset+ 2208988800
  "Seconds between 1900-01-01 and 1970-01-01 (Unix epoch).")

;;; Creation

(defun now ()
  "Return the current timestamp."
  (multiple-value-bind (sec micro)
      (sb-ext:get-time-of-day)
    (%make-timestamp :universal (+ sec +unix-epoch-offset+)
                     :millisecond (floor micro 1000))))

(defun encode-timestamp (year month day &key (hour 0) (minute 0) (second 0) (millisecond 0))
  "Create a timestamp from date/time components."
  (%make-timestamp :universal (encode-universal-time second minute hour day month year 0)
                   :millisecond millisecond))

(defun universal-to-timestamp (universal-time)
  "Convert a universal time to a timestamp."
  (%make-timestamp :universal universal-time :millisecond 0))

;;; Decoding

(defun decode-timestamp (timestamp)
  "Decode TIMESTAMP into (values second minute hour day month year dow)."
  (decode-universal-time (timestamp-universal timestamp) 0))

(defun timestamp-to-universal (timestamp)
  "Convert TIMESTAMP to universal time (losing millisecond precision)."
  (timestamp-universal timestamp))

(defun timestamp-year (timestamp)
  "Return the year of TIMESTAMP."
  (nth-value 5 (decode-timestamp timestamp)))

(defun timestamp-month (timestamp)
  "Return the month of TIMESTAMP (1-12)."
  (nth-value 4 (decode-timestamp timestamp)))

(defun timestamp-day (timestamp)
  "Return the day of TIMESTAMP (1-31)."
  (nth-value 3 (decode-timestamp timestamp)))

(defun timestamp-hour (timestamp)
  "Return the hour of TIMESTAMP (0-23)."
  (nth-value 2 (decode-timestamp timestamp)))

(defun timestamp-minute (timestamp)
  "Return the minute of TIMESTAMP (0-59)."
  (nth-value 1 (decode-timestamp timestamp)))

(defun timestamp-second (timestamp)
  "Return the second of TIMESTAMP (0-59)."
  (nth-value 0 (decode-timestamp timestamp)))

(defun day-of-week (timestamp)
  "Return the day of week of TIMESTAMP.
0 = Monday, 6 = Sunday."
  (nth-value 6 (decode-timestamp timestamp)))

;;; Comparison

(defun timestamp< (ts1 ts2)
  "Return T if TS1 is before TS2."
  (or (< (timestamp-universal ts1) (timestamp-universal ts2))
      (and (= (timestamp-universal ts1) (timestamp-universal ts2))
           (< (timestamp-millisecond ts1) (timestamp-millisecond ts2)))))

(defun timestamp<= (ts1 ts2)
  "Return T if TS1 is before or equal to TS2."
  (or (timestamp< ts1 ts2)
      (timestamp= ts1 ts2)))

(defun timestamp> (ts1 ts2)
  "Return T if TS1 is after TS2."
  (timestamp< ts2 ts1))

(defun timestamp>= (ts1 ts2)
  "Return T if TS1 is after or equal to TS2."
  (timestamp<= ts2 ts1))

(defun timestamp= (ts1 ts2)
  "Return T if TS1 equals TS2."
  (and (= (timestamp-universal ts1) (timestamp-universal ts2))
       (= (timestamp-millisecond ts1) (timestamp-millisecond ts2))))

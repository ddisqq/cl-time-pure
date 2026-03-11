;;;; Copyright (c) 2024-2026 Parkian Company LLC. All rights reserved.
;;;; SPDX-License-Identifier: BSD-3-Clause

;;;; src/arithmetic.lisp
;;;; Timestamp arithmetic operations

(in-package #:cl-time-pure)

;;; Duration constants

(defconstant +seconds-per-minute+ 60)
(defconstant +seconds-per-hour+ 3600)
(defconstant +seconds-per-day+ 86400)
(defconstant +seconds-per-week+ 604800)

;;; Arithmetic

(defun timestamp+ (timestamp &key (year 0) (month 0) (week 0) (day 0)
                                  (hour 0) (minute 0) (second 0) (millisecond 0))
  "Add duration to TIMESTAMP. Returns a new timestamp."
  (let* ((total-seconds (+ (* week +seconds-per-week+)
                           (* day +seconds-per-day+)
                           (* hour +seconds-per-hour+)
                           (* minute +seconds-per-minute+)
                           second))
         (total-ms (+ (timestamp-millisecond timestamp) millisecond))
         (extra-seconds (floor total-ms 1000))
         (final-ms (mod total-ms 1000))
         (new-universal (+ (timestamp-universal timestamp)
                           total-seconds
                           extra-seconds)))
    ;; Handle year/month additions (requires decoding)
    (when (or (plusp year) (plusp month))
      (multiple-value-bind (s mi h d mo y)
          (decode-universal-time new-universal 0)
        (let* ((new-month (+ mo month))
               (year-adjust (floor (1- new-month) 12))
               (adjusted-month (1+ (mod (1- new-month) 12)))
               (new-year (+ y year year-adjust)))
          ;; Clamp day to valid range for month
          (let ((max-day (days-in-month adjusted-month new-year)))
            (setf new-universal (encode-universal-time s mi h (min d max-day)
                                                       adjusted-month new-year 0))))))
    (%make-timestamp :universal new-universal :millisecond final-ms)))

(defun timestamp- (timestamp-or-duration &key timestamp (year 0) (month 0) (week 0)
                                              (day 0) (hour 0) (minute 0) (second 0)
                                              (millisecond 0))
  "Subtract from TIMESTAMP-OR-DURATION.
If TIMESTAMP is provided, subtract a duration and return a new timestamp.
Otherwise, if TIMESTAMP-OR-DURATION is a timestamp and second arg is a timestamp,
return the difference in seconds."
  (if timestamp
      ;; Subtracting one timestamp from another
      (let* ((diff-seconds (- (timestamp-universal timestamp-or-duration)
                              (timestamp-universal timestamp)))
             (diff-ms (- (timestamp-millisecond timestamp-or-duration)
                         (timestamp-millisecond timestamp))))
        (+ diff-seconds (/ diff-ms 1000.0)))
      ;; Subtracting a duration
      (timestamp+ timestamp-or-duration
                  :year (- year) :month (- month) :week (- week)
                  :day (- day) :hour (- hour) :minute (- minute)
                  :second (- second) :millisecond (- millisecond))))

;;; Helpers

(defun leap-year-p (year)
  "Return T if YEAR is a leap year."
  (or (zerop (mod year 400))
      (and (zerop (mod year 4))
           (not (zerop (mod year 100))))))

(defun days-in-month (month year)
  "Return number of days in MONTH of YEAR."
  (case month
    ((1 3 5 7 8 10 12) 31)
    ((4 6 9 11) 30)
    (2 (if (leap-year-p year) 29 28))))

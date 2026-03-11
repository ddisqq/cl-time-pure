;;;; Copyright (c) 2024-2026 Parkian Company LLC. All rights reserved.
;;;; SPDX-License-Identifier: BSD-3-Clause

;;;; src/format.lisp
;;;; Timestamp formatting

(in-package #:cl-time-pure)

(defun format-timestring (stream timestamp &key (format :iso-8601) timezone)
  "Format TIMESTAMP to STREAM (or return string if STREAM is nil).
FORMAT can be :ISO-8601, :RFC-2822, :DATE, :TIME, or a custom format string."
  (declare (ignore timezone))
  (multiple-value-bind (second minute hour day month year)
      (decode-timestamp timestamp)
    (let ((result
            (ecase format
              (:iso-8601
               (format nil "~4,'0D-~2,'0D-~2,'0DT~2,'0D:~2,'0D:~2,'0DZ"
                       year month day hour minute second))
              (:iso-8601-ms
               (format nil "~4,'0D-~2,'0D-~2,'0DT~2,'0D:~2,'0D:~2,'0D.~3,'0DZ"
                       year month day hour minute second
                       (timestamp-millisecond timestamp)))
              (:rfc-2822
               (format nil "~A, ~2,'0D ~A ~4,'0D ~2,'0D:~2,'0D:~2,'0D +0000"
                       (day-name (day-of-week timestamp))
                       day
                       (month-name month)
                       year hour minute second))
              (:date
               (format nil "~4,'0D-~2,'0D-~2,'0D" year month day))
              (:time
               (format nil "~2,'0D:~2,'0D:~2,'0D" hour minute second)))))
      (if stream
          (write-string result stream)
          result))))

(defun day-name (dow)
  "Return abbreviated day name for day-of-week DOW."
  (aref #("Mon" "Tue" "Wed" "Thu" "Fri" "Sat" "Sun") dow))

(defun month-name (month)
  "Return abbreviated month name for MONTH (1-12)."
  (aref #("" "Jan" "Feb" "Mar" "Apr" "May" "Jun"
          "Jul" "Aug" "Sep" "Oct" "Nov" "Dec")
        month))

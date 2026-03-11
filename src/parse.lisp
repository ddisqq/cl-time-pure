;;;; src/parse.lisp
;;;; Timestamp parsing

(in-package #:cl-time-pure)

(defun parse-timestring (string &key (format :auto))
  "Parse STRING into a timestamp.
FORMAT can be :AUTO (detect), :ISO-8601, or :DATE."
  (declare (ignore format))
  (let ((len (length string)))
    (cond
      ;; ISO 8601 with time: 2024-01-15T10:30:00Z or 2024-01-15T10:30:00.123Z
      ((and (>= len 19)
            (char= (char string 4) #\-)
            (char= (char string 7) #\-)
            (char= (char string 10) #\T))
       (let* ((year (parse-integer string :start 0 :end 4))
              (month (parse-integer string :start 5 :end 7))
              (day (parse-integer string :start 8 :end 10))
              (hour (parse-integer string :start 11 :end 13))
              (minute (parse-integer string :start 14 :end 16))
              (second (parse-integer string :start 17 :end 19))
              (millisecond 0))
         ;; Check for milliseconds
         (when (and (> len 19) (char= (char string 19) #\.))
           (let ((ms-end (position-if-not #'digit-char-p string :start 20)))
             (when (and ms-end (> ms-end 20))
               (let ((ms-str (subseq string 20 (min ms-end (+ 20 3)))))
                 (setf millisecond
                       (parse-integer (format nil "~A~V@{0~}" ms-str (- 3 (length ms-str)))))))))
         (encode-timestamp year month day
                           :hour hour :minute minute :second second
                           :millisecond millisecond)))

      ;; Date only: 2024-01-15
      ((and (= len 10)
            (char= (char string 4) #\-)
            (char= (char string 7) #\-))
       (let ((year (parse-integer string :start 0 :end 4))
             (month (parse-integer string :start 5 :end 7))
             (day (parse-integer string :start 8 :end 10)))
         (encode-timestamp year month day)))

      ;; Unix timestamp (integer string)
      ((every #'digit-char-p string)
       (let ((unix (parse-integer string)))
         (%make-timestamp :universal (+ unix +unix-epoch-offset+) :millisecond 0)))

      (t
       (error "Cannot parse timestamp: ~A" string)))))

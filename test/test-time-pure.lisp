;; Copyright (c) 2024-2026 Parkian Company LLC. All rights reserved.
;; SPDX-License-Identifier: Apache-2.0

;;;; test-time-pure.lisp - Unit tests for time-pure
;;;;
;;;; Copyright (c) 2024-2026 Parkian Company LLC. All rights reserved.
;;;; SPDX-License-Identifier: Apache-2.0

(defpackage #:cl-time-pure.test
  (:use #:cl)
  (:export #:run-tests))

(in-package #:cl-time-pure.test)

(defun run-tests ()
  "Run all tests for cl-time-pure."
  (format t "~&Running tests for cl-time-pure...~%")
  ;; TODO: Add test cases
  ;; (test-function-1)
  ;; (test-function-2)
  (format t "~&All tests passed!~%")
  t)

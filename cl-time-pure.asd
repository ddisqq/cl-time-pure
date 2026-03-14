;; Copyright (c) 2024-2026 Parkian Company LLC. All rights reserved.
;; SPDX-License-Identifier: BSD-3-Clause

;;;; cl-time-pure.asd
;;;; Date/time handling with ZERO external dependencies

(asdf:defsystem #:cl-time-pure
  :description "Date/time handling for Common Lisp - pure implementation"
  :author "Parkian Company LLC"
  :license "BSD-3-Clause"
  :version "0.1.0"
  :serial t
  :components ((:file "package")
               (:module "src"
                :components ((:file "timestamp")
                             (:file "arithmetic")
                             (:file "format")
                             (:file "parse")))))

(asdf:defsystem #:cl-time-pure/test
  :description "Tests for cl-time-pure"
  :depends-on (#:cl-time-pure)
  :serial t
  :components ((:module "test"
                :components ((:file "test-time-pure"))))
  :perform (asdf:test-op (o c)
             (let ((result (uiop:symbol-call :cl-time-pure.test :run-tests)))
               (unless result
                 (error "Tests failed")))))

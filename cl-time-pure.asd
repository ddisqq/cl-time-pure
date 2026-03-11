;;;; cl-time-pure.asd
;;;; Date/time handling with ZERO external dependencies

(asdf:defsystem #:cl-time-pure
  :description "Date/time handling for Common Lisp - pure implementation"
  :author "Parkian Company LLC"
  :license "BSD-3-Clause"
  :version "1.0.0"
  :serial t
  :components ((:file "package")
               (:module "src"
                :components ((:file "timestamp")
                             (:file "arithmetic")
                             (:file "format")
                             (:file "parse")))))

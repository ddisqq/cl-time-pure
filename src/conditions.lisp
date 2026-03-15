;; Copyright (c) 2024-2026 Parkian Company LLC. All rights reserved.
;; SPDX-License-Identifier: Apache-2.0

(in-package #:cl-time-pure)

(define-condition cl-time-pure-error (error)
  ((message :initarg :message :reader cl-time-pure-error-message))
  (:report (lambda (condition stream)
             (format stream "cl-time-pure error: ~A" (cl-time-pure-error-message condition)))))

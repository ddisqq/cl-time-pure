;; Copyright (c) 2024-2026 Parkian Company LLC. All rights reserved.
;; SPDX-License-Identifier: Apache-2.0

(in-package #:cl-time-pure)

;;; Core types for cl-time-pure
(deftype cl-time-pure-id () '(unsigned-byte 64))
(deftype cl-time-pure-status () '(member :ready :active :error :shutdown))

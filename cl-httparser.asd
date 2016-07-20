;; -*- Lisp -*-
(in-package #:cl-user)

(defpackage #:cl-httparser-system (:use #:cl #:asdf))

(in-package #:cl-httparser-system)

(asdf:defsystem #:cl-httparser
  :author "Vito Van"
  :serial t
  :components ((:file "package")
               (:file "toolbox"))
  :depends-on (:drakma :plump :clss))

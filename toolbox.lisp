(in-package :cl-httparser)

(defun hello-world ()
  (format t "hello, world~%")
  t)

(defun get->source (uri)
  "Fetch the given url and return its reply as string, also with proper encoding"
  (multiple-value-bind (vector _ headers) (drakma:http-request uri :force-binary t)
    (declare (ignore _))
    (multiple-value-bind (type subtype params)
        (drakma:get-content-type headers)
      (when (drakma::text-content-type-p type subtype)
        (let* ((charset (drakma:parameter-value "charset" params))
               (name (cond (charset (as-keyword charset))
                           (t :utf-8))))
          (vector->string vector :charset name))))))

(defun source->css->text (source selectors &key (flat t))
  (let* ((doc (plump:parse source))
        (vector-result-list
         (mapcar
          #'(lambda (selector) (map 'vector #'plump:text
                                    (clss:select selector doc)))
          selectors)))
    (if flat
        (mapcar
         #'(lambda (v) (aref v 0))
         vector-result-list)
        vector-result-list)))

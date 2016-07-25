(in-package :cl-httparser)

(defun vector->string (vector &key (engine *default-encode-engine*) (charset *default-charset*))
  "Convert vector to string.
The default engine is :babel, you can check all character-encodings supported by `(babel:list-character-encodings)`;
The alternative engine is :iconv, you should ensure that `libiconv` is available on your machine"
  (let ((chst (if (equal charset :GB2312) :GBK charset)))
    (cond
      ((equal :babel engine)
       (babel:octets-to-string vector :encoding chst))
      ((equal :iconv engine)
       (flexi-streams:octets-to-string
        (iconv:iconv chst :utf-8 vector)
        :external-format :utf-8)))))

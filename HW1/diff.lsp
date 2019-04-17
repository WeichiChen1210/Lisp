(defparameter pathlen nil)
(defparameter prev nil)

;; load file content into a list
(defun readfile (filename)
    (let (
            (linelist nil)
        )
        ;; open file
        (with-open-file (infile filename
                                :direction :input)
            ;; do( ((variable1 value1 updated-value1)
            ;;      (variable2 value2 updated-value2)
            ;;     ...)
            ;;     (test return-value)
            ;;     (s-expressions)
            ;; )             
            ;; read
            (do ((line (read-line infile nil 'eof) (read-line infile nil 'eof)))
                ((equal line 'eof) 'done)
                ;; store in list
                (push line linelist)                
            )
            ;; reverse
            (setq linelist (reverse linelist))
            ;; (format t "~a~%" linelist)
        )
        ;; (push nil linelist)
        (return-from readfile linelist)
    )
    
)
;; LCS
(defun lcs (linelist1 linelist2)
    (let (
            (n1 (- (length linelist1) 1))
            (n2 (- (length linelist2) 1))
            (len 0)
        )
        ;; 2 arrays for length and path
        (setq pathlen (make-array (list (+ n1 1) (+ n2 1)) :initial-element 0))
        (setq prev (make-array (list (+ n1 1) (+ n2 1)) :initial-element 0))
        ;; 2 level loop to assign values
        (loop for i from 1 to n1
            do(loop for j from 1 to n2
                do(cond
                    (
                        ;; if the content is the same
                        (string= (nth i linelist1) (nth j linelist2))
                        ;; update length and path array
                        (setf (aref pathlen i j) (+ (aref pathlen (- i 1) (- j 1)) 1))
                        ;; record path as 0
                        (setf (aref prev i j) 0)
                    )
                    (
                        ;; if the left length is < th up length
                        (< (aref pathlen (- i 1) j) (aref pathlen i (- j 1)))
                        ;; this length = the up length
                        (setf (aref pathlen i j) (aref pathlen i (- j 1)))
                        ;; record path as 1
                        (setf (aref prev i j) 1)
                    )
                    (
                        ;; if the left length is > th up length
                        (>= (aref pathlen (- i 1) j) (aref pathlen i (- j 1)))
                        ;; this length = the left length
                        (setf (aref pathlen i j) (aref pathlen (- i 1) j))
                        ;; record path as 1
                        (setf (aref prev i j) 2)
                    )
                )
            )
        )        
        ;; find the common lines
        (setf len (aref pathlen n1 n2))
        (let (
                (lcspos1 nil)
                (lcspos2 nil)
                (index1 n1)
                (index2 n2)
            )
            (loop while (> len 0)
                do(cond
                    (
                        ;; if in the path array = 0
                        (= (aref prev index1 index2) 0)
                        ;; store indexs
                        (push index1 lcspos1)
                        (push index2 lcspos2)
                        (setf index1 (- index1 1))
                        (setf index2 (- index2 1))
                        (setf len (- len 1))
                    )
                    ;; else continue to search
                    (
                        (= (aref prev index1 index2) 1)
                        (setf index2 (- index2 1))
                    )
                    (
                        (= (aref prev index1 index2) 2)
                        (setf index1 (- index1 1))
                    )
                )
            )
            (return-from lcs (values lcspos1 lcspos2))
            ;; (print-diff linelist1 linelist2 lcspos1 lcspos2)
        )
        
    )
)
;; print the contents
(defun print-diff (linelist1 linelist2 pos1 pos2)
    (let 
        (
            (n1 (- (length linelist1) 1))
            (n2 (- (length linelist2) 1))
            (curlcslen 0)
            (pos1num (length pos1))
            (i 1)
            (j 1)
        )
        ;; start from file1
        (loop while (<= i n1)
            do(cond 
                    (
                        ;; if common lines not finished
                        (< curlcslen pos1num)
                        (cond
                            (
                                ;; if i meets common lines
                                (= i (nth curlcslen pos1))
                                ;; print file2 contents until j meets common lines
                                (loop while (< j (nth curlcslen pos2))
                                    do(format t "+~A~%" (nth j linelist2))
                                    do(setf j (+ j 1))
                                )
                                (setf j (+ j 1))
                                ;; print content of common line
                                (format t " ~A~%" (nth i linelist1))
                                (setf curlcslen (+ curlcslen 1))
                            )
                            (
                                ;; else print file1 contents
                                (/= i (nth curlcslen pos1))
                                (format t "-~A~%" (nth i linelist1))
                            )
                        )
                    )
                    (
                        (>= curlcslen pos1num)
                        (return)
                    )
            )
            do(setf i (+ i 1))
        )
        ;; check rest contents
        (loop while (<= i n1)
            do (format t "-~A~%" (nth i linelist1))
            do (setf i (+ i 1))
        )
        (loop while (<= j n2)
            do (format t "+~A~%" (nth j linelist2))
            do (setf j (+ j 1))
        )
    )

)

(let (
        (linelist1 (readfile "file1.txt"))
        (linelist2 (readfile "file2.txt"))
    )
    (multiple-value-bind 
        (pos1 pos2) 
        (lcs linelist1 linelist2)
        (print-diff linelist1 linelist2 pos1 pos2)
    )
)

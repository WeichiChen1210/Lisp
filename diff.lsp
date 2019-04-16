(defparameter pathlen nil)
(defparameter prev nil)

(defun readfile (filename)
    (let (
            (linelist nil)
        )
        (with-open-file (infile filename
                                :direction :input)
            ;; do( ((variable1 value1 updated-value1)
            ;;      (variable2 value2 updated-value2)
            ;;     ...)
            ;;     (test return-value)
            ;;     (s-expressions)
            ;; )             
            (do ((line (read-line infile nil 'eof) (read-line infile nil 'eof)))
                ((equal line 'eof) 'done)
                (push line linelist)                
            )
            (setq linelist (reverse linelist))
            ;; (format t "~a~%" linelist)
        )
        (push nil linelist)
        (return-from readfile linelist)
    )
    
)

(defun lcs (linelist1 linelist2)
    (let (
            (n1 (- (length linelist1) 1))
            (n2 (- (length linelist2) 1))
            (len 0)
        )
        (setq pathlen (make-array (list (+ n1 1) (+ n2 1)) :initial-element 0))
        (setq prev (make-array (list (+ n1 1) (+ n2 1)) :initial-element 0))
        (loop for i from 1 to n1
            do(loop for j from 1 to n2
                do(cond
                    (
                        (string= (nth i linelist1) (nth j linelist2))
                        (setf (aref pathlen i j) (+ (aref pathlen (- i 1) (- j 1)) 1))
                        (setf (aref prev i j) 0)
                    )
                    (
                        (< (aref pathlen (- i 1) j) (aref pathlen i (- j 1)))
                        (setf (aref pathlen i j) (aref pathlen i (- j 1)))
                        (setf (aref prev i j) 1)
                    )
                    (
                        (>= (aref pathlen (- i 1) j) (aref pathlen i (- j 1)))
                        (setf (aref pathlen i j) (aref pathlen (- i 1) j))
                        (setf (aref prev i j) 2)
                    )
                )
            )
        )        
        (setf len (aref pathlen n1 n2))
        (loop for i from 1 to n1
            do (loop for j from 1 to n2
                do (cond
                    ((= (aref prev i j) 0)
                        (format t "↖"))
                    ((= (aref prev i j) 1)
                        (format t "←"))
                    ((= (aref prev i j) 2)
                        (format t "↑"))
                )
                do (format t "~a " (aref pathlen i j))
            )
            do (format t "~%")
        )
        (let (
                (lcspos1 nil)
                (lcspos2 nil)
                (index1 len)
                (index2 len)
            )
            (loop while (< len 0)
                do(cond
                    (
                        (= (aref pathlen index1 index2) 0)
                        (push index1 lcspos1)
                        (push index2 lcspos2)
                        (setf index1 (- index1 1))
                        (setf index2 (- index2 1))
                        (setf len (- len 1))
                    )
                    (
                        (= (aref pathlen index1 index2) 1)
                        (setf index2 (- index2 1))
                    )
                    (
                        (= (aref pathlen index1 index2) 0)
                        (setf index1 (- index1 1))
                    )
                )
            )
            (print-diff lcspos1 lcspos2)
        )
        
    )
)

(defun prinf-diff (pos1 pos2)
    (let 
        (
            (n1 (- (length linelist1) 1))
            (n2 (- (length linelist2) 1))
        )
        (loop while (<= n1)
            do (
                
            )
        )
    )

)

(defun main()
    (let (
            (linelist1 (readfile "file1.txt"))
            (linelist2 (readfile "file2.txt"))
            (result nil)
        )
        (print (length linelist1))
        (print (length linelist2))
        
        (format t "~{~A~^ ~}~%" linelist1)
        (format t "~{~A~^ ~}~%" linelist2)
        (lcs linelist1 linelist2)
    )
)

(main)

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
            ;; (push nil list)
            ;; (format t "~a~%" linelist)
        )
        (return-from readfile linelist)
    )
    
)

(defun longest (a b)
  (if (> (length a) (length b)) a b))

(defun lcs (a b)
  (cond
    ((or (null a) (null b)) nil)
    ((eql (car a) (car b))
       (cons (car a) (lcs (cdr a) (cdr b))))
    (t (longest (lcs a (rest b)) (lcs (rest a) b)))))
    
(defun main()
    (let (
            (linelist1 (readfile "file1.txt"))
            (linelist2 (readfile "file2.txt"))
            (result nil)
        )
        (format t "~{~A~^ ~}~%" linelist1)
        (format t "~{~A~^ ~}~%" linelist2)
        (setq result (lcs '(1 2 8 4 6 9) '(1 3 7 4 6 9)))
        (print result)
        (print (null linelist1))
    )
)

(main)
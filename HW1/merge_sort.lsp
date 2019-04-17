(defparameter *n* 0)
(defparameter *input* nil)

;; get the front half part of the original list
(defun front-part (my_list middle) 
    (if (= middle 0) 
        '() 
        (cons (car my_list) (front-part (cdr my_list) (- middle 1)))
    )
)

;; get the back half part of the original list
(defun back-part (my_list middle) 
    (if (= middle 0) 
        my_list 
        (back-part (cdr my_list) (- middle 1))
    )
)

;; merge the two list by comparing the first elements and construct a list
(defun my_merge (list1 list2)
    (cond   ((equal list1 nil) list2)
            ((equal list2 nil) list1)
            ((< (car list1) (car list2)) (cons (car list1) (my_merge (cdr list1) list2)))
            (T (cons (car list2) (my_merge list1 (cdr list2))))
    )
)
;; split the list and sort
(defun merge_sort (my_list)
    (if (= (length my_list) 1)
        my_list
        (my_merge   (merge_sort (front-part my_list (truncate (length my_list) 2)))
                    (merge_sort (back-part my_list (truncate (length my_list) 2)))
        )
    )
)

(setq *n* (read))
(dotimes (i *n*)
    (setq *input* (cons (read) *input*))
)
(setq *input* (reverse *input*))
(format t "~{~A~^ ~}~%" (merge_sort *input*))
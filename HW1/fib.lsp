(DEFUN fib1(n)
    (if (< n 2)
        n
        (+ (fib1 (- n 1)) (fib1 (- n 2)))
    )
)

(DEFUN fib2(n)
    ;; define a local function
    (labels (
        (fib-in (n a b)
            ;; if n == 0, return a
            (if (= n 0)
                a
                ;; else call itself with new parameter updated
                (fib-in (- n 1) b (+ a b))
            )
        )
        )
        ;; initial call
        (fib-in n 0 1)
    )
)

(let 
    (
        (x (read))
    )
    (format t "Original resursion:~%")
    (trace fib1)
    (let ((n1 (fib1 x)))
        (format t "result: ~A~%" n1)
    )
    (untrace fib1)
    (format t "Tail resursion:~%")
    (trace fib2)
    (let ((n2 (fib2 x)))
        (format t "result: ~A~%" n2)
    )
    (untrace fib2)
)

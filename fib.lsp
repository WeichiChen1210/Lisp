(DEFUN fib1(n)
    (if (< n 2)
        n
        (+ (fib1 (- n 1)) (fib1 (- n 2)))
    )
)

(DEFUN fib2(n)
    (if (< n 2)
        n
        (+ (fib2 (- n 1)) (fib2 (- n 2)))
    )
)

(format t "~A~%" (fib 20))
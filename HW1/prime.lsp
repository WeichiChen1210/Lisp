;;; file: prime.lsp

(DEFUN prime(n)
    (let ((flag 1))
        ;; loop from 2 to n/2
        (loop for x from 2 to (/ n 2)
            ;; if n can be divided by x, then it's not a prime
            if (= (rem n x) 0)
            do (setq flag 0)
            ;; condition with n = 2
            if (= n 2)
            do (setq flag 1)
        )
        ;; if flag is 0, output that it is not a prime
        (if (= flag 0)
            (format t "~A is not a prime number. ~%" n)
            (format t "~A is a prime number. ~%" n)
        )
    )
)
(let 
    (
        (n (read))
    )
    (prime n)
)
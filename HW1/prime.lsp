;;; file: prime.lsp

(DEFUN prime(n)
    (let ((flag 1))

        (loop for x from 2 to (/ n 2)
            if (= (mod n x) 0)
            do (setq flag 0)
            if (= n 2)
            do (setq flag 1)
        )
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
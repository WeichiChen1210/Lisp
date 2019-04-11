;;; file: prime.lsp

(DEFUN palindrome(x)
    (let ((newx (reverse x)))
        (if (equal newx x)
            (format t "~A is a palindrome.~%" x)
            (format t "~A is not a palindrome.~%" x)
        )))

(palindrome '(a b c))
(palindrome '(m a d a m))
(palindrome '(cat dog))
(palindrome '())
(palindrome '(cat dog bird bird dog cat))
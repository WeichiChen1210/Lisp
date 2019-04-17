;;; file: prime.lsp

(DEFUN palindrome(x)
    ;; reverse the list
    (let ((newx (reverse x)))
        ;; compare
        (if (equal newx x)
            (format t "~A is a palindrome.~%" x)
            (format t "~A is not a palindrome.~%" x)
        )))
(let 
    (
        (input (read-from-string (concatenate 'string "(" (read-line) ")")))
    )
    
    (palindrome input)
)
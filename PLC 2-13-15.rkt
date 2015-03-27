;factorial using a continuation function for the return
(define factorial-cps
  (lambda (n return)
         (if (zero? n)
            (return 1)
            (factorial-cps (- n 1) (lambda (v) (return (* v n)))))))

;myappend
(define myappend
  (lambda (l1 l2)
    (if (null? l1)
        l2
        (cons (car l1) (myappend (cdr l1) l2)))))

(define myappend-cps
  (lambda (l1 l2 return)
    (if (null? l1)
        (return l2)
        (myappend-cps (cdr l1) l2 (lambda (v) (return (cons ( car l1) v)))))))




;sum*: taskes a list of list of umbers and return the sum of them
(define sum*-cps
  (lambda (l return)
    (cond
      ((null? l) (return 0))
      ((number? (car l)) (sum*-cps (cdr l) (lambda (v) (return (+ (car l) v)))))
      ((list? (car l)) (sum*-cps (car l) (lambda (v1) (sum*-cps (cdr l)
                                                                (lambda (v2) (return (+ v1 v2))))))))))

;mylength: takes a list and returnst the length of the list
(define mylength-cps
  (lambda (l return)
    (if (null? l)
        (return 0)
        (mylength-cps (cdr l) (lambda (v) (return (+ 1 v)))))))

;myreverse: reverses a list
(define myreverse
  (lambda (l return)
    (if (null? l)
        (return '())
        (myreverse (cdr l) (lambda (v) (return (cons v (car l))))))))

(define flatten
  (lambda (l)
    (cond
      ((null? l) '())
      ((list? (car l)) (append (flatten (car l)) (flatten (cdr l))))
       (else (cons (car l) (flatten (cdr l)))))))

;takes a list of numbers and returns the profuct
(define multiply-cps
  (lambda (l return)
    (cond
      ((null? l) (return 1))
      ((zero? (car l)) 0)
      (else (multiply-cps (cdr l) (lambda (v) (return (* (car l) v))))))))


(define multiply
  (lambda (l break)
    (letrec ((loop (lambda (l2 return)
                     (cond
                       ((null? l2) (return 1))
                       ((zero? (car l2)) (break 0))
                       (else (loop (cdr l2) (lambda (v) (return (* (car l2) v)))))))))
      (loop l break))))


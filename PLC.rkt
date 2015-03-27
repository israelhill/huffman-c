; return the legnth of a list
(define len
  (lambda (l)
    (if (null? l)
       0
       (+ 1 (len (cdr l))))))


;returns true if the atom is in the list 
(define member?
  (lambda (a l)
    (cond
      ((null? l) #f)
      ((eq? a (car l)) #t)
      (else (member? a (cdr l))))))

;factorial function: computes x!
(define factorial
  (lambda (x)
    (if (zero? x)
        1
        (* x (factorial (- x 1))))))


;count: return the number of occurrences of a variable in a list
(define count
  (lambda (a l)
    (cond
      ((null? l) 0)
       ((eq? a (car l)) (+ 1 (count a (cdr l))))
       (else (+ 0 (count a (cdr l)))))))
        
        
;sumnum: return the of a list of numbers
(define sumnum
  (lambda (a)
    (cond
      ((null? a) 0)
      ((number? (car a)) (+ (car a) (sumnum (cdr a))))
      (else (sumnum (cdr a))))))
  
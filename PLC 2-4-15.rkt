(define trimatoms
  (lambda (l1 l2)
    (cond
      ((null? l1) l2)
      ((list? (car l1)) (trimatoms (cdr l1) (trimatoms (car l1) l2)))
      (else (trimatoms (cdr l1) (cdr l2))))))

(define exchange
  (lambda (l1 l2)
    (cond
      ((null? l1) '())
      ((list? (car l1)) (cons (exchange (car l1) l2) (exchange (cdr l1) (trimatoms (car l1) l2))))
      (else (cons (car l2) (exchange (cdr l1) (cdr l2)))))))

(define partialsums*
  (lambda (l)
    (cond
      ((null? l) '(0))
      ((number? (car l)) (cons (+ (car l) (car (partialsums* (cdr l)))) (cdr (partialsums* (cdr l)))))
      ((list? (car l)) (cons (+ (car (partialsums* (car l))) (car (partialsums* (cdr l)))) (cons (partialsums* (car l)) (cdr (partialsums*(cdr l))))))
      (else (partialsums* (cdr l))))))

(define maxnumber
  (lambda (l)
    (cond
      ((null? (cdr l)) (car l))
      ((< (car l) (car (cdr l))) (maxnumber (cdr l)))
      ((> (car l) (car (cdr l))) (maxnumber (cons (car l) (cdr (cdr l))))))))
  
;maxnumber: but use varialbe to store the values so we can compute it once
(define maxnum2
  (lambda (l)
    (if (null? (cdr l))
        (car l)
        (let(
            ((max (maxnum2 (cdr l))))
          (if (> max (car l))
              max
              (car l))))))

;maxnum: only call the recursive call once, but no variables!
(define maxnum3
  (lambda (l)
    (if (null? (cdr l))
        (car l)
        ((lambda (max)
          (if (> max (car l))
              max
              (car l)))
         (maxnum3 (cdr l))))))

; The Mvalue function for simple expressions: numbers and binary operators
(define Mvalue
(lambda (expression state form)
((lambda (operator leftoperand rightoperand)

(cond
((number? expression) expression)
((eq? '+ (operator expression)) (+ (Mvalue (leftoperand expression) state form) 
(Mvalue (rightoperand expression) state form)))
; fill in the rest for -, *, / and %
((eq? '/ (operator expression)) (quotient (Mvalue (leftoperand expression) state form)
(Mvalue (rightoperand expression) state form)))
((eq? '% (operator expression)) (remainder (Mvalue (leftoperand expression) state form)
(Mvalue (rightoperand expression) state form)))

(else (error 'unknown-operator))))
(operator form) (leftoperand form) (rightoperand form))))

; Functions for the different parts of an expression. Using abstraction so we simply change these and not Mvalue if we want
; infix, prefix or postfix expressions
(define operator
(lambda (form)
(car form)))

(define leftoperand
(lambda (form)
(cadr form)))

(define rightoperand
(lambda (form) 
(caddr form)))

(define infix (cons cadr (cons car (cons caddr '()))))
(define prefix (list car cadr caddr))

(define factorial
  (lambda (n)
    (if (zero? 1)
        1
        (* n (factorial (- n 1))))))
              
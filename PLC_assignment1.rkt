;Israel Hill

;multiplyby: takes a list of numbers and multiplies
;each of them by another numbered specified by the user
(define multiplyby
  (lambda (n l)
    (cond
      ((null? l) '())
      (else (cons (* n (car l)) (multiplyby n (cdr l))))))) 

;maxnumber: takes a list of numbers and outputs the largest number from that list
(define maxnumber
  (lambda (l)
    (cond
      ((null? (cdr l)) (car l))
      ((< (car l) (car (cdr l))) (maxnumber (cdr l)))
      ((> (car l) (car (cdr l))) (maxnumber (cons (car l) (cdr (cdr l))))))))
      
;removelast: input a list of atoms and it returns that list with the last atom missing
(define removelast
  (lambda (l)
    (cond
      ((null? (cdr l)) '())
      ((cons (car l) (removelast (cdr l)))))))
    
;crossmultiply: multpiplies the corresponding indecies of each list. Each
;set of multiplied groups of indiceis become their own lists
(define crossmultiply
  (lambda (l1 l2)
    (cond 
      ((null? l1) '())
      ((null? l2) '())
      (else (cons (multiplyby (car l1) l2) (crossmultiply (cdr l1) l2)))))) 

;acts as an override for car function
(define front*
  (lambda (l)
    (cond
      ((null? l) '())
      (else (cons (car l) '())))))

;acts as an override for the cdr function
(define end*
  (lambda (l)
    (cond
      ((null? l) '())
      (else (cdr l)))))

;interleave3: input 3 lists and it outputs the first atoms of each list, then the 2nd atoms of each lists, etc...
(define interleave3
  (lambda (l1 l2 l3)
    (cond
      ((and (and (null? l1) (null? l2)) (null? l3)) '()) 
      (else (append (front* l1) (append (front* l2) (append (front* l3) (interleave3* (end* l1) (end* l2) (end* l3)))))))))

;reverse: takes a list (which may contain sublists) and outputs that list backwards
(define reverse*
  (lambda (l)
    (cond
      ((null? l) '())
      ((list? (car l)) (append (reverse* (cdr l)) (cons (reverse* (car l)) '()))) 
      (else (append (reverse* (cdr l)) (cons (car l) '()))))))

;reverselists: input a list (which may contain sublists and it keeps the outermost list the same, but reverses the sub lists.
;if the sublists also contain a list it keeps those the same. This pattern continues for nested sublists.
(define reverselists
  (lambda (l)
    (cond
      ((null? l) '())
      ((list? (car l)) (append  (cons (reverse* (car l)) '()) (reverselists (cdr l))))
      (else (cons (car l) (reverselists (cdr l)))))))

;trimatoms: input 2 lists. This function returns the first list minus the number of atoms that were in the second list. 
(define trimatoms
(lambda (l1 l2)
  (cond
    ((null? l1) l2)
    ((list? (car l1)) (trimatoms (cdr l1) (trimatoms (car l1) l2)))
    (else (trimatoms (cdr l1) (cdr l2))))))

;helper
(define sumnums
  (lambda (l)
    (cond
      ((null? l) 0)
      ((number? (car l)) (+ (car l) (sumnums (cdr l))))
      ((list? (car l)) (+ (sumnums (car l)) (sumnums (cdr l))))
      (else (sumnums (cdr l))))))
;helper
(define removeall
  (lambda (l)
    (cond
      ((null? l) '())
      ((list? (car l)) (cons (car l) (removeall (cdr l))))
      (else (removeall (cdr l))))))

;partialsums*: input a list. This function returns the list with the sums of the inner lists. The first element of the list is the sum of
;all the sublists
(define partialsums*
  (lambda (l)
    (cond
      ((null? l) '())
      ((and (number? (car l)) (list? l)) (cons (sumnums l) (partialsums* (removeall (cdr l)))))
      ((and (not (number? (car l))) (list? l)) (cons (cons (sumnums (car l)) (partialsums* (removeall (car l)))) (partialsums* (removeall (cdr l)))))
      ((number? (l)) '()))))

;exchange: input 2 lists. this function replaces each atom in the first list with the corresponding indexed atom of the second list
(define exchange
(lambda (l1 l2)
  (cond
    ((null? l1) '())
    ((list? (car l1)) (cons (exchange (car l1) l2) (exchange (cdr l1) (trimatoms (car l1) l2))))
    (else (cons (car l2) (exchange (cdr l1) (cdr l2)))))))            
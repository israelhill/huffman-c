;multiplyby: multiply each number in a list by a single number
(define multiplyby
  (lambda (num l return)
    (cond
      ((null? l) (return '()))
      (else (multiplyby num (cdr l) (lambda (v) (return (cons (* num (car l)) v)))))))) 

;crossmultiply returns the product of two list representations of vectors
(define crossmultiply
  (lambda (l1 l2 return)
    (cond
      ((null? l1) (return '()))
      (else (multiplyby (car l1) l2 
                        (lambda (v) 
                          (crossmultiply (cdr l1) l2 (lambda (v2)
                                                       (return (cons v v2))))))))))

;partialsums: gets the sum of each inner list and the outer lists
(define partialsums*
 (lambda (l return)
   (cond
     ((null? l) (return '(0)))
     ((number? (car l)) (partialsums* (cdr l) (lambda (v1)
                                                (return (cons (+ (car l) (car v1)) (cdr v1))))))
     ((list? (car l)) (partialsums* (car l) (lambda (v2) 
                                              (partialsums* (cdr l) (lambda (v3)
                                                                      (return (cons (+ (car v2) (car v3)) (cons v2 (cdr v3)))))))))
     (else (partialsums* (cdr l) return)))))

;trimatoms: takes 2 lists of atoms and removes atoms from the second list based on the number of atoms that appeared in the second list
(define trimatoms
 (lambda (l1 l2 return)
   (cond 
     ((null? l1) (return l2))
     ((list? (car l1)) (trimatoms (car l1) l2 
                                  (lambda (v1)
                                    (trimatoms (cdr l1) v1 
                                               (lambda (v2) 
                                                 (return v2))))))
     (else (trimatoms (cdr l1) (cdr l2) return)))))
                                                 
;multiplyby: takes a list of numbers and returns the largest number in the list
(define maxnumber
  (lambda (l return)
    (cond
      ((null? (cdr l)) (return (car l)))
      (else (maxnumber (cdr l) (lambda (v) (cond
                                             ((> (car l) v) (return (car l)))
                                             (else (return v)))))))))


;exchange: takes two lists of atoms that may contain sublists.It replaces the atoms of the 
;first list with the atoms in the second list in the order that they appear
(define exchange
  (lambda (l1 l2 return)
    (cond
      ((null? l1) (return '()))
         ((list? (car l1)) (trimatoms (car l1) l2 
                                     (lambda (v)
                                       (exchange (car l1) l2 
                                                 (lambda (v2)
                                                   (exchange (cdr l1) v (lambda (v3) 
                                                                           (return (cons v2 v3)))))))))
         (else (exchange (cdr l1) (cdr l2) (lambda (v) (return (cons (car l2) v))))))))

;removesubsequence takes two lists. Any atom in the first list is removed from the second 
;list in the order that they appeard in the first list
(define removesubsequence*
  (lambda (l1 l2 return)
    (cond
      ((null? l1) (return '() l2))
      ((null? l2) (return '() '()))
      ((list? (car l2)) (removesubsequence* l1 (car l2) (lambda (v1 v2)
                                                          (removesubsequence* v1 (cdr l2) (lambda (v3 v4)
                                                                                                      (return v3 (cons v2 v4)))))))
      ((eq? (car l1) (car l2)) (remove-cps (car l1) l2 (lambda (v) (removesubsequence* (cdr l1) v (lambda (v1 v2) (return v1 v2))))))
      (else (removesubsequence* l1 (cdr l2) (lambda (v1 v2) (return l1 (cons (car l2) v2))))))))

;remove-cps: helper to remove the first occurrence of an atom in a list
(define remove-cps
  (lambda (a l return)
    (cond
      ((null? l) (return '()))
      ((eq? a (car l)) (return (cdr l)))
      (else (remove-cps a (cdr l) (lambda (v) (return (cons (car l) v))))))))

;split: takes a list and returns two lists. The first list contains all the 
;even indexed elements and the second contains all the odd indexed elements
(define split
  (lambda (l return)
    (cond
      ((or (null? l) (null? (cdr l))) (return (list l '())))
      (else (split (cddr l) (lambda (v) (return (list (cons (car l) (car v)) (cons (cadr l) (cadr v))))))))))
                                                                                    

;suffix: takes an atom and a list. Returns the contents of the list appearing after the last occurence of the atom
(define suffix
  (lambda (a l)
    (letrec ((loop (lambda (a2 l2 return break)
                     (cond
                       ((null? l2) (return a2 '()))
                       (else (loop a2 (cdr l2) (lambda (v1 v2) (cond
                                                                 ((eq? (car l2) a2) (break '() v2))
                                                                 (else (return v1 (cons (car l2) v2))))) break))))))
      (loop a l (lambda (v1 v2) v2) (lambda (v1 v2) v2))))) 

;suffix2: same as suffix except it uses call/cc instead of normal CPS
(define suffix2
  (lambda (a l)
    (call/cc
     (lambda (break)
    (letrec ((loop (lambda (a2 l2 return)
                     (cond
                       ((null? l2) (return a2 '()))
                       (else (loop a2 (cdr l2) (lambda (v1 v2) (cond
                                                                 ((eq? (car l2) a2) (break v2))
                                                                 (else (return v1 (cons (car l2) v2)))))))))))
      (loop a l (lambda (v1 v2) v2)))))))
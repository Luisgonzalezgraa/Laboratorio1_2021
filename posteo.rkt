#lang racket
(provide (all-defined-out))



(define (posteo id user date content users)
  (list id user date content users)
  )

;Selector Nombre:
;Dom: Lista x lista
;Rec: Lista
(define (getId id)
  (car id)
  )


;Selector : 
;Dom: Lista x lista
;Rec: Lista
(define (getNameA nameA)
  (cadr nameA)
  )


;Selector : 
;Dom: Lista x lista
;Rec: Lista
(define (getDateP dateP)
  (caddr dateP)
  )

;Selector : 
;Dom: Lista x lista
;Rec: Lista
(define (getContent content)
  (cadddr content)
  )
;Selector : 
;Dom: Lista x lista
;Rec: Lista
(define (getUsers users)
  (cadddr(cdr users))
  )
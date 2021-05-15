#lang racket
(provide (all-defined-out))

(define (date day month year)
  (list (number->string day)"-"(number->string month)"-"(number->string year))
 )

;Selector : 
;Dom: Lista x lista
;Rec: Lista
(define (getDay day)
  (car day)
  )
;Selector : 
;Dom: Lista x lista
;Rec: Lista
(define (getMonth month)
  (cadr month)
  )

;Selector : 
;Dom: Lista x lista
;Rec: Lista
(define (getYear year)
  (caddr year)
  )
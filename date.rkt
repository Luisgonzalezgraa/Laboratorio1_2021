#lang racket
(provide (all-defined-out))

(define (date day month year)
  (list day month year)
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
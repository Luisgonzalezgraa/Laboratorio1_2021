#lang racket
(provide (all-defined-out))

(define (socialRegister encrypt date name password)
  (list encrypt date name password)
  )


;Selector : 
;Dom: Lista x lista
;Rec: Lista
(define (getEncry encrypt)
  (car encrypt)
  )

;Selector : 
;Dom: Lista x lista
;Rec: Lista
(define (ingresarDate date)
  (cadr date)
  )
;Selector : 
;Dom: Lista x lista
;Rec: Lista
(define (ingresarName name)
  (caddr name)
  )

;Selector : 
;Dom: Lista x lista
;Rec: Lista
(define (ingresarPassword password)
  (cadddr password)
  )
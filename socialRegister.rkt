#lang racket
(provide (all-defined-out))

(define (socialRegister date name password)
  (list (list date name password))
  )

;Selector : 
;Dom: Lista x lista
;Rec: Lista
(define (getPrimerU primerU)
  (car (car primerU))
  )


;Selector : 
;Dom: Lista x lista
;Rec: Lista
(define (getDate date)
  (car date)
  )
;Selector : 
;Dom: Lista x lista
;Rec: Lista
(define (getName name)
  (cadr name)
  )

;Selector : 
;Dom: Lista x lista
;Rec: Lista
(define (getPassword password)
  (caddr password)
  )
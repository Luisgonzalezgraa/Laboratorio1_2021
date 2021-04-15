#lang racket
(provide (all-defined-out))

(define (socialRegister nameRedSocial date name password)
  (list nameRedSocial date name password)
  )

;Selector Nombre:
;Dom: Lista x lista
;Rec: Lista
(define (ingresarNameSocial nameRedSocial)
  (car nameRedSocial)
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
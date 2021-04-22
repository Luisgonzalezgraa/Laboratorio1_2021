#lang racket
(provide (all-defined-out))


(define (socialNetwork nameRedSocial date encryptFn1 decrypt)
  (list nameRedSocial date  encryptFn1 decrypt)
  )

;Selector Nombre:
;Dom: Lista x lista
;Rec: Lista
(define (getNombre nameRedSocial)
  (car nameRedSocial)
  )


;Selector : 
;Dom: Lista x lista
;Rec: Lista
(define (getFecha date)
  (cadr date)
  )


;Selector : 
;Dom: Lista x lista
;Rec: Lista
(define (getEncryp encryptFn1)
  (caddr encryptFn1)
  )

;Selector : 
;Dom: Lista x lista
;Rec: Lista
(define (getDecryp decrypt)
  (cadddr decrypt)
  )


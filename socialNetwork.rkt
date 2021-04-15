#lang racket
(provide (all-defined-out))

(define (socialNetwork nameRedSocial date encryptFunction decryptFunction)
  (list nameRedSocial date encryptFunction decryptFunction)
  )

;Selector Nombre:
;Dom: Lista x lista
;Rec: Lista
(define (ingresarNombre nameRedSocial)
  (car nameRedSocial)
  )


;Selector : 
;Dom: Lista x lista
;Rec: Lista
(define (ingresarFecha date)
  (cadr date)
  )
;Selector : 
;Dom: Lista x lista
;Rec: Lista
(define (ingresarEncryp encryptFunction)
  (caddr encryptFunction)
  )

;Selector : 
;Dom: Lista x lista
;Rec: Lista
(define (ingresarDecryp decryptFunction)
  (cadddr decryptFunction)
  )
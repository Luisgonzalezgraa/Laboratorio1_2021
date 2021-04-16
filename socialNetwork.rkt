#lang racket
(provide (all-defined-out))

(define (socialNetwork nameRedSocial date contenido1 contenido2)
  (list nameRedSocial date contenido1 contenido2)
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
(define (ingresarEncryp contenido1)
  (caddr contenido1)
  )

;Selector : 
;Dom: Lista x lista
;Rec: Lista
(define (ingresarDecryp contenido2)
  (cadddr contenido2)
  )
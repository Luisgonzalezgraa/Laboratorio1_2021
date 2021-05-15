#lang racket
(provide (all-defined-out))

(define (usuarioActivo marcado nombreUsuario contenido)
  (list marcado nombreUsuario contenido)
  )

;Selector : 
;Dom: Lista x lista
;Rec: Lista
(define (getMarcado marcado)
  (car marcado)
  )
;Selector : 
;Dom: Lista x lista
;Rec: Lista
(define (getUsuario nombre)
  (cadr nombre)
  )
;Selector : 
;Dom: Lista x lista
;Rec: Lista
(define (getContenido contenido)
  (caddr contenido)
  )
#lang racket
(provide (all-defined-out))


(define (socialNetwork nameRedSocial date encryptFn1 decrypt usuarios usuarioActivo posteo follow share)
  (list nameRedSocial date  encryptFn1 decrypt usuarios usuarioActivo posteo follow share)
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
;Selector : 
;Dom: Lista x lista
;Rec: Lista
(define (getUsuarios usuarios)
  (cadddr(cdr usuarios))
  )
;Selector : 
;Dom: Lista x lista
;Rec: Lista
(define (getUsuarioActivo usuarioA)
  (cadddr(cddr usuarioA))
  )
;Selector : 
;Dom: Lista x lista
;Rec: Lista
(define (getPosteo posteo)
  (cadddr(cdddr posteo))
  )
;Selector : 
;Dom: Lista x lista
;Rec: Lista
(define (getFollow follow)
  (cadddr(cdddr(cdr follow)))
  )
;Selector : 
;Dom: Lista x lista
;Rec: Lista
(define (getShare share)
  (cadddr(cdddr(cdr share)))
  )


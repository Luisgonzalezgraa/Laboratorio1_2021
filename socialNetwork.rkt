#lang racket
(provide (all-defined-out))


(define (socialNetwork nameRedSocial date contenido1 contenido2)
  (list nameRedSocial date contenido1 (decryp contenido2))
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



(define encryptFn (lambda (s) (list (list->string (reverse (string->list s))))))


(define (decryp lista)
  (if (null? (cdr lista))
      (encryptFn (car lista))
      (concatenar (encryptFn (car lista))(decryp (cdr lista)))
      )
     
  )

(define (concatenar lista1 lista2)
  (if(null? lista1)
     lista2
     (cons (car lista1) (concatenar (cdr lista1) lista2))
  )
)




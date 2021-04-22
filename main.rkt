#lang racket
(provide (all-defined-out))
(require "socialNetwork.rkt")
(require "socialRegister.rkt")

;Funcion register: 
;Dom: socialNetworw X string X string
;Rec: socialNetworw
;Recursion: Natural
;Ejemplo de uso:
(define (register socialNet date name password)
      (if (not(list?  (cadddr socialNet) ))
           (socialNetwork
            (getNombre socialNet)
            (getFecha socialNet)
            (concatenar (list )(socialRegister ((getEncryp socialNet) date)  ((getEncryp socialNet) name)  ((getEncryp socialNet) password)))
            (concatenar (list )(socialRegister  date  name password))
            )
           (if(estaenlista? (cadddr socialNet) name)
              (display "Usuario ya registrado, intente con otro nombre...")
              (socialNetwork
            (getNombre socialNet)
            (getFecha socialNet)
            (concatenar (getEncryp socialNet)(socialRegister (encryptFn date)  (encryptFn name)  (encryptFn password)))
            (concatenar (getDecryp socialNet)(socialRegister  date  name password))
               )
              )
          )
)

(define encryptFn (lambda (s) (list->string (reverse (string->list s)))))



;Funcion Concatenar: Concatena dos listas
;Dom: Lista x lista
;Rec: Lista
;Recursion: Natural
(define (concatenar lista1 lista2)
  (if(null? lista1)
     lista2
     (cons (car lista1) (concatenar (cdr lista1) lista2))
  )
)

;-------------------------------------
;Funcion estaenlista?: Ve si un elemento es parte de la lista
;Dom: lista x (string-int-entre otros)
;Rec: Booleano
;Recursion: Cola

(define (estaenlista? lista parametro)
  (if (null? lista)
      #f
      (if (eq? (car lista) parametro)
          #t
          (estaenlista? (cdr lista) parametro)
          )
      )
  )
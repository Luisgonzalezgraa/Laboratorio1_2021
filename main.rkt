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
   (if(null? socialNetwork)
      #f 
      (if (not(estaenlista?  socialNet name))
          
          (socialNetwork
          (ingresarNombre socialNet)
          (ingresarFecha socialNet)
          (concatenar (ingresarEncryp socialNet)(socialRegister (encryptFn2 date)  (encryptFn2 name)  (encryptFn2 password)))
          (concatenar (ingresarEncryp socialNet)(socialRegister (encryptFn2 date)  (encryptFn2 name)  (encryptFn2 password)))
          )
         
       #f
        
      )
  )
  
)

(define encryptFn (lambda (s) (list (list->string (reverse (string->list s))))))
(define encryptFn2 (lambda (s) (list->string (reverse (string->list s)))))


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
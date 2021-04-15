#lang racket
(provide (all-defined-out))
(require "socialNetwork.rkt")
(require "socialRegister.rkt")

;Funcion register: 
;Dom: stack X string X string
;Rec: stack
;Recursion: Natural
;Ejemplo de uso:
(define (register socialNet date name password)
   (if(null? socialNetwork)
      #f 
      (if (not(estaenlista? (caddr socialRegister) name))
          
          (socialRegister
          (ingresarNameSocial socialRegister)
          (concatenar(list date) (ingresarDate socialRegister ))
          (concatenar(list name) (ingresarName socialRegister ))
          (concatenar(list password) (ingresarPassword socialRegister))
          )
         
       #f
        
      )
  )
  
)




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
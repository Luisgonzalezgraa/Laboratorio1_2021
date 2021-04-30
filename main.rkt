#lang racket
(provide (all-defined-out))
(require "socialNetwork.rkt")
(require "socialRegister.rkt")
(require "date.rkt")

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
            (socialRegister (getEncryp socialNet) (reverse date) ((getEncryp socialNet) name) ((getEncryp socialNet) password))
            (socialRegister (getDecryp socialNet) date  name password)
            )
           (if(estaenlista? (cadddr socialNet) name)
              (display "Usuario ya registrado, intente con otro nombre...")
              (socialNetwork
            (getNombre socialNet)
            (getFecha socialNet)
            (concatenar (getEncryp socialNet)(socialRegister "" (reverse date)  (encryptFn name)  (encryptFn password)))
            (concatenar (getDecryp socialNet)(socialRegister  "" date  name password))
               )
              )
          )
)



(define (login socialNet name contrasenia operation)
   (if (and(estaenlista? (cadddr socialNet) name) (estaenlista? (cadddr socialNet) contrasenia))      
        (lambda(fecha) (lambda(contenido) (lambda (usuario)
                                                      ((((operation socialNet) fecha) name contrasenia) contenido usuario))))
       
       
      (lambda(fecha)(lambda(id) (lambda(pregunta) (lambda (etiqueta)
                                                      ((((operation socialNet) fecha)null null null) pregunta etiqueta)))))
      )
  )


(define post(lambda(socialNet) (lambda(date)
               (lambda (name password)
              (lambda (content users)
                (if(null? name)
                   #f
                (socialNetwork
                 (getNombre socialNet)
                 (getFecha socialNet)
                 (concatenar(getEncryp socialNet)(list (reverse date) ((car(caddr socialNet)) name) ((car(caddr socialNet))password) ((car(caddr socialNet)) content) ((car(caddr socialNet))users)))
                 (concatenar(getDecryp socialNet)(list date name password content users))))
              ))))


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
(define encryptFn (lambda (s) (list->string (reverse (string->list s)))))
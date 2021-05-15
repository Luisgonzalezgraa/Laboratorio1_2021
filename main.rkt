#lang racket
(provide (all-defined-out))
(require "socialNetwork.rkt")
(require "socialRegister.rkt")
(require "usuarioActivo.rkt")
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
            (socialRegister (getEncryp socialNet) (map (getEncryp socialNet) date) ((getEncryp socialNet) name) ((getEncryp socialNet) password))
            (socialRegister (getDecryp socialNet) date  name password)
            )
           (if(estaenlista? (cadddr socialNet) name)
              (display "Usuario ya registrado, intente con otro nombre...")
              (socialNetwork
            (getNombre socialNet)
            (getFecha socialNet)
            (concatenar (getEncryp socialNet)(socialRegister "" (map (car(getEncryp socialNet)) date)  ((car(getEncryp socialNet)) name)  ((car(getEncryp socialNet)) password)))
            (concatenar (getDecryp socialNet)(socialRegister  "" date  name password))
               )
              )
          )
)

;Funcion : 
;Dom: socialNetworw X string X string
;Rec: socialNetworw
;Recursion: Natural
;Ejemplo de uso:

(define (login socialNet name contrasenia operation)
   (if (and(estaenlista? (cadddr socialNet) name) (estaenlista? (cadddr socialNet) contrasenia))
        (operation (socialNetwork
                    (getNombre socialNet)
                    (getFecha socialNet)
                    (concatenar (remove ((car(getEncryp socialNet)) contrasenia) (remove ((car(getEncryp socialNet)) name) (getEncryp socialNet))) (list
                                                                                                                                                  ((car(getEncryp socialNet)) name)
                                                                                                                                                  ((car(getEncryp socialNet)) " Usuario Activo: ")
                                                                                                                                                  ))
                    (concatenar(remove contrasenia (remove name (getDecryp socialNet)))(list  name " Usuario Activo: " ))
                    ))
       
       
      (operation null)
      )
  )
;Funcion : 
;Dom: socialNetworw X string X string
;Rec: socialNetworw
;Recursion: Natural
;Ejemplo de uso:(define eFB ((((login FB "usuario1" "pass1" post)(date 21 3 2020))"mi primer post") "user1"))

(define post(lambda(socialNet) (lambda(date)
               
              (lambda (content . users)
                (if(null? socialNet)
                   (display "Nombre o Contraseña incorrectas.")
                (socialNetwork
                 (getNombre socialNet)
                 (getFecha socialNet)
                 (concatenar (remove ((car(getEncryp socialNet)) " Usuario Activo: ") (remove (cadr (reverse (getEncryp socialNet))) (getEncryp socialNet))) (list (usuarioActivo
                                                                     (getMarcado (reverse (getEncryp socialNet)))
                                                                     (getUsuario (reverse (getEncryp socialNet)))
                                                                     (list (map (car(getEncryp socialNet)) date) ((car(getEncryp socialNet)) content) (map (car(getEncryp socialNet)) users) )
                                                           )))
                 (concatenar (remove " Usuario Activo: " (remove (cadr (reverse(getDecryp socialNet))) (getDecryp socialNet))) (list (usuarioActivo
                                                                     (getMarcado (reverse (getDecryp socialNet)))
                                                                     (getUsuario (reverse (getDecryp socialNet)))
                                                                     (list  date content users )  ))) 
              )))))
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
;Funcion : 
;Dom: socialNetworw X string X string
;Rec: socialNetworw
;Recursion: Natural
;Ejemplo de uso:
(define encryptFn (lambda (s) (list->string (reverse (string->list s)))))



(define decryptFn(lambda(s) encryptFn (encryptFn s)))
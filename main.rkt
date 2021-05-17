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
      (if (null?  (getUsuarios socialNet))
           (socialNetwork
            (getNombre socialNet)
            (getFecha socialNet)
            (getEncryp socialNet) 
            (getDecryp socialNet)
            (socialRegister (map(getEncryp socialNet) date) ((getEncryp socialNet)name) ((getEncryp socialNet)password))
            ""
            ""
            ""
            "")
           (if(estaenlistadelistas?  (getUsuarios socialNet) ((getEncryp socialNet)name))
              (display "Usuario ya registrado, intente con otro nombre...")
              (socialNetwork
            (getNombre socialNet)
            (getFecha socialNet)
            (getEncryp socialNet)
            (getDecryp socialNet)
            (concatenar(getUsuarios socialNet)(socialRegister (map(getEncryp socialNet) date) ((getEncryp socialNet)name) ((getEncryp socialNet)password)))
            ""
            ""
            ""
            "")
              )
          )
)

;Funcion : 
;Dom: socialNetworw X string X string
;Rec: socialNetworw
;Recursion: Natural
;Ejemplo de uso:

(define (login socialNet name contrasenia operation)
   (if (estanlosparametros?  (getUsuarios socialNet) ((getEncryp socialNet)name) ((getEncryp socialNet) contrasenia))
        (operation (socialNetwork
                    (getNombre socialNet)
                    (getFecha socialNet)
                    (getEncryp socialNet)
                    (getDecryp socialNet)
                    (remove (obtenerposicion (getUsuarios socialNet) ((getEncryp socialNet)name) ((getEncryp socialNet) contrasenia)) (getUsuarios socialNet))
                    (list ((getEncryp socialNet)"Usuario activo: ") ((getEncryp socialNet)name))
                    ""
                    ""
                    ""
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
                   (if(comparardoslistas socialNet (getUsuarios socialNet) users)
                    (socialNetwork
                     (getNombre socialNet)
                     (getFecha socialNet)
                     (getEncryp socialNet)
                     (getDecryp socialNet)
                     (getUsuarios socialNet)
                     (getUsuarioActivo socialNet)
                     (list(list (cadr(getUsuarioActivo socialNet)) (map(getEncryp socialNet) date) ((getEncryp socialNet) content) (map(getEncryp socialNet) users)))
                     ""
                     "")
                     (display "Al usuario dirigido el post no existe")
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
      (if (equal? (car lista) parametro)
          #t
          (estaenlista? (cdr lista) parametro)
          )
      )
  )

;Funcion filtradoPorUsuarios: filtra una lista de listas para obtener una lista con los usuarios registrados en la plataforma
;Dom: Lista x lista
;Rec: Lista
;Recursion: Natural
(define (estaenlistadelistas? lista parametro)
  (if (null? lista)
      #f
      (if (equal? (getName (car  lista)) parametro)
          #t
          (estaenlistadelistas? (cdr lista) parametro)
          )
      )
  )
;Funcion filtradoPorUsuarios: filtra una lista de listas para obtener una lista con los usuarios registrados en la plataforma
;Dom: Lista x lista
;Rec: Lista
;Recursion: Natural
(define (comparardoslistas socialNet lista lista2)
  (if (null? lista2)
      #t
      (if(null? lista)
         #f
                (if (equal? (getName (car  lista)) ((getEncryp socialNet)(car lista2)))
                    (comparardoslistas socialNet (cdr lista)(cdr lista2))
                    (comparardoslistas  socialNet (cdr lista) lista2)
                    )
         )
      )
  )
;Funcion filtradoPorUsuarios: filtra una lista de listas para obtener una lista con los usuarios registrados en la plataforma
;Dom: Lista x lista
;Rec: Lista
;Recursion: Natural
(define (estanlosparametros? lista parametro parametro2)
  (if (null? lista)
      #f
      (if (and (equal? (getName (car  lista)) parametro)(equal? (getPassword (car  lista)) parametro2))
           #t
          (estanlosparametros? (cdr lista) parametro parametro2)
      )
   )
 )
;Funcion filtradoPorUsuarios: filtra una lista de listas para obtener una lista con los usuarios registrados en la plataforma
;Dom: Lista x lista
;Rec: Lista
;Recursion: Natural
(define (obtenerposicion lista parametro parametro2)
  (if (null? lista)
      #f
      (if (and (equal? (getName (car  lista)) parametro)(equal? (getPassword (car  lista)) parametro2))
           (car lista)
          (obtenerposicion (cdr lista) parametro parametro2)
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
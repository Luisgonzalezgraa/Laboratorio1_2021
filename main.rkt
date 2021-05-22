#lang racket
(provide (all-defined-out))
(require "socialNetwork.rkt")
(require "socialRegister.rkt")
(require "usuarioActivo.rkt")
(require "date.rkt")
(require "posteo.rkt")

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
            (getUsuarioActivo socialNet)
            (getPosteo socialNet)
            (getFollow socialNet)
            (getShare socialNet))
           (if(estaenlistadelistas?  (getUsuarios socialNet) ((getEncryp socialNet)name))
              (display "Usuario ya registrado, intente con otro nombre...")
              (socialNetwork
            (getNombre socialNet)
            (getFecha socialNet)
            (getEncryp socialNet)
            (getDecryp socialNet)
            (concatenar(getUsuarios socialNet)(socialRegister (map(getEncryp socialNet) date) ((getEncryp socialNet)name) ((getEncryp socialNet)password)))
            (getUsuarioActivo socialNet)
            (getPosteo socialNet)
            (getFollow socialNet)
            (getShare socialNet))
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
                    (getUsuarios socialNet)
                    (list ((getEncryp socialNet)"Usuario activo: ") ((getEncryp socialNet)name))
                    (getPosteo socialNet)
                    (getFollow socialNet)
                    (getShare socialNet)
                    ))
       
       
      (operation null)
      )
  )
;Funcion : 
;Dom: socialNetworw X string X string
;Rec: socialNetworw
;Recursion: Natural
;Ejemplo de uso:(define eFB (((login FB "usuario1" "pass1" post)(date 21 3 2020))"mi primer post" "user1"))

(define post(lambda(socialNet) (lambda(date)
               
              (lambda (content . users)
                (if(null? socialNet)
                   (display "Nombre o Contraseña incorrectas.")
                   (if(comparardoslistas socialNet (getUsuarios socialNet) users)
                      (if(null? (getPosteo socialNet))
                    (socialNetwork
                     (getNombre socialNet)
                     (getFecha socialNet)
                     (getEncryp socialNet)
                     (getDecryp socialNet)
                     (getUsuarios socialNet)
                     (getUsuarioActivo socialNet)
                     (concatenar (getPosteo socialNet)(list(posteo +1 (cadr(getUsuarioActivo socialNet)) (map(getEncryp socialNet) date) ((getEncryp socialNet) content) (map(getEncryp socialNet) users))))
                     (getFollow socialNet)
                     (getShare socialNet)
                     )
                    (socialNetwork
                     (getNombre socialNet)
                     (getFecha socialNet)
                     (getEncryp socialNet)
                     (getDecryp socialNet)
                     (getUsuarios socialNet)
                     (getUsuarioActivo socialNet)
                     (concatenar (getPosteo socialNet)(list(posteo (+ (car (last (getPosteo socialNet)))1) (cadr(getUsuarioActivo socialNet)) (map(getEncryp socialNet) date) ((getEncryp socialNet) content) (map(getEncryp socialNet) users) )))
                     (getFollow socialNet)
                     (getShare socialNet)
                     ))
                    
                     (display "Al usuario dirigido el post no existe")
              )))))
  )
;Funcion : 
;Dom: socialNetworw X string X string
;Rec: socialNetworw
;Recursion: Natural
;Ejemplo de uso:

(define follow(lambda(socialNet) (lambda(date)
              (lambda (user)
                (if(null? socialNet)
                   (display "Nombre o Contraseña incorrectas.")
                   (if(equal?(cadr(getUsuarioActivo socialNet)) ((getEncryp socialNet) user))
                      (display "No se puede seguir a si mismo")
                   (if(estaenlistadelistas? (getUsuarios socialNet) ((getEncryp socialNet) user))
                    (socialNetwork
                     (getNombre socialNet)
                     (getFecha socialNet)
                     (getEncryp socialNet)
                     (getDecryp socialNet)
                     (getUsuarios socialNet)
                     (getUsuarioActivo socialNet)
                     (getPosteo socialNet)
                     (concatenar(getFollow socialNet)(list(list (cadr(getUsuarioActivo socialNet)) "->" ((getEncryp socialNet) user))))
                     (getShare socialNet))
                     (display "El usuario que quiere seguir no existe.")
              ))))))
  )

;Funcion : 
;Dom: socialNetworw X string X string
;Rec: socialNetworw
;Recursion: Natural
;Ejemplo de uso:

(define share(lambda(socialNet) (lambda(date)
               
              (lambda (postId . users)
                (if(null? socialNet)
                   (display "Nombre o Contraseña incorrectas.")
                   (if(comparardoslistas socialNet (getUsuarios socialNet) users)
                      (if(estaid? (getPosteo socialNet) postId)
                    (socialNetwork
                     (getNombre socialNet)
                     (getFecha socialNet)
                     (getEncryp socialNet)
                     (getDecryp socialNet)
                     (getUsuarios socialNet)
                     (getUsuarioActivo socialNet)
                     (getPosteo socialNet)
                     (getFollow socialNet)
                     (concatenar(getShare socialNet)(list (list (cadr(getUsuarioActivo socialNet)) (getId (obtenerposicion (getPosteo socialNet) postId)) (getContent (obtenerposicion (getPosteo socialNet) postId)) (map(getEncryp socialNet) users))))
                     )
                    (display "El id del post no existe")
                    )
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
;Funcion estaid?: Funcion auxiliar que sirve para ver si el post con el numero existe dentro de la plataforma
;Dom: lista x (string-int-entre otros)
;Rec: Booleano
;Recursion: Cola

(define (estaid? lista parametro)
  (if (null? lista)
      #f
      (if (equal? (getId (car  lista)) parametro)
          #t
          (estaid? (cdr lista) parametro)
          )
      )
  )

;Funcion estaenlistadelistas?: funcion que sirve para saber si un usuario existe dentro de una lista de listas
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
;Funcion comparardoslistas: filtra una lista de listas para obtener una lista con los usuarios registrados en la plataforma
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
;Funcion estanlosparametros? filtra una lista de listas para obtener una lista con los usuarios registrados en la plataforma
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
;Funcion obtenerposicion filtra una lista de listas para obtener una lista con los usuarios registrados en la plataforma
;Dom: Lista x lista
;Rec: Lista
;Recursion: Natural
(define (obtenerposicion lista parametro)
  (if (null? lista)
      #f
      (if (equal? (getId (car  lista)) parametro)
           (car lista)
          (obtenerposicion (cdr lista) parametro)
      )
   )
 )

;Funcion encryptFn : Funcion que sirve para encryptar informacion
;Dom: string
;Rec: string
;Recursion: Natural
;Ejemplo de uso:
(define encryptFn (lambda (s) (list->string (reverse (string->list s)))))


;Funcion decryptFn : Funcion que sirve para decencryptar informacion
;Dom: string
;Rec: string
;Recursion: Natural
;Ejemplo de uso:
(define decryptFn(lambda(s) encryptFn (encryptFn s)))















(define emptyFB (socialNetwork "fb" (date 25 10 2021) encryptFn decryptFn null null null null null))
(define FB (register (register (register emptyFB (date 25 10 2021) "user1" "pass1") (date 25 10 2021) "user2" "pass2") (date 25 10 2021) "user3" "pass3"))
(define FB2 (((login FB "user1" "pass1" post) (date 28 10 2021)) "10nd post" "user2" "user3"))
(define FB3 (((login FB2 "user2" "pass2" post) (date 28 10 2021)) "10nd post" "user3"))
(define FB4 (((login FB3 "user3" "pass3" post) (date 28 10 2021)) "10nd post" "user1"))
(define FB5 (((login FB4 "user3" "pass3" follow) (date 28 10 2021))"user1"))
(define FB6 (((login FB5 "user3" "pass3" share) (date 28 10 2021)) 3 "user1"))
(define FB7 (((login FB6 "user1" "pass1" share) (date 28 10 2021)) 2 "user2" "user3"))
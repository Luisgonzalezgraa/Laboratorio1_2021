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
            (socialRegister (mi-map(getEncryp socialNet) date) ((getEncryp socialNet)name) ((getEncryp socialNet)password))
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
            (concatenar(getUsuarios socialNet)(socialRegister (mi-map (getEncryp socialNet) date) ((getEncryp socialNet)name) ((getEncryp socialNet)password)))
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
                     (list(car(getUsuarioActivo socialNet))null)
                     (concatenar (getPosteo socialNet)(list(posteo +1 (cadr(getUsuarioActivo socialNet)) (mi-map(getEncryp socialNet) date) ((getEncryp socialNet) content) (mi-map(getEncryp socialNet) users))))
                     (getFollow socialNet)
                     (getShare socialNet)
                     )
                    (socialNetwork
                     (getNombre socialNet)
                     (getFecha socialNet)
                     (getEncryp socialNet)
                     (getDecryp socialNet)
                     (getUsuarios socialNet)
                     (list(car(getUsuarioActivo socialNet)) null)
                     (concatenar (getPosteo socialNet)(list(posteo (+ (car (last (getPosteo socialNet)))1) (cadr(getUsuarioActivo socialNet)) (mi-map(getEncryp socialNet) date) ((getEncryp socialNet) content) (mi-map(getEncryp socialNet) users) )))
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
                     (list(car(getUsuarioActivo socialNet)) null)
                     (getPosteo socialNet)
                     (concatenar(getFollow socialNet)(list(list (cadr(getUsuarioActivo socialNet)) ">-" ((getEncryp socialNet) user))))
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
                     (list(car(getUsuarioActivo socialNet)) null)
                     (getPosteo socialNet)
                     (getFollow socialNet)
                     (concatenar(getShare socialNet)(list (list (cadr(getUsuarioActivo socialNet)) (getId (obtenerposicion (getPosteo socialNet) postId)) (getContent (obtenerposicion (getPosteo socialNet) postId)) (mi-map(getEncryp socialNet) users))))
                     )
                    (display "El id del post no existe")
                    )
                     (display "Al usuario dirigido el post no existe")
              )))))
  )


;Funcion : 
;Dom: socialNetworw X string X string
;Rec: socialNetworw
;Recursion: Natural
;Ejemplo de uso:
(define (socialnetwork->string socialNet)
  (if(null? socialNet)
                   "Nombre o Contraseña incorrectas."
  (if(null? (cadr(getUsuarioActivo socialNet)) )
     (string-append "\nNombre red Social: " (getNombre socialNet)
                 "\nFecha de creacion de la red Social: " (recorrerLista (getFecha socialNet))
                 "\nUsuarios de la red Social: "  (recorrerListadeListas (getUsuarios socialNet) socialNet)
                 "\nPublicaciones de la red Social: " (recorrerListadeListasPost (getPosteo socialNet) socialNet)
                 "\nSeguidores de los usuarios: " (recorrerListadeListasSeg (getFollow socialNet) socialNet)
                 "\nPublicaciones compartidos por los usuarios: " (compartidas (getShare socialNet) socialNet)
        "\n"
        )
     (string-append "\nNombre red Social: " (getNombre socialNet)
                 "\nFecha de creacion de la red Social: " (recorrerLista (getFecha socialNet))
                 "\nUsuario Activo dentro de la red social: "  ((getDecryp socialNet)(cadr(getUsuarioActivo socialNet)))
                 "\nPublicaciones del Usuario: "  (publicacionesUsuario (getPosteo socialNet) socialNet)
                 "\nSeguidores del Usuarios: " (seguidoresUsuario (getFollow socialNet) socialNet)
                 "\nPublicaciones compartidas por el Usuario: " (publicacionesCompartidasU (getShare socialNet) socialNet)
        "\n"
        )
     )
  )
 )

;Funcion : 
;Dom: socialNetworw X string X string
;Rec: socialNetworw
;Recursion: Natural
;Ejemplo de uso:
(define comment (lambda(socialNet)
                   (lambda(date)
                     (lambda(postId)
                       (lambda(content)
                         (if(null? socialNet)
                            (display "Nombre o Contraseña incorrectas.")
                            
                      (if(estaid? (getPosteo socialNet) postId)
                    (socialNetwork
                     (getNombre socialNet)
                     (getFecha socialNet)
                     (getEncryp socialNet)
                     (getDecryp socialNet)
                     (getUsuarios socialNet)
                     (list(car(getUsuarioActivo socialNet)) null)
                     (concatenar (getPosteo socialNet)(list (list (mi-map(getEncryp socialNet) date) ((getEncryp socialNet)"Comentario: ") (number->string postId) ((getEncryp socialNet) content) )))
                     (getFollow socialNet)
                     (getShare socialNet)
                     )
                    (display "El id del post no existe")
                    )
                          )
                          )
                         )
                       )
                     )
  )



;Funcion : 
;Dom: socialNetworw X string X string
;Rec: socialNetworw
;Recursion: Natural
;Ejemplo de uso:
(define (publicacionesUsuario lista socialNet)
                 (if(null? lista) ""
                    (if(equal? (getNameA (car lista)) (cadr(getUsuarioActivo socialNet)))
                       (string-append  "\n\n    PUBLICACION:  "((getDecryp socialNet) (getContent (car lista)))
                                       "\n      fecha de publicacion: " (recorrerLista (mi-map(getDecryp socialNet) (getDateP (car lista))))
                                       "\n      Usuarios dirigidos la publicación: " (recorrerLista (mi-map(getDecryp socialNet) (getUsers (car lista))))
                                       (publicacionesUsuario (cdr lista) socialNet)
                                   )
                                       (publicacionesUsuario (cdr lista) socialNet)
                    )
                 )
  )
;Funcion : 
;Dom: socialNetworw X string X string
;Rec: socialNetworw
;Recursion: Natural
;Ejemplo de uso:
(define (seguidoresUsuario lista socialNet)
                 (if(null? lista) ""
                    (if(equal? (caddr (car lista)) (cadr(getUsuarioActivo socialNet)))
                          (string-append  ((getDecryp socialNet)(car (car lista))) ", " (seguidoresUsuario (cdr lista) socialNet)
                                   )
                          (seguidoresUsuario (cdr lista) socialNet)
                       )
                 )
  )

;Funcion : 
;Dom: socialNetworw X string X string
;Rec: socialNetworw
;Recursion: Natural
;Ejemplo de uso:
(define (publicacionesCompartidasU lista socialNet)
                 (if(null? lista) ""
                    (if(equal? (car (car lista)) (cadr(getUsuarioActivo socialNet)))
                          (string-append  "\n\n    Publicacion compartida: "((getDecryp socialNet)(caddr (car lista))) 
                                          "\n    Id: " (number->string (cadr (car lista)))
                                          "\n    Usuarios compartida la publicación: " (recorrerLista (mi-map (getDecryp socialNet) (cadddr(car lista))))
                                          (publicacionesCompartidasU (cdr lista) socialNet)
                                   )
                          (publicacionesCompartidasU (cdr lista) socialNet)
                       )
                 )
  )
;Funcion : 
;Dom: socialNetworw X string X string
;Rec: socialNetworw
;Recursion: Natural
;Ejemplo de uso:
(define (recorrerLista lista)
                 (if(null? lista) ""
                   (string-append  (car lista) " "(recorrerLista (cdr lista)))
                    )
                 )


;Funcion : 
;Dom: socialNetworw X string X string
;Rec: socialNetworw
;Recursion: Natural
;Ejemplo de uso:
(define (recorrerListadeListas lista socialNet)
                 (if(null? lista) ""
                   (string-append  "\n    Fecha de login, Nombre Usuario : "(recorrerLista (mi-map(getDecryp socialNet) (getDate (car lista))))  ", " ((getDecryp socialNet) (getName (car lista))) (recorrerListadeListas (cdr lista) socialNet))
                    )
                 )

;Funcion : 
;Dom: socialNetworw X string X string
;Rec: socialNetworw
;Recursion: Natural
;Ejemplo de uso:
(define (recorrerListadeListasPost lista socialNet)
                 (if(null? lista) ""
                    (if(equal? (cadr (car lista)) ((getEncryp socialNet)"Comentario: "))
                     (string-append"\n    COMENTARIO, ID: " ((getDecryp socialNet) (cadddr (car lista))) ", " (caddr (car lista))
                                   "\n      Fecha de publicacion: "(recorrerLista (mi-map (getDecryp socialNet) (car (car lista))))
                                   (recorrerListadeListasPost (cdr lista) socialNet)) 
                     (string-append"\n    USUARIO QUE PUBLICO:  "((getDecryp socialNet) (getNameA (car lista)))
                                   "\n      Fecha de publicacion: " (recorrerLista (mi-map (getDecryp socialNet) (getDateP (car lista))))
                                   "\n      Publicacion: " ((getDecryp socialNet) (getContent (car lista)))
                                   "\n      Usuarios dirigidos el post: "(recorrerLista (mi-map (getDecryp socialNet) (getUsers (car lista)))) 
                                   
                                   (recorrerListadeListasPost (cdr lista) socialNet))
                   
                    )
                 )
  )
     

;Funcion : 
;Dom: socialNetworw X string X string
;Rec: socialNetworw
;Recursion: Natural
;Ejemplo de uso:
(define (recorrerListadeListasSeg lista socialNet)
                 (if(null? lista) ""
                   (string-append  "\n    Usuarios que se siguen:  "(recorrerLista (mi-map(getDecryp socialNet)  (car lista))) 
                                   
                                   (recorrerListadeListasSeg (cdr lista) socialNet))
                    )
                 )

;Funcion : 
;Dom: socialNetworw X string X string
;Rec: socialNetworw
;Recursion: Natural
;Ejemplo de uso:
(define (compartidas lista socialNet)
                 (if(null? lista) ""
                   (string-append  "\n    USUARIO:  "((getDecryp socialNet)  (car (car lista)))
                                   "\n       Compartio el post, con id: " ((getDecryp socialNet)  (caddr (car lista))) ", "  (number->string(cadr (car lista)))
                                   "\n       A los usuario: " (recorrerLista (mi-map(getDecryp socialNet)  (cadddr (car lista))))
                                   
                                   (compartidas (cdr lista) socialNet))
                    )
                 )


;Funcion : 
;Dom: socialNetworw X string X string
;Rec: socialNetworw
;Recursion: Natural
;Ejemplo de uso:
(define mi-map (lambda(funcion lista)
                 (if(empty? lista) '()

                    (cons (funcion (car lista)) (mi-map funcion (cdr lista)))
                    )
                 )
  )

;Funcion : 
;Dom: socialNetworw X string X string
;Rec: socialNetworw
;Recursion: Natural
;Ejemplo de uso:
(define mi-remove (lambda(elemento lista)
                  
                 (if(equal? elemento (car lista)) (cdr lista)

                    (cons (car lista) (mi-remove elemento (cdr lista)))
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
(define FB3 (((login FB2 "user1" "pass1" post) (date 28 10 2021)) "11nd post" "user3"))
(define FB4 (((login FB3 "user3" "pass3" post) (date 28 10 2021)) "12nd post" "user1"))
(define FB5 (((login FB4 "user3" "pass3" follow) (date 28 10 2021))"user1"))
(define FB6 (((login FB5 "user2" "pass2" follow) (date 28 10 2021))"user1"))
(define FB7 (((login FB6 "user1" "pass1" share) (date 28 10 2021)) 3 "user3"))
(define FB8 (((login FB7 "user1" "pass1" share) (date 28 10 2021)) 2 "user2" "user3"))

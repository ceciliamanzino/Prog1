#lang scribble/manual

@(require scribble/example)
@(require scriblib/footnote)


@;@(require racket-poppler/render-tex)
@;@(latex-path "/usr/bin/pdflatex")

@(define DrRacket (italic "DrRacket"))
@(define rack (italic "racket"))
@(define (csubexpr x) (elem @(italic x))) @; para la expresión cond y big-bang genérica, mejorar!

@(require racket/base)
@(require racket/sandbox)

@; define un evaluador que tiene, en su contexto, una variable mutable (un contador, digamos)
@; es para llevar un contador al estilo newcounter en latex. La idea es que los ejercios
@; a lo largo de toda la práctica tengan numeración correlativa. MEJORAR!!
@(define my-evaluator
   (parameterize ([sandbox-output 'string]
                  [sandbox-error-output 'string])
     (make-evaluator 'racket/base '(define ejer 0)
                                  '(define (incr-ejer) (set! ejer (+ ejer 1)))
                                  '(define ejemplo 0)
                                  '(define (incr-ejemplo) (set! ejemplo (+ ejemplo 1)))
                                  )))
@; si queremos incrementar el contador, hacemos lo siguiente: 
@;    @examples[#:eval my-evaluator #:hidden (incr)]
@; luego de incrementarlo, podemos usar el valor de eje como número de ejercicio:
@;    Ejercicio @examples[#:eval my-evaluator #:result-only eje].

@; así se pueden definir contadores para cada environment que uno quiera. Habría que investigar
@; un poco más si esto no está hecho (no lo encontré) y si no hay una forma mejor de hacerlo)

@title{Programación 1 - Recuperatorio Segundo Parcial}

@larger{Junio 2023}

@section{ESTRUCTURAS}
@; ejercicio -------------------
@; para incrementar el contador, mejorar!!!
@examples[#:eval my-evaluator #:hidden (incr-ejer)] @; incrementa contador
@bold{Ejercicio} @examples[#:eval my-evaluator #:result-only ejer]. @; usa el contador
En este ejercicio queremos representar la nómina de empleados de una empresa, con la siguiente
información:
@itemlist[
          @item{Nombre}
           @item{Salario básico}
           @item{Asistencias en el año}
           @item{Inasistencias en el año}
           ]

Usando estos valores, la empresa decide aumentar el salario de cada empleado, de acuerdo
a las siguientes condiciones:
@itemlist[
          @item{Si las inasistencias representan un valor menor o igual al 5% de las asistencias, se incrementa
  un 10% el salario.}
          @item{Si las inasistencias representan un valor mayor a 5% pero menor al 10% de las asistencias, se incrementa
  un 5% el salario.}
          @item{Sino se mantiene el mismo salario.}           
 ]

@itemlist[#:style 'ordered
          @item{Diseñe una estructura @racket[empleado] que permita representar toda la
          información necesaria.}
          @item{Diseñe una función @racket[nuevoSalario], dada una  estructura de tipo empleado,
           calcule el nuevo salario del empleado según la política de la empresa. 
          }
          @item{Diseñe una función @racket[liquidar] que dada una lista de estructuras de
           tipo empleado y un número m modifique la lista aumentando el sueldo de los empleados
           que cobren menos de m pesos usando la función @racket[nuevoSalario].}                                 
          ]
          
           
@section{FUNCIONES RECURSIVAS}

@; ejercicio -------------------
@; para incrementar el contador, mejorar!!!
@examples[#:eval my-evaluator #:hidden (incr-ejer)] @; incrementa contador
@bold{Ejercicio} @examples[#:eval my-evaluator #:result-only ejer]. @; usa el contador
Diseñe una función @racket[emparejar], que dado dos listas de números @racket[[a0, ... , ak]] y
@racket[[b0, ... , bj]], devuelve
una lista de estructuras @racket[posn] de la forma @racket[[p0, ..., pn]] tal que @racket[pi = (make-posn ai bi)],
para i en el conjunto {0,.., min k j}.

En caso de que las listas tengan diferente longitud, descarta los elementos de la lista de mayor longitud
que no se corresponden con ningún elemento en la otra lista.

Por ejemplo:
 @#reader scribble/comment-reader
           (racketblock
           (check-expect (emparejar (list 1 3) (list 40 50))
                  (list (make-posn 1 40) (make-posn 3 50)))
           (check-expect (emparejar (list 1 2 3) (list 40 50))
                  (list (make-posn 1 40) (make-posn 2 50)))
      )

No utilice las funciones @racket[map], @racket[foldr] o @racket[filter].

@section{PATRONES DE ALTO ORDEN}

@; ejercicio -------------------
@; para incrementar el contador, mejorar!!!
@examples[#:eval my-evaluator #:hidden (incr-ejer)] @; incrementa contador
@bold{Ejercicio} @examples[#:eval my-evaluator #:result-only ejer]. @; usa el contador
Diseñe una función @racket[max-sum] que dada una lista de listas de números devuelva
la suma de la sublista con mayor suma.

Por ejemplo,

@#reader scribble/comment-reader
(racketblock
(check-expect (max-sum (list (list -4 2) (list 2 4 -1) (list -2 3))) 5)
(check-expect (max-sum (list '() (list 2 -4) (list -1 -3))) 0)
)

En este ejercicio debe utilizar las funciones @racket[map], @racket[foldr] y/o @racket[filter] según lo
considere necesario.

Recuerde diseñar todas las funciones que defina.
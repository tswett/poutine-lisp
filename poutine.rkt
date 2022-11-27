#lang racket/base

(require racket/match)

(provide poutine-eval q-poutine-eval poutine-params poutine-apply)

(define (poutine-eval expr)
    (match expr 
        [`(quote ,value) value]
        [`(lambda ,params ,body) (make-closure params body)]
        [(cons func args) (poutine-apply (poutine-eval func) (map poutine-eval args))]))

(define q-poutine-eval '())

(define (make-closure params body) `(closure ,params ,body))

(define (poutine-params expr)
    (match expr
        [`(closure ,params ,body) params]))

(define (poutine-body expr)
    (match expr
        [`(closure ,params ,body) body]))

(define (poutine-closure? expr)
    (match expr
        [`(closure ,params ,body) #t]
        [_ #f]))

(define (poutine-apply func . args)
    (cond
        [(poutine-closure? func) (poutine-eval (poutine-body func))]
        [#t (error "unknown kind of function")]))
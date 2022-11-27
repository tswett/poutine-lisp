#lang racket/base

(require racket/match)

(provide poutine-eval q-poutine-eval poutine-params poutine-apply)

(define (poutine-eval expr)
    (match expr 
        [`(quote ,value) value]
        [`(lambda ,params ,body) (make-closure params)]))

(define q-poutine-eval '())

(define (make-closure params) `(closure ,params))

(define (poutine-params expr)
    (match expr
        [`(closure ,params) params]))

(define (poutine-apply func . args) (error "not implemented"))

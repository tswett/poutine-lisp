#lang racket/base

(require rackunit (only-in "poutine.rkt" poutine-eval q-poutine-eval poutine-params poutine-apply))

(define def-id '(lambda (x) x))

(define quine '((lambda (x) (list x (list 'quote x))) '(lambda (x) (list x (list 'quote x)))))

(check-equal? (poutine-eval ''x) 'x "evaluating a quoted value yields the value")

(check-equal? (poutine-params (poutine-eval def-id))
              '(x)
              "evaluating a lambda yields a closure with the correct parameters")

(check-equal? (poutine-eval quine) quine "evaluating this quine yields the quine itself")

(check-equal? (poutine-apply (poutine-eval q-poutine-eval) quine) quine "the self-evaluator works")

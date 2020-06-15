(defrule startup ""
  =>
  (assert (data1 4 100)
          (data2 n y y n)
          (data3 y y n)))

(defrule mw-high ""
    (data1 ?x ?y)
    (test  (> ?x 5) )
    =>
    (assert (mw-risk 5)))

(defrule mw-medium ""
    (data1 ?x ?y)
    (test (and (> ?x 0) (< ?x 5)))
    =>
    (assert (mw-risk 3)))

(defrule mw-low	 ""
    (data1 ?x ?y)
    (test (eq ?x 0))
    =>
    (assert (mw-risk 0)))


(defrule as-medium ""
    (data2 ?a ?b ?c ?d)
    (test  (or (and (eq ?a n) (eq ?b y) (eq ?c y) (eq ?d n))
               (and (eq ?a n) (eq ?b y) (eq ?c n) (eq ?d y))
               (and (eq ?a n) (eq ?b n) (eq ?c y) (eq ?d y))))
    =>
    (assert (as-risk 4)))

(defrule as-high ""
    (data2 ?a ?b ?c ?d)
    (test (or (eq ?a y) 
              (and (eq ?b y) (eq ?c y) (eq ?d y))))
    =>
    (assert (as-risk 6)))

(defrule as-low	 ""
    (data2 ?a ?b ?c ?d)
    (test  (or (and (eq ?a n) (eq ?b y) (eq ?c n) (eq ?d n))
               (and (eq ?a n) (eq ?b n) (eq ?c y) (eq ?d n))
               (and (eq ?a n) (eq ?b n) (eq ?c n) (eq ?d y))))
    =>
    (assert (as-risk 2)))


(defrule as-very-low  ""
    (data2 ?a ?b ?c ?d)
    (test  (and (eq ?a n) (eq ?b n) (eq ?c n) (eq ?d n)))
    =>
    (assert (as-risk 0)))

(defrule bonus-high  ""
    (data3 ?a ?b ?c)
    (test  (or (and (eq ?a y) (eq ?b y) (eq ?c y))
               (and (eq ?a n) (eq ?b y) (eq ?c y))
               (and (eq ?a y) (eq ?b y) (eq ?c n))
               (and (eq ?a y) (eq ?b n) (eq ?c y))))
    =>
    (assert (bonus-risk -2)))

(defrule bonus-medium  ""
    (data3 ?a ?b ?c)
    (test  (or (and (eq ?a y) (eq ?b n) (eq ?c n))
               (and (eq ?a n) (eq ?b y) (eq ?c n))
               (and (eq ?a n) (eq ?b n) (eq ?c y))))
    =>
    (assert (bonus-risk -1)))

(defrule bonus-low  ""
    (data3 ?a ?b ?c)
    (test (and (eq ?a n) (eq ?b n) (eq ?c n)))
    =>
    (assert (bonus-risk 0)))

(defrule evaluation ""
    (as-risk ?a)
    (mw-risk ?b)
    (bonus-risk ?c)
    =>
    (assert (final-evaluation (+ ?a ?b ?c))))



(*
** BUCASCS320-2013-Spring: implementing a calculator
** Instructor: Hongwei Xi
*)

(* ****** ****** *)

staload "calc.sats"

(* ****** ****** *)

datatype
aexp_node =
  | AEXPval of double
  | AEXPneg of (aexp)
  | AEXPadd of (aexp, aexp)
  | AEXPsub of (aexp, aexp)
  | AEXPmul of (aexp, aexp)
  | AEXPdiv of (aexp, aexp)
// end of [aexp_node]

assume
aexp_type = '{
  aexp_node= aexp_node
}

(* ****** ****** *)

implement
aexp_eval (e0) = let
//
macdef eval = aexp_eval
//
in
//
case+ e0.aexp_node of
| AEXPval (v) => v
| AEXPneg (e) => ~(eval (e))
| AEXPadd (e1, e2) => eval (e1) + eval (e2)
| AEXPsub (e1, e2) => eval (e1) - eval (e2)
| AEXPmul (e1, e2) => eval (e1) * eval (e2)
| AEXPdiv (e1, e2) => eval (e1) / eval (e2)
//
end // end of [aexp_eval]

(* ****** ****** *)

implement
aexp_int
  (i) = let
  val f =
    double_of_int (i)
  // end of [val]
in '{
  aexp_node= AEXPval (f)
} end // end of [aexp_int]

implement
aexp_add
  (e1, e2) = '{
  aexp_node= AEXPadd (e1, e2)
} // end of [aexp_add]

implement
aexp_sub
  (e1, e2) = '{
  aexp_node= AEXPsub (e1, e2)
} // end of [aexp_sub]

implement
aexp_mul
  (e1, e2) = '{
  aexp_node= AEXPmul (e1, e2)
} // end of [aexp_mul]

implement
aexp_div
  (e1, e2) = '{
  aexp_node= AEXPdiv (e1, e2)
} // end of [aexp_div]

(* ****** ****** *)

(* end of [calc_aexp.dats] *)

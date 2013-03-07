(*
** BUCASCS320-2013-Spring: implementing a calculator
** Instructor: Hongwei Xi
*)

#define ATS_DYNLOADFLAG 0

#define ATS_DYNLOADFUN_NAME "ats_calc_init"


(* ****** ****** *)

staload "calc.sats"

staload UN = "prelude/SATS/unsafe.sats"
staload _ = "prelude/DATS/unsafe.dats"


(* ****** ****** *)

implement
calc_exn (inp) = let
  val aexp = string_parse (inp) in aexp_eval (aexp)
end // end of [calc]

implement
calc (inp, ret) = 
try
  let
    val aexp = string_parse (inp)
    val ans = aexp_eval (aexp)
    val () = $UN.ptrset<double> (&ret, ans)
  in 
    0
  end
with ~IllegalTokenExn (token) => ~2
| ~UnknownCharExn (char) => ~1
// end of [calc]

(* ****** ****** *)

dynload "calc_aexp.dats"
dynload "calc_token.dats"
dynload "calc_cstream.dats"
dynload "calc_tstream.dats"
dynload "calc_parser.dats"

(* ****** ****** *)
(*
implement
main (argc, argv) = {
//
val out = stdout_ref
//
val () = assertloc (argc >= 2)
//
val ae_val = aexp_eval (string_parse (argv.[1]))
//
val () = println! ("The answer is: ", ae_val)
//
} // end of [main]
*)
(* ****** ****** *)


(* end of [calc.dats] *)

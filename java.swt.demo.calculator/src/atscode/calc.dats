(*
** BUCASCS320-2013-Spring: implementing a calculator
** Instructor: Hongwei Xi
*)

(* ****** ****** *)

staload "calc.sats"

(* ****** ****** *)

implement
calc (inp) = let
  val aexp = string_parse (inp) in aexp_eval (aexp)
end // end of [calc]

(* ****** ****** *)

dynload "calc_aexp.dats"
dynload "calc_token.dats"
dynload "calc_cstream.dats"
dynload "calc_tstream.dats"
dynload "calc_parser.dats"

(* ****** ****** *)

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

(* ****** ****** *)

(* end of [calc.dats] *)

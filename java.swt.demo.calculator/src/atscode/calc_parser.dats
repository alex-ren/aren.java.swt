(*
** BUCASCS320-2013-Spring: implementing a calculator
** Instructor: Hongwei Xi
*)

(* ****** ****** *)

#include "BUCASCS320.hats"

(* ****** ****** *)

staload "calc.sats"

(* ****** ****** *)

(*

A grammar for aexp:

expr   ::=   term exprk

exprk  ::=   ('+' | '-') term exprk | (*empty*)

term   ::=   factor termk

termk  ::=   ('*' | '/') factor termk | (*empty*)

factor ::=   INT | '(' expr ')'

*)

(* ****** ****** *)

typedef
faexp = (aexp) -<cloref1>  aexp

extern fun p_expr (ts: tstream): aexp

extern fun p_exprk (ts: tstream): faexp

extern fun p_term (ts: tstream): aexp

extern fun p_termk (ts: tstream): faexp

extern fun p_factor (ts: tstream): aexp

extern fun p_TOKeof (ts: tstream): void

extern fun p_TOKlpar (ts: tstream): void
extern fun p_TOKrpar (ts: tstream): void

(* ****** ****** *)

exception IllegalTokenExn of (token)

(* ****** ****** *)

(*
expr   ::=   term exprk
*)
implement
p_expr (ts) = let
  val ae1 = p_term (ts)
  val fae2 = p_exprk (ts)
in
  fae2 (ae1)
end // end of [p_expr]

(* ****** ****** *)

(*
exprk  ::=   ('+' | '-') term exprk | (*empty*)
*)
implement
p_exprk (ts) = let
  val t0 = tstream_get_token (ts)
in
//
case+ 0 of
| _ when
    token_is_add (t0) => let
    val () = tstream_inc (ts)
    val ae2 = p_term (ts)
    val fae3 = p_exprk (ts)
  in
    lam (ae) => fae3 (aexp_add (ae, ae2))
  end
| _ when
    token_is_sub (t0) => let
    val () = tstream_inc (ts)
    val ae2 = p_term (ts)
    val fae3 = p_exprk (ts)
  in
    lam (ae) => fae3 (aexp_sub (ae, ae2))
  end
| _ => lam (ae) => ae
//
end // end of [p_exprk]

(* ****** ****** *)

implement
p_term (ts) = let
  val ae1 = p_factor (ts)
  val fae2 = p_termk (ts)
in
  fae2 (ae1)
end // end of [p_term]

(* ****** ****** *)

implement
p_termk (ts) = let
  val t0 = tstream_get_token (ts)
in
//
case+ 0 of
| _ when
    token_is_mul (t0) => let
    val () = tstream_inc (ts)
    val ae2 = p_factor (ts)
    val fae3 = p_termk (ts)
  in
    lam (ae) => fae3 (aexp_mul (ae, ae2))
  end
| _ when
    token_is_div (t0) => let
    val () = tstream_inc (ts)
    val ae2 = p_factor (ts)
    val fae3 = p_termk (ts)
  in
    lam (ae) => fae3 (aexp_div (ae, ae2))
  end
| _ => lam (ae) => ae
//
end // end of [p_termk]

(* ****** ****** *)

implement
p_factor (ts) = let
  val t0 = tstream_get_token (ts)
in
//
case+ t0 of
| TOKint (i) => let
    val () = tstream_inc (ts)
  in
    aexp_int (i)
  end // end of [TOKint]
| TOKlpar () => let
    val () = tstream_inc (ts)
    val fae2 = p_expr (ts)
    val () = p_TOKrpar (ts)
  in
    fae2
  end // end of [TOKlpar]
| _ => $raise IllegalTokenExn (t0)
//
end // end of [p_factor]

(* ****** ****** *)

implement
p_TOKeof (ts) = let
  val t0 = tstream_get_token (ts)
in
//
case+ t0 of
| TOKeof () => let
    val () = tstream_inc (ts)
  in
    // nothing
  end // end of [TOKrpar]
| _ => $raise IllegalTokenExn (t0)
//
end // end of [p_TOKeof]

(* ****** ****** *)

implement
p_TOKrpar (ts) = let
  val t0 = tstream_get_token (ts)
in
//
case+ t0 of
| TOKrpar () => let
    val () = tstream_inc (ts)
  in
    // nothing
  end // end of [TOKrpar]
| _ => $raise IllegalTokenExn (t0)
//
end // end of [p_TOKrpar]

(* ****** ****** *)

implement
string_parse
  (inp) = ae where {
  val cs =
    cstream_make_string (inp)
  val ts = cstream_tokenize (cs)
  val ts = tstream_make_tokenlst (ts)
  val ae = p_expr (ts)
  val () = p_TOKeof (ts)
} // end of [string_parse]

(* ****** ****** *)

(* end of [calc_parser.dats] *)

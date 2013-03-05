(*
** BUCASCS320-2013-Spring: implementing a calculator
** Instructor: Hongwei Xi
*)

staload "calc.sats"

(* ****** ****** *)

implement
token_is_add (t) = (
  case+ t of
  | TOKname "add" => true
  | TOKname2 ("+") => true
  | _ => false
) // end of [token_is_add]

implement
token_is_sub (t) = (
  case+ t of
  | TOKname "sub" => true
  | TOKname2 ("-") => true
  | _ => false
) // end of [token_is_sub]

implement
token_is_mul (t) = (
  case+ t of
  | TOKname "mul" => true
  | TOKname2 ("*") => true
  | _ => false
) // end of [token_is_mul]

implement
token_is_div (t) = (
  case+ t of
  | TOKname "div" => true
  | TOKname2 ("/") => true
  | _ => false
) // end of [token_is_div]

(* ****** ****** *)

implement
fprint_token
  (out, x) = let
//
macdef prstr (a) = fprint_string (out, ,(a))
//
in
//
case+ x of
| TOKint (i) => {
    val () = prstr "TOKint("
    val () = fprint_int (out, i)
    val () = prstr ")"
  }
//
| TOKname (name) => {
    val () = prstr "TOKname("
    val () = fprint_string (out, name)
    val () = prstr ")"
  }
| TOKname2 (name) => {
    val () = prstr "TOKname2("
    val () = fprint_string (out, name)
    val () = prstr ")"
  }
//
| TOKlpar () => prstr "TOKlpar()"
| TOKrpar () => prstr "TOKrpar()"
//
| TOKeof () => prstr "TOKeof()"
//
end // end of [fprint_token]

(* ****** ****** *)

implement
fprint_tokenlst
  (out, xs) = let
//
fun loop (
  out: FILEref, sep: string, xs: tokenlst, i: int
) : void = let
in
//
case+ xs of
| list0_cons
    (x, xs) => let
    val () = if i > 0 then fprint_string (out, sep)
    val () = fprint_token (out, x)
  in
    loop (out, sep, xs, i+1)
  end // end of [list0_cons]
| list0_nil () => ()
//
end // end of [loop]
//
in
  loop (out, ", ", xs, 0)
end // end of [fprint_tokenlst]

(* ****** ****** *)

(* end of [calc_token.dats] *)

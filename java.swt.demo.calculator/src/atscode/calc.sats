(*
** BUCASCS320-2013-Spring: implementing a calculator
** Instructor: Hongwei Xi
*)

(* ****** ****** *)

fun calc (inp: string): double = "atscalc"

abstype aexp_type // for arithmetic expressions
typedef aexp = aexp_type

(* ****** ****** *)

fun aexp_eval (x: aexp): double // done!

(* ****** ****** *)

fun aexp_int (i: int): aexp
fun aexp_add (x: aexp, y: aexp): aexp
fun aexp_sub (x: aexp, y: aexp): aexp
fun aexp_mul (x: aexp, y: aexp): aexp
fun aexp_div (x: aexp, y: aexp): aexp

(* ****** ****** *)

fun string_parse (inp: string): aexp

(* ****** ****** *)

datatype token =
  | TOKint of int
  | TOKname of string // operator name
  | TOKname2 of string // symbolic operator name
  | TOKlpar of () // left parenthesis
  | TOKrpar of () // right parenthesis
  | TOKeof of ()
// end of [token]

typedef tokenlst = list0 (token)

(* ****** ****** *)

fun token_is_add (t: token): bool
fun token_is_sub (t: token): bool
fun token_is_mul (t: token): bool
fun token_is_div (t: token): bool

(* ****** ****** *)

fun fprint_token (out: FILEref, t: token): void
fun fprint_tokenlst (out: FILEref, ts: tokenlst): void

(* ****** ****** *)

abstype cstream_type
typedef cstream = cstream_type

(* ****** ****** *)

fun cstream_make_string (inp: string): cstream

(* ****** ****** *)

fun cstream_inc (cs: cstream): void // O(1)
fun cstream_get_char (cs: cstream): int // O(1)

fun cstream_get_at (cs: cstream, i: int): char // O(1)
fun cstream_get_range (cs: cstream, i: int, j: int): string // [i, j)

(* ****** ****** *)

fun cstream_tokenize (cs: cstream): tokenlst

(* ****** ****** *)

abstype tstream_type
typedef tstream = tstream_type

(* ****** ****** *)

fun tstream_make_tokenlst (ts: tokenlst): tstream

(* ****** ****** *)

fun tstream_inc (ts: tstream): void // O(1)
fun tstream_get_token (ts: tstream) : token // O(1)

(* ****** ****** *)

(* end of [calc.sats] *)

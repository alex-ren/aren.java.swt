(*
** BUCASCS320-2013-Spring: implementing a calculator
** Instructor: Hongwei Xi
*)

(* ****** ****** *)

#include "BUCASCS320.hats"

(* ****** ****** *)

staload "calc.sats"

(* ****** ****** *)

exception UnknownCharExn of (char)

(* ****** ****** *)

fun char_issymbl (c: char) = string_contains ("~+-*/%", c)

(* ****** ****** *)

extern
fun cstream_skip
  (cs: cstream, f: int -> bool): void
implement
cstream_skip (cs, f) = let
  val c = cstream_get_char (cs)
in
  if f (c) then (cstream_inc (cs); cstream_skip (cs, f))
end // end of [ctsream_skip]

extern
fun cstream_skip_WS (cs: cstream): void

implement
cstream_skip_WS (cs) = (
  cstream_skip (cs, lam (c) => char_isspace (char_of_int(c)))
) // end of [cstream_skip_WS]

(* ****** ****** *)

extern
fun cstream_lex_token (cs: cstream): token
extern
fun cstream_lex2_token (c: int, cs: cstream): token

extern
fun cstream_lex_int (cs: cstream): int
extern
fun cstream_lex_name (cs: cstream): string
extern
fun cstream_lex_name2 (cs: cstream): string

(* ****** ****** *)

implement
cstream_lex_token
  (cs) = let
//
val () = cstream_skip_WS (cs)
//
val c0 = cstream_get_char (cs)
//
in
//
if c0 >= 0
  then cstream_lex2_token (c0, cs)
  else TOKeof ()
//
end // end of [cstream_lex_token]

(* ****** ****** *)

implement
cstream_lex2_token
  (c0, cs) = let
  val c0 = char_of_int (c0)
in
//
case+ 0 of
| _ when c0 = '\(' => let
    val () = cstream_inc (cs) in TOKlpar ()
  end // end of [_]
| _ when c0 = ')' => let
    val () = cstream_inc (cs) in TOKrpar ()
  end // end of [_]
| _ when char_isdigit (c0) => let
    val int = cstream_lex_int (cs) in TOKint (int)
  end // end of [_]
| _ when char_isalpha (c0) => let
    val name = cstream_lex_name (cs) in TOKname (name)
  end // end of [_]
| _ when char_issymbl (c0) => let
    val name = cstream_lex_name2 (cs) in TOKname2 (name)
  end // end of [_]
| _ => $raise UnknownCharExn(c0)
//
end // end of [cstream_lex2_token]

(* ****** ****** *)

implement
cstream_lex_int (cs) = let
//
fun loop (
  cs: cstream, res: int
) : int = let
  val c = cstream_get_char (cs)
in
//
if c >= 0 then let
  val c = char_of_int (c)
  val test = char_isdigit (c)
in
//
if test then let
  val () = cstream_inc (cs)
in
  loop (cs, 10 * res + (c - '0'))
end else res
//
end else res
//
end // end of [loop]
//
in
  loop (cs, 0)
end // end of [cstream_lex_int]

(* ****** ****** *)

local

fun auxmain (
  cs: cstream, f: char -> bool
) : list0 (char) = let
//
fun loop (
  cs: cstream, f: char -> bool, res: list0 (char)
) : list0 (char) = let
  val c = cstream_get_char (cs)
in
//
if c >= 0 then let
  val c = char_of_int (c)
in
//
if f (c) then let
  val () = cstream_inc (cs)
in
  loop (cs, f, list0_cons (c, res))
end else res
//
end else res
//
end // end of [loop]
//
in
  loop (cs, f, list0_nil)
end // end of [auxmain]

in (* in of [local] *)

implement
cstream_lex_name (cs) = let
in
  string_make_list0_rev (auxmain (cs, char_isalpha))
end // end of [cstream_lex_name]

implement
cstream_lex_name2 (cs) = let
in
  string_make_list0_rev (auxmain (cs, char_issymbl))
end // end of [cstream_lex_name]

end // end of [local]

(* ****** ****** *)

local

assume
cstream_type = '{
  cstream_pos= ref (int), cstream_data= array0 (char)
} // end of [cstream_type]

in (* in of [local] *)

implement
cstream_make_string
  (inp) = let
  val pos = ref<int> (0)
  val data = array0_make_string (inp)
in '{
  cstream_pos= pos, cstream_data= data 
} end // end of [cstream_make_string]

(* ****** ****** *)

implement
cstream_inc (cs) = let
  val r = cs.cstream_pos in !r := !r + 1
end // end of [cstream_inc]

implement
cstream_get_char (cs) = let
  val i = !(cs.cstream_pos)
  val data = cs.cstream_data
  val asz = array0_size (data)
  val asz = int_of_size (asz)
in
  if asz > i then int_of_char (data[i]) else ~1
end // end of [cstream_get_char]

end // end of [local]

(* ****** ****** *)

(*
fun cstream_tokenize (cs: cstream): tokenlst
*)
implement
cstream_tokenize (cs) = let
//
fun loop (
  cs: cstream, res: tokenlst
) : tokenlst = let
  val tok = cstream_lex_token (cs)
  val res = list0_cons (tok, res)
in
//
case+ tok of
| TOKeof () => res | _ => loop (cs, res)
//
end // end of [loop]
//
in
  list0_reverse (loop (cs, list0_nil))
end // end of [cstream_tokenize]

(* ****** ****** *)

(* end of [calc_cstream.dats] *)

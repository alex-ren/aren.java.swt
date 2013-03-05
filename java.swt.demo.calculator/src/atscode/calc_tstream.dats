(*
** BUCASCS320-2013-Spring: implementing a calculator
** Instructor: Hongwei Xi
*)

(* ****** ****** *)

#include "BUCASCS320.hats"

(* ****** ****** *)

staload "calc.sats"

(* ****** ****** *)

local

assume
tstream_type = '{
  tstream_pos= ref (int), tstream_data= array0 (token)
} // end of [tstream_type]

in (* in of [local] *)

implement
tstream_make_tokenlst
  (ts) = let
  val pos = ref<int> (0)
  val data = array0_make_lst (ts)
in '{
  tstream_pos= pos, tstream_data= data 
} end // end of [tstream_make_tokenlst]

(* ****** ****** *)

implement
tstream_inc (ts) = let
  val r = ts.tstream_pos in !r := !r + 1
end // end of [tstream_inc]

implement
tstream_get_token (ts) = let
  val i = !(ts.tstream_pos)
  val data = ts.tstream_data
  val asz = array0_size (data)
  val asz = int_of_size (asz)
in
  if asz > i then data[i] else TOKeof ()
end // end of [tstream_get_char]

end // end of [local]

(* ****** ****** *)

(* end of [calc_tstream.dats] *)

TYPE_CONV_PATH "Json"
open Printf

type i1 = int32
and  i2 = int
and  i3 = int64
and  i4 = ( int32 * int * int64 )
and  p =
  | One of string * int array
  | Two of t
  | Three of x option list

and pp = [ `Poly1 | `Poly2 | `Poly3 of int ]

and t = {
  t1: int;
  mutable t2: string;
  t3: x
} and x = {
  x1: t array;
  x2: int64
} and f = {
  mutable f1: int;
  mutable f2: string list;
  f3: string;
  f4: int64;
  f5: char array;
} and tu = ( int  * f * pp )

with json

type o =
  < x: f; y: x; z: (int -> string) > 
  with json

open OUnit

let (<=>) n t =
  let ts = Json.to_string t in
  printf "%s: %s\n%!" n ts;
  printf "%s: %s\n%!" n (Json.to_string (Json.of_string ts));
  ("EQ " ^ n) @? ( t = Json.of_string ts)

let test_marshal () =
  "i1" <=> type_of_i1;
  "i2" <=> type_of_i2;
  "i3" <=> type_of_i3;
  "i4" <=> type_of_i4;
  "p"  <=> type_of_p;
  "pp" <=> type_of_pp;
  "t"  <=> type_of_t;
  "x"  <=> type_of_x;
  "f"  <=> type_of_f;
  "tu" <=> type_of_tu;
  "o"  <=> type_of_o

let suite = [
  "type_marshal" >::  test_marshal
]

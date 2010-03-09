TYPE_CONV_PATH "Json_simple"
open Printf

type x = {
  foo: int;
  bar: (string * string) list;
} with json

open OUnit

let test_marshal () =
  let x1 = { foo=1; bar=[("hello","world");"one","two"] } in
  let s = json_of_x x1 in
  print_endline s

let suite = [
  "type_marshal" >::  test_marshal
]

open OUnit
open Printf

let suites = [
  Test_json_simple.suite;
  Test_blog.suite;
  Test_json.suite;
  Test_html.suite;
]

let _ =
  let s = suites in
  run_test_tt_main ("Shelf" >::: (List.flatten s))

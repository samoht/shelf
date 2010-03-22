TYPE_CONV_PATH "Blog"
open Printf

type markup =
 | HTML of string
 | Markdown of string
 | Null
and blog = {
  title: string;
  author: string;
  body: markup;
  extended: markup;
  keywords: string list;
  ctime: float;
  mtime: float;
  permalink: string;
  guid: string;
} with json

open OUnit

let b = { title="title1"; author="author1"; body=HTML "<body>"; 
   extended=Markdown ".md"; keywords=["tag1";"tag2"]; ctime=1.; mtime=2.; 
   permalink="http://blah"; guid="guid1" 
}

let (<=>) n (f,t,v) =
  let json = f v in
  printf "1: %s: json1= %s\n%!" n json;
  try
    let v' = t json in
    let json' = f v' in
    printf "2: %s: json2= %s\n%!" n json';
    ("EQ " ^ n) @? ( json = json' )
  with
    e -> printf "ERR: %s\n%!" (Printexc.to_string e); raise e

let test_b ()  = "b"  <=> (json_of_blog, blog_of_json, b)

let suite = [
  "test_b" >::  test_b;
(*
  "test_f" >::  test_f;
  "test_tu" >::  test_tu;
*)
]

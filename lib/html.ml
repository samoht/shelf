(*
 * Copyright (c) 2010 Thomas Gazagnaire <thomas@gazagnaire.com>
 *
 * Permission to use, copy, modify, and distribute this software for any
 * purpose with or without fee is hereby granted, provided that the above
 * copyright notice and this permission notice appear in all copies.
 *
 * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 *)

open Value

let escape_string s =
	let buf = Buffer.create 80 in
	Buffer.add_string buf "\"";
	for i = 0 to String.length s - 1
	do
		let x =
			match s.[i] with
			| '\n'   -> "<br/>"
			| '\t'   -> "&nbsp;"
			| '\r'   -> "&nbsp;"
			| '\b'   -> "&nbsp;"
			| '<'    -> "&lt;"
			| '>'    -> "&gt;"
			| '&'    -> "&amp;"
			| c      -> String.make 1 c
			in
		Buffer.add_string buf x
	done;
	Buffer.add_string buf "\"";
	Buffer.contents buf

let rec to_fct t f =
	match t with
	| Unit     -> f ""
	| Int i    -> f (Printf.sprintf "%Ld" i)
	| Bool b   -> f (string_of_bool b)
	| Float r  -> f (Printf.sprintf "%f" r)
	| String s -> f (escape_string s)
	| Enum a   ->
		f "<ul>\n";
		List.iter (fun i -> f "<li>"; to_fct i f; f "</li>\n") a;
		f "</ul>";
	| Tuple a  ->
		to_fct (Enum a) f
	| Dict a   ->
		f "<dl>\n";
		List.iter (fun (k, v) -> f "<dt>"; to_fct (String k) f; f "</dt>\n<dd>"; to_fct v f; f "</dd>\n") a;
		f "</dl>\n"
	| Sum (v, args) ->
		to_fct (Enum (String v :: args)) f 
	| Null     -> f "null"
	| Value t  -> to_fct t f
	| Arrow t  -> failwith "Marshalling of functional values is not (yet) supported"
	| Rec ((v,i), t)
	| Ext ((v,i), t) ->
		f (Printf.sprintf "<div class=%s id=%Ld>\n" v i);
		to_fct t f;
		f "</div>"
	| Var (v,i) ->
		f (Printf.sprintf "<div class=%s id=%Ld/>\n" v i)

let to_buffer t buf =
	to_fct t (fun s -> Buffer.add_string buf s)

let to_string t =
	let buf = Buffer.create 2048 in
	to_buffer t buf;
	Buffer.contents buf

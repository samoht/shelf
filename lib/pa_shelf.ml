(*pp camlp4orf *)
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

open Camlp4
open PreCast
open Ast

module Json = struct
	let json_of n = "json_of_" ^ n

	let of_json n = n ^ "_of_json"

	let gen_both (n, ty) =
		let _loc = loc_of_ctyp ty in
		[
			<:binding< $lid:json_of n$ x = Json.to_string ($lid:P4_value.value_of n$ x) >>;
			<:binding< $lid:of_json n$ x = $lid:P4_value.of_value n$ (Json.of_string $lid:P4_type.type_of n$ x) >>;
		]
end

module Html = struct
	let html_of n = "html_of_" ^ n
	
	let gen_both (n, ty) =
		let _loc = loc_of_ctyp ty in
		[
			<:binding< $lid:html_of n$ x = Html.to_string ($lid:P4_value.value_of n$ x) >>;
			(* TODO *)
		]
end

let _ =
	 Pa_type_conv.add_generator "json"
		(fun tds ->
			let _loc = loc_of_ctyp tds in
			<:str_item<
				$P4_value.gen tds$;
				$P4_type.gen tds$;
				value $biAnd_of_list (List.flatten (List.map Json.gen_both (P4_value.list_of_ctyp_decl tds)))$; 
			>>
		);

	 Pa_type_conv.add_generator "html"
		(fun tds ->
			let _loc = loc_of_ctyp tds in
			<:str_item<
				$P4_value.gen tds$;
				value $biAnd_of_list (List.flatten (List.map Html.gen_both (P4_value.list_of_ctyp_decl tds)))$; 
			>>
		);



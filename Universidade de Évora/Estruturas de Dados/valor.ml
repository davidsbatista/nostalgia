
(* avaliacao de uma expressao em notação polaca inversa *)

(* valor : string list -> int *)

let valor expressao =
  let rec valor_i pilha =
    function [] -> top pilha
    |        ("-" | "+" | "*" | "/" as operador)::resto ->
      let operando2 = top pilha in
	let pilha = pop pilha in
	  let operando1 = top pilha in
	    let resultado =
	      match operador
	        with "-" -> operando1 - operando2
	        |    "+" -> operando1 + operando2
		|    "*" -> operando1 * operando2
		|    "/" -> operando1 / operando2
	    in
	      valor_i (push (pop pilha) resultado) resto
    |        numero::resto ->
      valor_i (push pilha (int_of_string numero)) resto
  in
    valor_i (cria 0) expressao;;


(* 
   valor [ "1"; "2"; "+"; "3"; "*"; "5"; "-" ] -> 4
   valor [ "1"; "2"; "+"; "3"; "*"; "5"; "-"; "2"; "/" ] -> 2
   valor [ "1"; "2"; "3"; "4"; "-"; "-"; "-" ] -> -2
*)

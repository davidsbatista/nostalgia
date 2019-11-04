
(* implementação do TAD lista, com cauda (sem dummy) *)

(* tipo ``lista'' *)

type 'a lista = { mutable cabeca : 'a celula; mutable cauda : 'a celula } and
     'a celula = NIL | NO of 'a elemento and
     'a elemento = { valor : 'a; mutable proximo : 'a celula };;


(* cria : 'a -> 'a lista - cria lista vazia de elementos do tipo 'a *)

let cria tipo = { cabeca = NIL; cauda = NIL };;


(* vazia : 'a lista -> bool - diz se a lista está vazia *)

let vazia lista = lista.cabeca = NIL;;


(* insere : 'a lista -> 'a -> 'a lista - insere um elemento à cabeca da
					 lista *)

let insere lista elemento =
  lista.cabeca <- NO { valor = elemento; proximo = lista.cabeca };
  if lista.cauda = NIL then (* a lista estava vazia *)
    lista.cauda <- lista.cabeca;
  lista;;


(* remove : 'a lista -> int -> 'a lista - remove o elemento que está em
					  posição (a do primeiro elemento é
					  a 1) e devolve a nova lista *)

let remove lista posicao =
  let rec remove_i =
    fun NIL _ -> failwith "posicao invalida"
    |   (NO elem) 1 ->
      elem.proximo
    |   ((NO elem) as no) pos ->
      elem.proximo <- remove_i elem.proximo (pos - 1);
      if elem.proximo = NIL then (* removeu o último elemento da lista *)
	lista.cauda <- no;
      no
  in
    lista.cabeca <- remove_i lista.cabeca posicao;
    if lista.cabeca = NIL then (* removeu o único elemento da lista *)
      lista.cauda <- NIL;
    lista;;


(* listar : 'int lista -> unit - mostra o conteúdo de uma lista de inteiros *)

let mostra lista =
  let rec mostra_i =
    function NIL -> print_newline ()
    |        NO { valor = v; proximo = p } ->
      print_int v;
      print_char ` `;
      mostra_i p
  in
    mostra_i lista.cabeca;;

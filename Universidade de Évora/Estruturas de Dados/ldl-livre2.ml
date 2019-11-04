
(* lista duplamente ligada *)

(* tipo *)

type 'a lista = { cabeca : int; cauda : int;
		  valor : 'a vect; proximo : int vect; anterior : int vect;
		  mutable livre : int };;


(* cria : 'a -> 'a lista *)

let cria tipo =
  let TAMANHO = 10 in
    let lista = { cabeca = 0; cauda = 0; valor = make_vect TAMANHO tipo;
		   proximo = make_vect TAMANHO (-1);
		   anterior = make_vect TAMANHO (-1); livre = 1 }
    in
      for i = lista.livre to TAMANHO - 2 do
	lista.proximo.(i) <- i + 1
      done;
      lista.proximo.(lista.cabeca) <- lista.cauda;
      lista.anterior.(lista.cauda) <- lista.cabeca;
      lista;;


(* insere : 'a -> 'a lista -> 'a lista - insere elemento na cauda da lista *)

let insere elemento lista =
  if lista.livre = -1 then
    failwith "espaco esgotado"
  else
    let nova_cauda = lista.livre in
      lista.livre <- lista.proximo.(lista.livre);
      lista.valor.(nova_cauda) <- elemento;
      lista.proximo.(nova_cauda) <- lista.cauda;
      lista.anterior.(nova_cauda) <- lista.anterior.(lista.cauda);
      lista.proximo.(lista.anterior.(lista.cauda)) <- nova_cauda;
      lista.anterior.(lista.cauda) <- nova_cauda;
      lista;;


(* remove : 'a -> 'a lista -> 'a lista - remove um elemento da lista *)

let remove elemento lista =
  let rec remove_i i =
    if i <> lista.cauda then (
      if lista.valor.(i) = elemento then
	let proximo = lista.proximo.(i) and anterior = lista.anterior.(i) in
	  lista.proximo.(i) <- lista.livre;
	  lista.livre <- i;
	  lista.anterior.(proximo) <- anterior;
	  lista.proximo.(anterior) <- proximo;
      else
	remove_i lista.proximo.(i)
    )
  in
    remove_i lista.proximo.(lista.cabeca);
    lista;;


(* mostra : int lista -> unit *)

let mostra lista =
  let rec mostra_i seguintes fim i =
    if i = fim then
      print_newline ()
    else (
      print_int lista.valor.(i);
      print_char ` `;
      mostra_i seguintes fim seguintes.(i)
    )
  in
    mostra_i lista.proximo lista.cauda lista.proximo.(lista.cabeca);
    mostra_i lista.anterior lista.cabeca lista.anterior.(lista.cauda);;

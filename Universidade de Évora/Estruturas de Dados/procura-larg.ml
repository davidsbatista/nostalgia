
(* procura_larg : 'a -> 'a arvore -> 'a arvore - devolve o n� com o valor
					    indicado (pesquisa em largura) *)

(* vers�o utilizando uma fila *)

let procura_larg elemento arvore =
  let rec procura_i arvores =
    if vazia_fila arvores then
      NIL
    else
      let (proxima, nova_fila) = remove_fila arvores in
        match proxima
          with NIL -> procura_i nova_fila
          |    NO no ->
            if no.valor = elemento then
              NO no
            else
              procura_i (insere_filhos nova_fila no.filhos)
  in
    procura_i (insere_fila (cria_fila arvore) arvore);;

(* fun��o auxiliar da anterior - insere os filhos de um n� na fila *)

let insere_filhos fila =
  function NIL -> fila
  |        NO no ->
    let rec insere_irmaos fila =
      function NIL -> fila
      |        NO no ->
	insere_irmaos (insere_fila fila (NO no)) no.irmaos
    in
      insere_irmaos (insere_fila fila (NO no)) no.irmaos;;


(* vers�o utilizando uma lista com inser��o � cabe�a e � cauda *)

let procura_larg elemento arvore =
  let rec procura_i arvores =
    if vazia_lista arvores then
      NIL
    else
      match cabeca_lista arvores
        with NIL -> procura_i (remove_cabeca_lista arvores)
        |    NO no ->
          if no.valor = elemento then
            NO no
          else
            procura_i
              (insere_cabeca_lista
                no.irmaos
                (insere_cauda_lista no.filhos (remove_cabeca_lista arvores)))
  in
    procura_i (insere_cabeca_lista arvore (cria_lista arvore));;

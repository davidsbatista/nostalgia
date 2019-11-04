
(* tipo ``arvore'' *)

type 'a arvore = NIL | NO of 'a elemento and
     'a elemento = { valor : 'a; mutable filhos : 'a arvore;
		     mutable irmaos : 'a arvore };;


(* insereraiz : 'a -> 'a arvore -> 'a arvore - devolve a árvore cuja raiz tem
					       como valor elemento e como filho
					       a árvore original *)

let insereraiz elemento arvore =
  NO { valor = elemento; filhos = arvore; irmaos = NIL };;


(* inseref : 'a -> 'a arvore -> 'a arvore - devolve a árvore que resulta de
					    substituir o filho da raiz por um
					    no com valor elemento e com o
					    filho anterior como irmão *)

let inseref elemento =
  function NIL -> NO { valor = elemento; filhos = NIL; irmaos = NIL}
  |        NO no ->
    no.filhos <- NO { valor = elemento; filhos = NIL; irmaos = no.filhos };
    NO no;;


(* insere_sub : 'a arvore -> 'a arvore -> 'a arvore - devolve a árvore que
					    resulta de substituir o filho da
					    raiz do 2o argumento pelo 1o
					    argumento, que fica com o filho
					    anterior como irmão *)

let insere_sub =
  fun NIL       arvore   -> arvore
  |   subarvore NIL      -> subarvore
  |   (NO no1)  (NO no2) ->
    no1.irmaos <- no2.filhos;
    no2.filhos <- NO no1;
    NO no2;;


(*
  let arv =
    inseref 3 (insereraiz 1 (inseref 7 (inseref 8 (insereraiz 4 NIL))));;

  - A expressao seguinte constroi a arvore da figura 4.2 do livro, tal como
    mostrada na figura 4.4.

  let arv =
    inseref
      `B`
      (inseref
        `C`
        (insere_sub
	  (insereraiz `D` (insereraiz `H` NIL))
	  (insere_sub
	    (inseref
	      `I`
	      (insereraiz
	        `E`
	        (inseref `P` (insereraiz `J` (insereraiz `Q` NIL)))))
	    (insere_sub
	      (inseref `K` (inseref `L` (insereraiz `F` (insereraiz `M` NIL))))
	      (insereraiz `A` (insereraiz `G` (insereraiz `N` NIL)))))));;
*)


(* lista_pre : 'a arvore -> 'a list - devolve a lista dos elementos da arvore,
				      obtidos através de um precurso prefixo *)

let rec lista_pre =
  function NIL -> []
  |        NO no -> no.valor::(lista_pre no.filhos @ lista_pre no.irmaos);; 


(* lista_pos : 'a arvore -> 'a list - devolve a lista dos elementos da arvore,
				      obtidos através de um precurso pósfixo *)

let rec lista_pos =
  function NIL -> []
  |        NO no ->lista_pos no.filhos @ no.valor::lista_pos no.irmaos;; 


(* procura : 'a -> 'a arvore -> 'a arvore - devolve o nó o valor indicado
					    (pesquisa em profundidade) *)

let rec procura elemento =
  function NIL -> NIL
  |        NO no ->
    if no.valor = elemento then
      NO no
    else 
      let arvore = procura elemento no.filhos in
	if arvore = NIL then
	  procura elemento no.irmaos
	else arvore;;


(* caminho : 'a -> 'a arvore -> 'a list - devolve o caminho até ao nó com o
					  valor indicado (pesquisa em
					  profundidade) *)

let rec caminho elemento =
  function NIL -> []
  |        NO no ->
    if no.valor = elemento then
      [elemento]
    else
      let cam = caminho elemento no.filhos in
	if cam = [] then
	  caminho elemento no.irmaos
	else
	  no.valor::cam;;


(* profundidade : 'a -> 'a arvore -> int - devolve a profundidade do
					   elemento indicado na árvore (a
					   profundidade da raiz é 0) *)

let profundidade elemento arvore = list_length (caminho elemento arvore) - 1;;


(* altura : 'a arvore -> int - devolve a altura da árvore *)

let rec alturapai =
  function NIL -> 0
  |        NO no ->  max (alturapai no.irmaos) (1 + alturapai no.filhos);;

let altura = function NIL -> 0
             |        NO no -> 1 + alturapai no.filhos;;


(* soma : int arvore -> int - devolve a soma dos elementos da árvore *)

let rec soma =
  function NIL -> 0
  |        NO no -> no.valor + (soma no.filhos) + (soma no.irmaos);;

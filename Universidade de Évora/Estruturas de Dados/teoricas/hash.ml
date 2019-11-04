
let hash s t= let v= ref 0 in
              for i=0 to (string_length s - 1) do
                  v:= (!v*32 + int_of_char s.[i])mod t done;
              !v;;


type 'a lista= Nil | no of 'a elemento and
     'a elemento={chave:'a; mutable prox:'a lista};;


let cria=Nil;;

let insere l e= no {chave=e; prox=l};;

let rec procura l e= if l=Nil then false
                 else let (no p) = l in
                    if p.chave=e then true
                    else procura p.prox e;;
 
let rec remove l e= if l= Nil then raise(Failure("não existe"))
                    else let (no p) = l in
                      if p.chave=e then p.prox
                     else (p.prox <- remove p.prox e; no p);;

let cria_hash t= make_vect t cria;;

                   
let insere_hash t e=  let i= hash e (vect_length t) in 
                       t.(i) <- insere t.(i) e;;

let remove_hash t e=  let i= hash e (vect_length t) in 
                       t.(i) <- remove t.(i) e;;



type 'a entrada= {chave: 'a; vazio:bool; apagado:bool}







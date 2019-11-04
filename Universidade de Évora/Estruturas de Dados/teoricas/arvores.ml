type 'a arvore= nil | no of 'a elemento and
                'a elemento= {valor:'a; mutable filhos:'a arvore;
                                        mutable irmaos:'a arvore};;


let rec lista_pre= function nil -> []
                   |no a -> (a.valor::lista_pre a.filhos)@lista_pre a.irmaos;; 

let rec lista_pos= function nil -> []
                   |no a ->lista_pos a.filhos@a.valor::lista_pos a.irmaos;; 

let insereraiz e= function nil -> no {valor=e; filhos=nil;irmaos=nil}
                     |  no r -> no {valor=e; filhos=no r;
                                    irmaos=nil} ;;

let inseref e = function nil -> no {valor=e; filhos=nil;irmaos=nil}
                     |  no r -> let a = no {valor=e; filhos=nil;
                                             irmaos=r.filhos} in r.filhos<- a;
                                        no r;;

let l= inseref 3 (insereraiz 1 (inseref 7 (inseref 8 (insereraiz 4 nil))));;



let rec procura e = function nil -> nil
                            | no r -> if r.valor= e then no r
                                      else 
                                       let a = procura e r.filhos in
                                          if a= nil then procura e r.irmaos
                                          else a;;

let rec caminho e = function nil -> []
                        | no r -> if r.valor =e then [e]
                                  else let a = caminho e r.filhos in
                                     if a= [] then caminho e r.irmaos
                                     else r.valor::a;;

let profundidade e l= list_length (caminho e l) -1;;


let rec alturapai = function nil -> 0
                |no r ->  max (alturapai r.irmaos) (1+ alturapai r.filhos);;

let altura = function nil ->0
                     | no r -> 1+ alturapai r.filhos;;


let soma = function nil -> 0
                    | no r-> r.valor + soma r.filhos + soma r.irmaos ;;







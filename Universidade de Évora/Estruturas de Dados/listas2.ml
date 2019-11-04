/* Aula 2 listas */

/* implementacao com lista ligada */

type 'a lista= Nil | No of 'a elemento and 
                 'a elemento = { valor: 'a; mutable prox: 'a lista;
                                 mutable ant: 'a lista};;



let cria el= No { valor=el; prox=Nil; ant=Nil} ;;

let vazia = function Nil -> true
                     | _ -> false;;


let insere l e = function Nil -> l
                          | No p -> let  t = No {valor=e; prox= p.prox;
                                                  ant= No p} 
                                     in p.prox <- t; if p.prox= Nil then l
                                                     else (let (No seg)=t.prox 
                                                          in seg.ant<- t; l);;


let procura l e = let (No c) = l 
                   in let rec prc e= function Nil -> Nil
                                            |No n ->  if n.valor=e then No n
                                                      else prc e n.prox
                              in prc e c.prox;;
                                         

let ant l = function Nil -> Nil
                    | No p -> p.ant;;

let prox l= function  Nil -> Nil
                    |No n -> n.prox;;

let rec remove l n=  let (No p)= l and (No seg)= n
                       in if p.prox = n then begin p.prox <- seg.prox; l end
                           else begin remove p.prox n;
                           l end;;

let rec tamanho= function Nil -> -1
                    | No n -> 1 + tamanho n.prox;;


/*---------- implementacao de listas em vectores -----------------*/


type 'a listas= {valor: 'a vect;  prox: int vect; 
                 cabeca: int; mutable livre: int};;

let cria el= let l= { valor= make_vect 20 el; prox = make_vect 20 (-1); 
                      cabeca= 0; livre=1;}
                in for i= 1 to (vect_length l.prox -2) do 
                        l.prox.(i)<- i+1 done;
                 l;;

let insere l e p= if l.livre= -1 then l
                  else let livre = l.prox.(l.livre) in
                     begin  l.valor.(l.livre) <- e; 
                            l.prox.(l.livre) <- l.prox.(p);
                            l.prox.(p)<- l.livre;
                            l.livre<-livre;l 
                     end;;

let rec ant l p i = if i= -1 then i
                    else if l.prox.(i) = p then i
                         else ant l p l.prox.(i);;

let remove l p = let i = ant l p l.cabeca 
                    in if i = -1 then l 
                       else  begin 
                          l.prox.(i) <- l.prox.(p);  
                          l.prox.(p) <- l.livre;
                          l.livre <- p;l
                        end;;
                               

let procura l e= let rec prc l e i= if l.valor.(i) = e or i= -1 then i
                                    else prc l e l.prox.(i)
                 in prc l e l.prox.(l.cabeca);;
            
 
let printl l= let rec pl l i= if i= -1 then print_string "\n"
                              else begin print_int l.valor.(i);
                                         print_string " ";
                                         pl l l.prox.(i) end
              in pl l l.prox.(l.cabeca);;






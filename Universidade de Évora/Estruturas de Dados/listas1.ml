
/* lista com listas  */


let cria= [];;

let rec insere l e  p = if p=0 then e::l
                     else  if l=[] then [e]
                     else let a::r = l in (a::insere r e (p-1));; 


let insere l e p = let rec ins = function l,e,0  -> e::l
                                          |[],e,p ->[e]
                                          |(a::r),e,p -> a::ins (r, e, p-1)
                   in  ins (l,e,p);;


                  
let rec procura l e =  if l=[] then -1
                      else let a::r = l in if a = e then 0 
                               else let i = procura r e   
                               in if i= -1 then -1
                                  else 1+i;;

let procura l e = let rec prc = function [],_ -> -1
                                        |a::r, e -> if a=e then 0 
                                                   else
                                         let i= prc (r,e) in
                                                    if i=-1 then -1
                                                    else i+1
                   in prc (l,e);; 



let remove l p = let rec rmv = function [],_ -> []
                                      | _::r,0 -> r
                                      |a::r,p -> a::rmv (r,p-1)
                 in rmv (l,p);; 


let procurai l i = let rec pi = function [],_ -> -1
                                         |a::_,0 -> a
                                         |_::r,p -> pi (r,p-1)
                           in pi (l,i);;


let rec tamanho = function [] -> 0
                          |_::r -> 1+tamanho r;;
      



/*Lista com vector*/


let max_elem= 20;;

type 'a lista = {ne:int; el:'a vect};;


let cria max_elem e = {ne=0; el = make_vect max_elem e};;

let insere l e p = for i= l.ne-1 downto p do
                          l.el.(i+1) <- l.el.(i) done;
                   l.el.(p) <- e; 
                   {ne=l.ne+1; el= l.el};;

let tamanho l = l.ne;;

let remove l p = for i = p to l.ne-2 do l.el.(i)=l.el.(i+1) done;
                           {ne=l.ne-1; el= l.el};;

let procura l e= let rec prc p= if p=l.ne then -1 
                                    else if l.el.(p) = e then p
                                         else prc (p+1)
                 in prc 0;;  


let procurai l i= if i< l.ne then l.el.(i)
                  else -1;;


/* lista ligada */

type 'a lista= Nil | No of 'a elemento and 
                 'a elemento = { mutable valor: 'a; mutable prox: 'a lista};;

% com cabeça

let cria el= No {valor=el; prox=Nil} ;;

let vazia = function Nil -> true
                     | _ -> false;;

let elemento=function No n -> n;;

let insere l e n =  let p= elemento n in 
                    let t = {valor=e; prox= p.prox} in p.prox <- No t;l;;

let procura l e = let rec prc e= function Nil -> Nil
                                  | (No ({valor=v; prox=p} as n) )-> 
                                                   if v=e then No n
                                                   else prc e n.prox
                              in prc e l;;
                                         

let ant l n= if l=n then Nil
             else let rec ant_aux n= function No c -> if c.prox = n then No c
                                                      else ant_aux n c.prox
                       in ant_aux n l;;

let prox l= function No n -> No n.prox;;

let remove l n= let p= ant l n in if p= Nil then let t= elemento l in t.prox
                                  else
                                    let ant= elemento p and pr= elemento n in
                                              ant.prox<- pr.prox; l;; 

let rec tamanho= function Nil -> 0
                    | No n -> 1 + tamanho n.prox;;







type 'a abp= Nil | no of 'a elemento and 
    'a elemento= {mutable valor:'a; mutable fesq:'a abp; mutable fdir:'a abp};;


let rec insere e = function Nil -> no {valor=e; fesq=Nil; fdir= Nil}
                           |no n-> if e<n.valor then
			             n.fesq <- insere e n.fesq
                                   else if e>n.valor then
				     n.fdir <- insere e n.fdir;
                                   no n;;

let rec maior= function Nil -> raise(Failure("nao ha"))
                       |no n -> if n.fdir=Nil then n.valor
                                else maior n.fdir;;

let rec remove e = function Nil -> Nil
                      |no n ->if e= n.valor then 
                                  if n.fesq=Nil then  n.fdir
                                  else if n.fdir=Nil then n.fesq
                                       else 
                                       (n.valor <-  maior n.fesq;
                                        n.fesq <- remove n.valor n.fesq;
                                        no n)
                              else (if e< n.valor then n.fesq<- remove e n.fesq
                                    else n.fdir<- remove e n.fdir;
                                    no n);;


let rec lista = function Nil -> []
                       | no n -> lista n.fesq @ n.valor :: lista n.fdir;;  





/* abp em vectores */

type 'a abp= { mutable raiz:int; valor:'a vect; fdir:int vect; fesq:int vect; 
               mutable livre:int};; 

let novo f = let i = f.livre in f.livre <- f.fdir.(f.livre); i;;

let guarda f i= f.fdir.(i)<- f.livre; f.livre <- i;;

let cria el= 
    let tamanho = 20 in 
	let l= { valor= make_vect tamanho el; fdir = make_vect tamanho ( -1); 
                 fesq = make_vect tamanho 0; 
                 raiz =  -1; livre=0;}
	in for i= 0 to vect_length l.valor -2 do l.fdir.(i)<- i+1 done;
           l;;


let insere e a= let rec ins i= if i =  -1 then let j= novo a in
                                           (a.valor.(j)<- e;
                                            a.fdir.(j) <-  -1;
                                            a.fesq.(j) <-  -1; j)
                                   else (if a.valor.(i) < e then  
                                               a.fdir.(i) <- ins a.fdir.(i)
                                         else if a.valor.(i) > e then
					       a.fesq.(i)<- ins a.fesq.(i);
                                         i)
                in a.raiz <- ins a.raiz; a;;




let rec maior1 a i= 
                 if i= -1 then raise(Failure("erro"))
                 else if a.fdir.(i) =  -1 then a.valor.(i)
                      else maior1 a a.fdir.(i);;

let maior a=  maior1 a a.raiz;;
             
let remove e a= let rec rem e a i= 
                         if i= -1 then
			   i
                         else if a.valor.(i) < e then 
                           (a.fdir.(i) <- rem e a a.fdir.(i); i)
                         else if a.valor.(i) > e then
			   (a.fesq.(i) <- rem e a a.fesq.(i); i)
			 else (* a.valor.(i) = e *)
                           if a.fdir.(i) =  -1 then 
                             let j= a.fesq.(i) in (guarda a i; j)
                           else if a.fesq.(i) =  -1 then
                             let j= a.fdir.(i) in (guarda a i; j)
                           else let j= maior1 a a.fesq.(i) in 
                               (a.valor.(i)<- j;
                                a.fesq.(i)<- rem j a a.fesq.(i); i)  
                 in a.raiz <- rem e a a.raiz;;


let lista a= let rec list a i= 
                    if i= -1 then []
                    else (list a a.fesq.(i))@ (a.valor.(i)::list a a.fdir.(i) )
              in list a a.raiz;;


let pt a= let rec p a i n = if i = -1 then  print_string "\n"
                            else begin
                              p a a.fdir.(i) (n+1);
                              for j=0 to n do print_string " " done;
                              print_int a.valor.(i);
                              p a a.fesq.(i) (n+1);
                            end
           in p a a.raiz 0;;



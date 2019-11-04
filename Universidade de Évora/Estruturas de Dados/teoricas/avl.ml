
type 'a avl= Nil| no of 'a elemento and
     'a elemento = {valor: 'a; mutable fesq:'a avl; 
                    mutable fdir:'a avl; mutable altura:int};;

let altura= function Nil -> -1
                    |no a -> a.altura;;

let roda_dir a= let (no k2)= a in let (no k1)= k2.fesq in
                   k2.fesq<- k1.fdir;
                   k1.fdir<- no k2;
                   k2.altura<- (max  (altura k2.fesq) (altura k2.fdir))+1;
                   k1.altura<- (max k2.altura (altura k1.fesq)) + 1;
                   no k1;;

let roda_esq a= let (no k2)= a in let (no k1)= k2.fdir in
                   k2.fdir<- k1.fesq;
                   k1.fesq<- no k2;
                   k2.altura<- max (altura k2.fesq) (altura k2.fdir) +1;
                   k1.altura<- max k2.altura (altura k1.fdir) +1;
                   no k1;;


 let roda_esq_dir a = let (no k3)=a in 
                        k3.fesq<- roda_esq k3.fesq;
                        roda_dir (no k3);;

 let roda_dir_esq a = let (no k3)=a in 
                        k3.fdir<- roda_dir k3.fdir;
                        roda_esq (no k3);;


let rec insere e= 
     function Nil -> no {valor=e;fdir=Nil;fesq=Nil;altura=0}
            |no a -> if e < a.valor then (
                       a.fesq <- insere e a.fesq;
                       if (altura a.fesq) - (altura a.fdir) =2 then
                        let (no b) = a.fesq in
                          if e < b.valor then
                             roda_dir (no a)
                          else 
                             roda_esq_dir (no a )
                       else 
                         (a.altura <- max (altura a.fesq) (altura a.fdir) +1;
                         no a))
                     else
                       (a.fdir <- insere e a.fdir;
                       if (altura a.fdir) - (altura a.fesq) =2 then
                        let (no b) = a.fdir in
                          if e > b.valor then
                             roda_esq (no a)
                          else 
                             roda_dir_esq (no a)
                       else 
                         (a.altura <- max (altura a.fesq) (altura a.fdir) +1;
                         no a));;


let linha () = print_string "\n";;

let rec espacos= function 0 ->()
                         |a -> print_string(" "); espacos (a-1);;


let esc a = print_string a; print_string "\n";;

let rec listar n= function Nil -> ()
                    |no r -> listar (n+4) r.fdir;
                              espacos n; print_int r.valor; 
                              print_string "(";print_int r.altura;
                              print_string ")";
                              linha ();
                              listar (n+4) r.fesq;; 




let l= insere 1 Nil;;
listar 2 l;;
let l= insere 2 l;;
listar 2 l;;
let l= insere 3 l;;
listar 2 l;;
let l= insere 4 l;;
listar 2 l;;
let l= insere 5 l;;
listar 2 l;;
let l= insere 6 l;;
listar 2 l;;
let l= insere 7 l;;
listar 2 l;;
let l= insere 16 l;;
listar 2 l;;
let l= insere 15 l;;
listar 2 l;;
let l= insere 14 l;;
listar 2 l;;



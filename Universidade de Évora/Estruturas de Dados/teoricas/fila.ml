type 'a fila={mutable cabeca:int;mutable cauda:int; dados: 'a vect};;

let cria max el=
   {cabeca=0; cauda=0; dados =make_vect max el};;


let inc n m= if n = m-1 then 0 else n+1;;

let insere f el = f.dados.(f.cauda)<- el;
                     f.cauda <- inc f.cauda (vect_length f.dados);;

let remove f = let elemento = f.dados.(f.cabeca) in
                  f.cabeca <- inc  f.cabeca (vect_length f.dados); 
                  elemento;;




type 'a fila= {mutable cabeca:'a lista; mutable cauda:'a lista} and
      'a lista = no of 'a elemento | nil and 
      'a elemento = {mutable valor: 'a ; mutable prox: 'a lista};;

let cria el = let lugar = {valor=el; prox= nil} in 
                    {cabeca= no lugar; cauda=no lugar};;

let insere f el= let (no v)= f.cauda in 
                    let novo= {valor = v.valor; prox=nil} in 
                           v.valor <- el;
                           v.prox <- no novo;
                           f.cauda <- no novo;
                           f;; 

let remove f= let (no v) = f.cabeca in f.cabeca <- v.prox; v.valor;;


/***** Em vectores *********************/


type 'a fila = {mutable cabeca:int; mutable cauda:int; mutable livre:int; 
                valor:'a vect; prox:int vect};;

let cria el= let l= { valor= make_vect 20 el; prox = make_vect 20 (-1); 
                      cabeca= 0; cauda=0; livre=1;}
                in for i= 1 to 18 do l.prox.(i)<- i+1 done;
                 l;;

let novo f = let i = f.livre in f.livre <- f.prox.(f.livre); i;;

let guarda f i= f.prox.(i)<- f.livre; f.livre <- i;;

let insere f el= f.valor.(f.cauda) <- el;
             let i = novo f in f.prox.(f.cauda)<- i;
                               f.cauda <- i;; 

let remove f = let p = f.cabeca in f.cabeca<- f.prox.(p);
                               guarda f p;
                               f.valor.(p);;  

let printl l= let rec pl l i= if i= l.cauda then print_string "\n"
                              else begin print_int l.valor.(i);
                                         print_string " ";
                                         pl l l.prox.(i) end
              in pl l l.cabeca;;

---------------------------------------


let vazia f= f.cabeca=f.cauda;;


let cria_vect= let e= make_vect 10 (cria_fila 30 0) in
         for i=0 to 9 do e.(i)<- cria_fila 30 0 done; e;;
 
let ord lista= let a=cria_vect in preenche l a; 
                   let rec ordi a i j = if i = j then a
                                        else   
                                          let b= cria_vect in
                                          for k=0 to 9 do
                                             while ! vazia a.(k) do 
                                                let v = remove a.(k) in
                                            insere b.(v / exp 10 i mod 10) v 
                                           done;
                                         done;
                                        ordi b i+1 j;
                   in  ordi a 1 3;;
                   transforma a.(0);;;

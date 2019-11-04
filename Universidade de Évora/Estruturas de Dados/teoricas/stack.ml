type 'a stack = {mutable sp:int; valor: 'a vect};;

let cria el = {sp=0; valor= make_vect 20 el};;

let vazio s= s.sp=0;;

let cheio s = s.sp= vect_length s.valor;;

let push el s= if cheio s then s 
               else (s.valor.(s.sp)<- el; s.sp<- s.sp +1; s);; 

let pop s= if vazio s then s else s.sp<- s.sp -1;;

let pope s = if vazio s then raise (Failure "stack vazio")
             else  (  s.sp<- s.sp -1; s.valor.(s.sp));;

let top s = if vazio s then raise (Failure "stack vazio") 
            else s.valor.(s.sp -1);;




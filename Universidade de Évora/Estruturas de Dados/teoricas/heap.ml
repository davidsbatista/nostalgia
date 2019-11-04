type 'a heap= {valores:'a vect; mutable nelementos:int};;

let pai i= i / 2;;

let rec puxa e h i= if h.valores.(pai i) < e then 
                      h.valores.(i) <- e
                     else begin
                      h.valores.(i) <- h.valores.(pai i);
                      puxa e h (pai i)
                      end;;

let insere e h= if h.nelementos = (vect_length h.valores) -1 then 
                      raise(Failure("Heap cheio"))
                else begin
                     h.nelementos <- h.nelementos + 1;
                     puxa e h h.nelementos;
                     end;;

/* e é a menor chave */

let cria_heap e t= {valores= make_vect t e;
                    nelementos=0};;

/* devolve o indice da menor chave na posicao i e j*/
let min i j h= if h.valores.(i) < h.valores.(j) then i
               else j;;

/* devolve o indice da menor chave entre o pai e os dois filhos se existirem*/

let menor i h = if h.nelementos >= 2*i+1 then 
                   min i (min (2*i) (2*i+1) h) h
                else
                   if h.nelementos >= 2*i then
                     min i (2*i) h
                   else i;;


let rec empurra e h i = let j = menor i h in 
                          if j > i then begin
			    h.valores.(i)<- h.valores.(j); 
                            h.valores.(j)<- e;
                            empurra e h j
                            end;;


let removeMin h= let min= h.valores.(1) and e = h.valores.(h.nelementos) in
                        h.valores.(1) <- e;
                        h.nelementos <- h.nelementos -1;
                        empurra e h 1;
                        min;;

let buildHeap v t= let h= {valores= v; nelementos=t} in
                     for i= t /2 downto 1 do
                        empurra h.valores.(i) h i
                     done; h;;


let heapsort v t = let h = buildHeap v t in
                     for i=t downto 1 do
                        h.valores.(i) <- removeMin h
                       done;
                     h.valores;;

heapsort [| 0; 5; 7; 2; 4; 1; 3; 8 |] ;;


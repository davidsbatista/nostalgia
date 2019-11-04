(* =============================== Implementação da Estrutura ============================ *)

type 'a entrada = {mutable palavra: 'a; mutable linhas: int list; mutable ocorrencias: int; mutable ordem: int list};;

let indice = make_vect 2048 {palavra=""; linhas=[]; ocorrencias=0; ordem = []};;

let maiusc x = let i = int_of_char x in
                if (i<=122) & (i>= 97)
                  then
		     (char_of_int (i - 32))
                  else
                     if (i>=225) & (i<=250)
                       then
			  char_of_int (i - 32)
		       else x;;

let caps s = let new_s =ref "" in
		for i=0 to (string_length s - 1) do
                   new_s:=!new_s^(string_of_char (maiusc s.[i]));
		done;
             !new_s;;



let hash s = let v= ref 0 in
              for i=0 to (string_length s - 1) do
                  v:= (!v*32 + int_of_char s.[i])mod 2048;
	      done;
              !v;;


let linear_probing s i = let res = ref (((hash s) + i) mod 2048) in 
			  if !res > 2047
		   	    then 
			      (res:=!res-2048; !res)
			    else
			      !res;;



let rec tail = function h::[] -> h;
                | [] -> raise(Failure "A lista encontra-se vazia");
                | h::t -> tail t;;



let eh_letra = function l -> let tmp=int_of_char l in
                                begin
                                  if tmp<65
				    then
					false
                                    else
                                        if tmp<97 & tmp>90
				          then
					      false
					  else
                                             if tmp>122 & tmp<193
					      	then
						    false
						else
						    true
                                end;;



let rec insere_palavra s i l o =
			let pos=(linear_probing s i) in
			  if indice.(pos).palavra=""
			    then
			        (indice.(pos)<-{palavra=s; linhas=[l]; ocorrencias=1;ordem=[o]};)

			    else
	             	      if indice.(pos).palavra=s
			        then
			           (let a=indice.(pos) in
			           a.linhas<-(a.linhas)@[l];
				   a.ocorrencias<-(a.ocorrencias)+1;
				   a.ordem <- (a.ordem)@[o];)
				else
				   insere_palavra s (i+1) l o;;


let indexa nome_do_ficheiro =
    let   canal = open_in nome_do_ficheiro and
       contador = ref 0 and
	    tmp = ref "" and
        palavra = ref "" and
          linha = ref 1 and
	 ordem = ref 1 in

	try   												(* Try para apanhar o End of file *)
          while true do
          tmp:=input_line canal; 									(* Recebe a primeira linha do Ficheiro *)
                try											(* Try para apanhar o fim da linha *)
                  while !tmp.[!contador]<>`\n` do
                   begin
                    if (eh_letra !tmp.[!contador]) 							(* Verifica se o caracter é válido *)
		     then										(* Se for adiciona-o à variavel palavra *)
			(palavra:=(!palavra)^(string_of_char (maiusc !tmp.[!contador])); 
		        incr contador)
                     else
                       begin
                         if (!tmp.[!contador])=`-`							(* Faz o teste para ver se eh o caracter especial - *)
                           then 
			      (if (eh_letra (!tmp.[!contador-1])) & (eh_letra (!tmp.[!contador+1])) 	(* Verifica se eh letra *)
                                 then 									(* Se for adiciona-o à variavel palavra *)
                                    (palavra:=(!palavra)^(string_of_char (maiusc !tmp.[!contador])); 
				    incr contador;)
                                 else 
		  		    (incr contador;))							(* Repeticao de codigo *)
			   else
		 	      if ((!palavra)<>"") 
                                then 
			           (insere_palavra !palavra 0 !linha !ordem; palavra:=""; 
				   incr contador;incr ordem)
                                else 
				   incr contador;
                        end
                    end
                  done;
                 with Invalid_argument "nth_char" ->   if ((!palavra)<>"") 
                              				 then 
							   (insere_palavra !palavra 0 !linha !ordem;
                                                           palavra:=""; contador:=0;incr ordem)
							 else
							   palavra:=""; contador:=0;
		linha:=!linha+1;
              done;
		indice;
          with End_of_file -> indice;;


(* =============================== Pesquisas ============================ *)


let ocorre indice palavra = let rec aux i = let p = caps palavra in
			let pos=(linear_probing p i) in
			if indice.(pos).palavra="" 
			  then 
			    false
			  else 
			    begin
				if indice.(pos).palavra=p
				  then 
				    true
				  else	
				    aux (i+1)
			end;
			in aux 0;;

let primeira_ocorrencia indice palavra = 
		let rec aux i = let p = caps palavra in
			let pos=(linear_probing p i) in
			if indice.(pos).palavra="" 
			  then -1
			  else 
			    begin
				if indice.(pos).palavra=p
				  then 
				    let a=indice.(pos) in
				    	hd (a.linhas);
				  else	
				    aux (i+1)
			end;
			in aux 0;;



let ultima_ocorrencia indice palavra = 
		let rec aux i = let p = caps palavra in
			let pos=(linear_probing p i) in
			if indice.(pos).palavra=""
			  then -1
			  else
			    begin
				if indice.(pos).palavra=p
				  then 
				    let a=indice.(pos) in
				    	hd (rev(a.linhas));
				  else	
				    aux (i+1)
			end;
		in aux 0;;


let ocorrencias indice palavra = 
		let rec aux i = let p = caps palavra in
			let pos=(linear_probing p i) in
			if indice.(pos).palavra="" 
			  then []
			  else
			    begin
				if indice.(pos).palavra=p
				  then 
				    let a=indice.(pos) in
				    	(a.linhas);
				  else	
				    aux (i+1)
			end;
			in aux 0;;



let quantas_ocorrencias indice palavra = 
		let rec aux i = let p = caps palavra in
			let pos=(linear_probing p i) in
			if indice.(pos).palavra="" 
			  then 0
			  else
			    begin
				if indice.(pos).palavra=p
				  then 
				    let a=indice.(pos) in
				    	(a.ocorrencias);
				  else	
				    aux (i+1)
			end;
		in aux 0;;



let quantas_palavras indice = 
			let counter=ref 0 in
			for i=0 to 2047 do 
			 if indice.(i).palavra<>"" 
			  then 
			     let a=indice.(i) in
			     counter:=!counter+(a.ocorrencias);
			  done;
			!counter;;



let quantas_palavras_distintas indice = 
			let counter=ref 0 in
			for i=0 to 2047 do 
			 if indice.(i).palavra<>"" 
			  then 
			     counter:=!counter+1;
			  done;
			!counter;;



let mais_frequente indice = let ocorre=ref 0 and mais_freq=ref "" in 
			    for i=0 to 2047 do
				let a=indice.(i) in
				if (a.ocorrencias)>=(!ocorre) 
				  then 
					(mais_freq := a.palavra;
					ocorre:= a.ocorrencias;)
				done;
				!mais_freq;;


(* =============================== 2º Parte do Trabalho ===================================== *)


let vector_de_lista lista = let a = lista in vect_of_list a ;;



let ordem_palavra indice palavra =
	let rec aux i = let p = caps palavra in
	let pos=(linear_probing p i) in
		if indice.(pos).palavra=""
		  then 
		    []
		  else 
		     begin
			if indice.(pos).palavra=p
			  then
			    indice.(pos).ordem
				  else
				    aux (i+1)
			end;in aux 0;;



let ordem_expressao indice expressao =
	let ordens = (make_vect (list_length expressao) (make_vect 1 0 )) and
	i = 0 in
	let rec aux indice i =
		function  []     -> [];
			| x::l  -> ordens.(i) <- (vector_de_lista (ordem_palavra indice x));
			     aux indice (i+1) l;
	in aux indice i expressao ;ordens;;



let devolve_ocorrencia_expressao ordens = let result = ref 1 in
  let rec aux vect pos1 pos2 ordens =
    if vect < ((vect_length ordens)-1) then
	begin
	if (ordens.(vect).(pos1)) < ((ordens.(vect+1).(pos2)) -1) then
	  aux vect (pos1+1) 0 ordens
	else
	  if (ordens.(vect).(pos1)) = ((ordens.(vect+1).(pos2))-1) then
	    (result := !result + 1 ; aux (vect+1) pos2 0 ordens)
	  else
	    aux (vect-1) (pos1+1) 0 ordens
	end;
  in aux 0 0 0 ordens; !result;;



let ocorre_expressao indice expressao =
	let ordens = (ordem_expressao indice expressao) in
		let rec aux ordens = try devolve_ocorrencia_expressao ordens
			with Invalid_argument "vect_item" -> -1;
	in (aux ordens <> -1);;



let linha_expressao indice expressao =
		let linhas = (make_vect (list_length expressao) (make_vect 1 0 )) and
	i = 0 in
	let rec aux indice i =
		function  []     -> [];
			| x::l  -> linhas.(i) <- (vector_de_lista (ocorrencias indice x));
			     aux indice (i+1) l;
	in aux indice i expressao ;linhas;;



let devolve_ocorrencias_expressao ordens linhas =
 let result = ref [] and
      fault = ref 1 and
   primeiro = ref 0 in
  let rec aux vect pos1 pos2 ordens linhas =
    if vect < ((vect_length ordens)-1) then
	begin
	if (ordens.(vect).(pos1)) < ((ordens.(vect+1).(pos2)) -1) then
	  (fault := 1 ;
	   if vect = 0 then aux vect (pos1+1) 0 ordens linhas
		else  aux (vect-1) (pos1+1) 0 ordens linhas)
		else
	  if (ordens.(vect).(pos1)) = ((ordens.(vect+1).(pos2))-1) then
	    (
		if (!fault = 1) then
			(result := !result@[linhas.(vect).(pos1)] ;
			primeiro := pos1 ;fault := 0 );
		aux (vect+1) pos2 0 ordens linhas
	    )   
	  else
	    aux vect pos1 (pos2+1) ordens linhas
	end
    else
	if !primeiro < ((vect_length (ordens.(0) )) -  1) then
		(fault :=1 ;aux 0 (!primeiro + 1) 0 ordens linhas);
  in aux 0 0 0 ordens linhas; !result;;



let ocorrencias_expressao indice expressao =
	let ordens = (ordem_expressao indice expressao) and
	    linhas = (linha_expressao indice expressao) in
		let rec aux ordens = try devolve_ocorrencias_expressao ordens linhas
			with Invalid_argument "vect_item" -> [];
	in (aux ordens);;

	

let ocorrencias_expressao indice expressao =
	let ordens = (ordem_expressao indice expressao) and
	    linhas = (linha_expressao indice expressao) in
		let rec aux ordens = try devolve_ocorrencias_expressao ordens linhas
			with Invalid_argument "vect_item" -> [];
	in (aux ordens);;
	


let primeira_ocorrencia_expressao indice expressao = 
			let a=(ocorrencias_expressao indice expressao) in 
			if a=[]
			 then -1
			 else hd a;;
			 


let ultima_ocorrencia_expressao indice expressao = 
		let a=(ocorrencias_expressao indice expressao) in 
			if a=[]
			 then -1
			 else tail a;;

(**********************************************************************************************)

indexa "c:/teste.txt";;
ocorre indice "difusos" ;;
primeira_ocorrencia indice "formação" ;;
primeira_ocorrencia indice "segura"  ;;
ultima_ocorrencia indice "inFoRMAÇão"  ;;
ocorrencias indice "Interesses" ;;
ocorrencias indice "Interêsses"  ;;
ocorrencias indice "publicidade"  ;;
ocorrencias indice "sendo-lhes";;
ocorrencias indice "sendo"  ;;
ocorrencias indice "lhes"  ;;
quantas_ocorrencias indice "de" ;;
quantas_palavras indice ;;
quantas_palavras_distintas indice  ;;
mais_frequente indice ;;

(******************************************************)

ocorre_expressao indice ["direito"; "à"; "qualidade"];;
ocorre_expressao indice ["direito"; "qualidade"];;
primeira_ocorrencia_expressao indice ["PUBLiciDade"; "OCUlta"];;
ultima_ocorrencia_expressao indice ["PUBLiciDade"; "OCULta"];;
ocorrencias_expressao indice ["têm"; "DIREITO"] ;; 
ocorrencias_expressao indice ["consumidos"; "à"; "formação"] ;;
ocorrencias_expressao indice ["não"; "ocorre"; "aqui"] ;; 

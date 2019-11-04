
	.data

LINHA:	.asciiz "\n"
TAB:  	.asciiz "\t"

	.text
	.align 2


main:
	jal	LER_NOTAS		# PROCEDIMENTO PARA LER AS NOTAS
	
	add	$a0, $v0, $0		# copia o valor de $v0 para $a0
	add	$a1, $v1, $0		# copia o valor de $v1 para $a1
	
	jal	ORDENA			# PROCEDIMENTO PARA ORDENAR AS NOTAS
	
	add	$t0, $v0, $0		# guarda o valor de $v0 em $t0
	
	li	$v0, 4			#
	la 	$a0, LINHA		#
	syscall				# NEW_LINE
	
	add	$v0, $t0, $0		# repõem o valor de $v0
	
	add	$a0, $v0, $0		# copia o valor de $v0 para $a0
	
	jal	ESTATISTICA		# PROCEDIMENTO DE ESTATISTICA SOBRE AS NOTAS
	
	j fim

#################################################################################################
#	
#	ler_notas:	.lê valores de 0 a 20
#			.verifica se estão entre 0 e 20, ignorando os
#			que não estão.
#			.pára de ler quando encontrar o valor -1
#
#	retorno:	.um vector ($v0) com as notas, incluindo o
#			 valor -1 na última posição
#			.tamanho do array em $v1
#
#
#
#




LER_NOTAS:	
	addi	$sp, $sp, -12		# push $ra, $s0, $s1
	sw	$ra, 0($sp)		#
	sw	$s0, 4($sp)		#  
	sw	$s1, 8($sp)		#

	li	$s0, 0			# $s0 - counter
	li	$s1, -1			# count ending -1
	
	
READ_LOOP:	
	
	li	$v0, 5			# read_int
	syscall				

	slt	$t0, $v0, $s1		# check if it is between -1 and 20. ignore it otherwise.
	bne	$t0, $0, READ_LOOP	# 
	li	$t0, 20			#
	slt	$t0, $t0, $v0		#
	bne	$t0, $0, READ_LOOP	#

	
	addi	$s0, $s0, 1		# incrementa contador e guarda o valor na stack
	addi	$sp, $sp, -4		#
	sw	$v0, 0($sp)		#
	
	bne	$v0, $s1, READ_LOOP	# enquanto nao receber -1 le valores


READ_DONE:				

	# make space for 4*$s0 words
	
	add	$v1, $s0, 0		# guarda o tamanho do array em $v1
	sub	$v1, $v1, 1		# subtrai um pois o ultimo valor eh -, nao faz parte dos dados
	
	add	$a0, $s0, $s0		#
	add	$a0, $a0, $a0		#
	li	$v0, 9			#
	syscall				# sbrk - returns space in $v0
	
	
	# $v0 - vector base address
	
	# pop words into vector, in reverse order
	# use $t1 as a pointer, but start from end
	
	add	$t1, $s0, $s0
	add	$t1, $t1, $t1		#t1 = 4*s0
		
	add	$t1, $t1, $v0		#t1 = v0 + 4*s0
	addi	$t1, $t1, -4


POP_LOOP:
	lw	$t0, 0($sp)
	addi	$sp, $sp, 4

	sw	$t0, 0($t1)
	addi	$t1, $t1, -4

	# past beginning? end.
	#
	slt	$t2, $t1, $v0
	beq	$t2, $0, POP_LOOP


RETURN_SEQUENCE:	
	# pop $s1, $s0, $ra
	#
	lw	$ra, 0($sp)
	lw	$s0, 4($sp)
	lw	$s1, 8($sp)
	addi	$sp, $sp, 12

	jr	$ra
################################################################################################






################################################################################################
#
# ORDENA
# 	
#	recebe: 	um vector em ($a0) com as notas, incluindo -1 na ultima posicao
#			recebe em ($a1) o tamanho desse vector
#			
#
#	retorna:	devolve o vector em ($v0) ordenado por ordem crescente
#
#
# REGISTOS USADOS:
#
#	$a0	- tem o endereço base do vector a ser ordenado
#
#	$s0	-
#	$s1	-
#
#	$t0	-
#	$t1	-
#	$t2	-
#	$t3	-
#	$t4	-
#
#
#
#
# Eh a implementacao do algorimto BubbleSort:
#
# for (i=0; i<n-1; i++) {
#   for (j=0; j<n-1-i; j++)
#     if (a[j+1] < a[j]) {  /* compare the two neighbors */
#       tmp = a[j];         /* swap a[j] and a[j+1]      */
#       a[j] = a[j+1];
#       a[j+1] = tmp;
#   }
# }



ORDENA:
	addi	$sp, $sp, -8		# push $s0, $s1, $ra
	sw	$s0, 0($sp)		#
	sw	$s1, 4($sp)		#  
	sw	$ra, 8($sp)		#
	
	add	$s1, $0, -1		# 
	add	$t1, $0, -1		# 

SIZE_VECTOR:
	add	$s1, $s1, 1		# $s1 =	$s1 + 1
	jal 	GET_A_I			#
	bne	$t0, $t1, SIZE_VECTOR	#
		
	
	add 	$s0, $0, -1		# i = -1
	sub 	$t0, $s1, 1		# $t0 = n-1

A_FALHA:

	add 	$s0, $s0, 1		# i++
	bgt 	$t0, $s0, A_LOOP	# if n-1>i then A_LOOP
	j 	FIM_ORDENA

A_LOOP:

	add 	$s1, $0, $0		# j = 0
	sub 	$t1, $t0, $s0		# $t1 = (n-1)-i
	

B_FALHA:	

	bgt 	$t1, $s1, B_LOOP	# if n-1-i>j then B_LOOP
	j 	A_FALHA
	
B_LOOP:
	add 	$t2, $s1, $s1		#
	add 	$t2, $t2, $t2		#
	add 	$t2, $a0, $t2		# $t2 = adress for a[j]
	
	lw 	$t3, 0($t2)		# $t3 = a[j]
	lw 	$t4, 4($t2)		# $t4 = a[j+1]
	
	add 	$s1, $s1, 1		# j++
	
	bgt 	$t3, $t4, SWAP		# if a[j] > a[j+1] then swap
	j 	B_FALHA
	
SWAP:	sw 	$t3, 4($t2)		# adress a[j+1] <- value a[j]
	sw 	$t4, 0($t2)		# adress a[j] <- value a[j+1]
	j 	B_FALHA
	

FIM_ORDENA:

	lw	$s0, 0($sp)		# pop $s0, $s1, $ra
	lw	$s1, 4($sp)		#
	lw	$ra, 8($sp)		#
	addi	$sp, $sp, 8		#
	
	add	$v0, $a0, $0		# copia o endereço base do vector ordenado para $v0
	
	jr 	$ra			# jumps to return adress

	
################################################################################################






################################################################################################
#
# ESTATISTICA
#
# 	recebe:		.um vector ($a0) ordenado com notas de 0 a 20
#
#	retorna:	imprime na consola:
#			.frequência absoluta de cada nota
#			.média dos notas
#
#
# REGISTOS USADOS:
#
#	$a0	- tem o endereço base do vector com as notas
#
#	$v0	- eh usado para a passar o parametro a syscall
#
# 	$s0	- nota que se estah a comparar, valores entre 0 e 20
#	$s1 	- posicao do array
#	$s2 	- numero de ocorrencia de uma dada nota
#	$s3 	- acumula o total das notas
#
#	$t0	- guarda a nota que eh lida do
#	$t1	- tem o valor 21 durante todo o procedimento
#	$t2	- eh utilizado para guardar um return adress
#	$t3	- eh usado para salvaguardar o que estah no $a0 devido as syscalls
#	$t4	- guarda o valor do produto de uma nota vezes o numero de ocorrencias dessa nota
#
#
#	$f0	- guarda o valor da soma de todas as notas
#	$f1	- guarda o valor do numero de notas que foram inseridas
#	$f12	- guarda o valor real da média das notas
#
#
#
#
# j==0;
# i==0;
# oc==0;
#
# while ( j < 21 ) do {
#	while ( j=a[i] ) do {
#		oc==ac+1;
#		i==i+1;
#		};
#	print "j	oc";
#	total_notas == total_notas + j*oc
#	j==j+1;
#	oc==0;



ESTATISTICA:

	addi	$sp, $sp, -12		# push $s0, $s1, $s2, $s3
	sw	$s0, 0($sp)		#
	sw	$s1, 4($sp)		#
	sw	$s2, 8($sp)		#
	sw	$s3, 12($sp)		#
	
	add 	$s0, $0, $0 		# j==0	
	add 	$s1, $0, $0 		# i==0
	add 	$s2, $0, $0 		# oc==0
	add 	$s3, $0, $0 		# total_notas==0
		
	add 	$t1, $0, 21		# $t1 = 21
	
	add	$t2, $ra, $0		# guarda o return adress em $t2
	jal 	GET_A_I

WHILE_A:
	beq 	$t1, $s0, ESTATISICA_END
	
		
	
WHILE_B:
	bne 	$t0, $s0, NOT_EQUAL_B
	add 	$s2, $s2, 1		# oc==oc+1
	add 	$s1, $s1, 1		# i==i+1
	
	jal 	GET_A_I
	j 	WHILE_B


NOT_EQUAL_B:
	
	add 	$t3, $a0, $0		# copia o que tah em $a0 para $t3
	
	li	$v0, 1			#
	add 	$a0, $s0, $0		#
	syscall				# Imprime a NOTA
	
	
	li	$v0, 4			#
	la $a0, TAB			#
	syscall				# TAB
	
	li	$v0, 1			#
	add 	$a0, $s2, $0		#
	syscall				# Imprime o numero de ocorrencias
	
	
	li	$v0, 4			#
	la 	$a0, LINHA		#
	syscall				# NEW_LINE
	
	
	mul	$t4, $s2, $s0		# $t4 == j*oc
	add 	$s3, $s3, $t4 		# total_notas == total_notas + ( $t4)
	
	add 	$s0, $s0, 1 		# j==j+1
	add 	$s2, $0, $0 		# oc==0
	
	add 	$a0, $t3, $0		# copia o que tah em $t3 para $a0
	
	j WHILE_A
	



ESTATISICA_END:

	mtc1	$s3, $f0		# Calcula a media das notas (numero real)
	cvt.s.w $f0, $f0		#
	mtc1	$s1, $f1		# media = $s3 / $s1
	cvt.s.w $f1, $f1		#
	div.s	$f12, $f0, $f1		#
	
	li	$v0, 4			#
	la 	$a0, LINHA		#
	syscall				# NEW_LINE
	
	li	$v0, 2			#
	syscall				# Imprime a media
	
	li	$v0, 4			#
	la 	$a0, LINHA		#
	syscall				# 
	syscall				# 2 NEW_LINE
		
	
	lw	$s0, 0($sp)		# pop $s0, $s1, $s2, $s3
	lw	$s1, 4($sp)
	lw	$s2, 8($sp)
	lw	$s3, 12($sp)
	addi	$sp, $sp, 12
	
		
	add 	$ra, $t2, $0
	jr 	$ra			# jumps to return adress
	
	
################################################################################################






################################################################################################
#
# GET_A_I
#
#  É um sub-procedimento que vai buscar ao vector em $a0 a posicao em $s1. É exclusivamente
#  utilizado por ESTATISCA e daí nao seguir à risca a convecção de registos e procedure calls
#
#
# recebe: 	.$s1 - o valor de I
#  		.$a0 - o vector A
#
# devolve:	.$t0 o valor de A[I]


GET_A_I:
	add 	$t0, $s1, $s1		#
	add 	$t0, $t0, $t0		# $t0 = 4*i
	add 	$t0, $a0, $t0		# $t0 = adress of a[i]
	lw 	$t0, 0($t0)		# $t0 = a[i]
	jr 	$ra			# jumps to return adress	

################################################################################################


fim:
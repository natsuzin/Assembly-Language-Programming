#Disciplina: Arquitetura e Organiza��o de Processadores
#Atividade: Avalia��o 02 � Programa��o em Linguagem de Montagem
#Exerc�cio 01
#Alunos: Felipe dos Santos e Nathalia Suzin
#Em C++:
#include <iostream>
#using namespace std;
#int main()
#{
#    int i, j, n, maior=0, vetA[8], vetB[8], vetC[8];
#
#
#    do{
#        cout << "Entre com o tamanho dos vetores (m�x=8): ";
#        cin >> n;
#        if(n<1 or n>8)
#            cout << "\nValor inv�lido.\n";
#    }while(n<1 or n>8);
#
#    for(i=0;i<n;i++){
#        cout << "\nEntre com o valor Vetor A[" << i << "]: ";
#        cin >> vetA[i];
#    }
#    for(j=0;j<n;j++){
#        cout << "\nEntre com o valor Vetor B[" << j << "]: ";
#        cin >> vetB[j];
#    }
#    for(i=0;i<n;i++){
#        for(j=0;j<n;j++){
#            if(vetA[i]>vetB[j]){
#                maior=vetA[i];
#                vetC[i]=maior;
#            }else{
#                if(vetB[j]>vetA[i]){
#                    maior=vetB[j];
#                   vetC[j]=maior;
#                }
#            }
#        }
#    for(i=0;i<n;i++){
#      cout << "\nVetor C [" << i << "]: " << vetC[i];
#    }
#    return 0;
#}

               .data
contSize:       .asciiz "\nEntre com o tamanho dos vetores (max. = 8): "
msgInvalid:	.asciiz "\nValor inv�lido."
contStrA:       .asciiz "\nVetor_A["
contStrB:       .asciiz "\nVetor_B["
contStrC:       .asciiz "\nVetor_C["
contEnd:       	.asciiz "]: "
array1:        	.word	0,0,0,0,0,0,0,0
array2:        	.word	0,0,0,0,0,0,0,0
array3:        	.word	0,0,0,0,0,0,0,0

               .text
main:

        la $s1, array1 		# guarda no $s1 o endereco base do array1
        la $s2, array2		# guarda no $s2 o endereco base do array2
        la $s3, array3		# guarda no $s3 o endereco base do array3
        
        addi $s4, $zero, 0      # inicializando indice=0 (i=0)
        j Loop
      
Invalidez:

	li $v0, 4		# Carrega o servi�o 4 (Ponteiro para string)
        la $a0, msgInvalid	# Carega ptr p/ string (Mostra a mensagem na tela)
        syscall			# Chama o servi�o 4
               
Loop:
   
        li $v0, 4 		# Carrega o servico 4 (Ponteiro para string)
        la $a0, contSize 	# Carega ptr p/ string (Mostra a mensagem na tela)
        syscall			# Chama o servico 4
        
        li $v0, 5 		# Carrega o servico 5
        syscall 		# Chama o servico 5
        add $s0, $v0, $zero	# O que o usuario digitar sera adicionado ao $s0
        
        blt $s0, 1, Invalidez	# Se o valor digitado for menor que 1, volta para "Invalidez"
        bgt $s0, 8, Invalidez	# Se o valor digitado for maior que 8, volta para "Invalidez"
        
LoopA:				#RESPONSAVEL POR PEDIR OS VALORES DE 'A' E GUARDAR NA MEMEORIA

	li $v0, 4 		# Carrega o servico 4 (Ponteiro para string)
        la $a0, contStrA	# Carrega ptr p/ string (Mostra a mensagem na tela)
        syscall			# Chama o servico 4
	
        li $v0, 1 		# Carrega o servico 1 (inteiro)
        la $a0, ($s4) 		# Carrega no $a0 o valor inteiro do indice
        syscall 		# Chama o servico 1
        
        li $v0, 4 		# Carrega o servico 4 (Ponteiro para string)
        la $a0, contEnd		# Carrega ptr p/ string (Mostra a mensagem na tela)
        syscall 		# Chama o servico 4
        
        li $v0, 5 		# Carrega o servico 5
        syscall 		# Chama o servico 5
        add $t2, $v0, $zero	# O que o usuario digitar sera adicionado ao t2
        
	add $t1, $s4, $s4       # $t1 = 2.i 
      	add $t1, $t1, $t1       # $t1 = 4.i
      	add $t1, $t1, $s1       # $t1 = endereco base + 4.i (deslocamento) = endereco absoluto do vetor A
      	sw  $t2, 0($t1)         # $t2 = save[i]
      	addi $s4, $s4, 1       	# i = i + 1
      	
	blt $s4, $s0, LoopA     # Se indice for menor que o valor escolhido pelo usuario, volta para LoopA
	addi $s4, $zero, 0      # Restaurando o indice para 0 (i=0)
	
LoopB:				#RESPONSAVEL POR PEDIR OS VALORES DE 'B' E GUARDAR NA MEMORIA 
	li $v0, 4 		# Carrega o servico 4 (Ponteiro para string)
        la $a0, contStrB	# Carrega ptr p/ string (Mostra a mensagem na tela)
        syscall			# Chama o servico 4
	
        li $v0, 1 		# Carrega o servico 1 (inteiro)
        la $a0, ($s4) 		# Carrega no $a0 o valor inteiro do indice
        syscall 		# Chama o servico 1
        
        li $v0, 4 		# Carrega o servico 4 (Ponteiro para string)
        la $a0, contEnd		# Carrega ptr p/ string (Mostra a mensagem na tela)
        syscall 		# Chama o servico 4
        
        li $v0, 5 		# Carrega o servico 5
        syscall 		# Chama o servico 5
        add $t2, $v0, $zero	# O que o usuario digitar sera adicionado ao t2
        
	add $t1, $s4, $s4       # $t1 = 2.i 
      	add $t1, $t1, $t1       # $t1 = 4.i
      	add $t1, $t1, $s2       # $$t1 = endereco base + 4.i (deslocamento) = endereco absoluto do vetor B
      	sw  $t2, 0($t1)         # $t0 = save[i]
      	addi $s4, $s4, 1       	# i = i + 1
      	
	blt $s4, $s0, LoopB     # Se indice for menor que o valor escolhido pelo usuario, volta para LoopB
	addi $s4, $zero, 0      # Restaurando o indice para 0 (i=0)
	
LoopC:				#RESPONSAVEL POR CARREGAR A E B, depois guardar o maior valor em C
	#Carrega o valor de A[i]
	add $t1, $s4, $s4       # $t1 = 2.i 
      	add $t1, $t1, $t1       # $t1 = 4.i
      	add $t1, $t1, $s1       # $t1 = endereco base + 4.i (deslocamento) = endereco absoluto do vetor A
      	lw  $t4, 0($t1)         # $t2 receber o valor de A[i]
      	
	#Carrega o valor de B[i]
	add $t1, $s4, $s4       # $t1 = 2.i 
      	add $t1, $t1, $t1       # $t1 = 4.i
      	add $t1, $t1, $s2       # $t1 = endereco base + 4.i (deslocamento) = endereco absoluto do vetor B
      	lw  $t3, 0($t1)         # $t3 = recebe o valor de A[i]
      	
      	bgt $t4, $t3, Calc	# Se A for maior que B vai para Calc
      	
      	#Senao, vetor C vai receber valor de B 
      	add $t1, $s4, $s4       # $t1 = 2.i 
      	add $t1, $t1, $t1       # $t1 = 4.i
      	add $t1, $t1, $s3       # $t1 = endereco base + 4.i (deslocamento) = endereco absoluto do vetor C
      	sw  $t3, 0($t1)         # $t0 = save[i]
      	addi $s4, $s4, 1       	# i = i + 1
      	
      	blt $s4, $s0, LoopC	# Se indice for menor que o valor escolhido pelo usuario, volta para LoopC
      	addi $s4, $zero, 0      # Restaurando o indice para 0 (i=0)
      	
LoopD:

	#Carrega o valor de C[i]
	add $t1, $s4, $s4       # $t1 = 2.i 
      	add $t1, $t1, $t1       # $t1 = 4.i
      	add $t1, $t1, $s3       # $t1 = endereco base + 4.i (deslocamento) = endereco absoluto do vetor C
      	lw  $t4, 0($t1)         # $t2 receber o valor de C[i]
      	
	li $v0, 4 		# Carrega o servico 4 (Ponteiro para string)
        la $a0, contStrC	# Carrega ptr p/ string (Mostra a mensagem na tela)
        syscall			# Chama o servico 4
	
        li $v0, 1 		# Carrega o servico 1 (inteiro)
        la $a0, ($s4) 		# Carrega no $a0 o valor inteiro do indice
        syscall 		# Chama o servico 1
        
        li $v0, 4 		# Carrega o servico 4 (Ponteiro para string)
        la $a0, contEnd		# Carrega ptr p/ string (Mostra a mensagem na tela)
        syscall 		# Chama o servico 4 
        
        li $v0, 1 		# Carrega o servico 1 (inteiro)
        la $a0, ($t4) 		# Carrega no $a0 o valor inteiro do indice
        syscall 		# Chama o servico 1
        addi $s4, $s4, 1       	# i = i + 1
        
       	blt $s4, $s0, LoopD	# Se indice for menor que o valor escolhido pelo usuario, volta para LoopD
       	j Exit 
       	
Calc:
	add $t1, $s4, $s4       # $t1 = 2.i 
      	add $t1, $t1, $t1       # $t1 = 4.i
      	add $t1, $t1, $s3       # $t1 = endereco base + 4.i (deslocamento) = endere�o absoluto do vetor C
      	sw  $t4, 0($t1)         # $t0 = save[i]
      	addi $s4, $s4, 1       	# i = i + 1
      	
      	j LoopC   	
      	
Exit: 
	nop			# Null operation, ele ira terminar o codigo e nao fara mais nada!
	


;Autor: Omar Damian
;En los registros S0, S1 Y S2 se introduce la cantidad de cajas de naranjas, platanos y manzanas respectivamente.
;Si la condicion del minimo del total de cajas se cumple se hacen los calculos del total de cajas y los resultados se muestran 
;en los registros S20, S21 y S22, siendo los resultados igual a # de contenedores del proveedor A, # de contenedores del provee-
;dor B y el total de distancia que se produce con esa combinacion, respectivamente. Por restricciones fisicas solo se admiten 
;las respuestas en cuyo caso el # de contenedores de ambos proveedores son mayores a 1 en caso contrario en los registros, de 
;las respuestas se encontrara el valor de 111 en los 3.
		AREA codigo, CODE,READONLY, ALIGN=2
		THUMB
		EXPORT Start
			
Start
	VLDR.F32 S0,=12    ;Cantidad de cajas de naranjas  X
	VLDR.F32 S1,=5     ;Cantidad de cajas de platanos Y
	VLDR.F32 S2,=20	   ;Cantidad de cajas de manzanas Z
;---------Condicion de operacion si el numero total de cajas es menor a 45 no se realizara ningun calculo---------------
	VADD.F32 S4,S0
	VADD.F32 S4,S1
	VADD.F32 S4,S2
	VLDR.F32 S3,=45
	VCMP.F32 S4,S3
	VMRS APSR_nzcv, FPSCR
	BLT.W main	
;--------Fin de condicion------------------------------------------------------------------------------------------------
	;Constantes del registro s9 al s16
	VLDR.F32 S9,=6
	VLDR.F32 S10,=3
	VLDR.F32 S11,=7
	VLDR.F32 S12,=5
	VLDR.F32 S13,=26
	VLDR.F32 S14,=2
	VLDR.F32 S15,=1
	VLDR.F32 S16,=0
	;Primera solucion -> x1,S3
	VDIV.F32 S17,S15,S9;1/6
	VDIV.F32 S18,S15,S10;1/3
	VMUL.F32 S19,S17,S0;1/6*X
	VMUL.F32 S20,S18,S1;1/3*Y
	VSUB.F32 S3,S19,S20;1/6*X-1/3*Y
	;Segunda solucion -> x2,S4
	VDIV.F32 S17,S11,S12;7/5
	VDIV.F32 S18,S15,S11;1/7
	VMUL.F32 S19,S18,S2;1/7*Z
	VSUB.F32 S20,S1,S19;Y-1/7*Z
	VMUL.F32 S4,S20,S17;7/5[Y-1/7*Z]
	;Tercera solucion -> x3,S5
	VDIV.F32 S17,S11,S13;7/26
	VDIV.F32 S21,S15,S14;1/2
	VMUL.F32 S19,S21,S0;1/2*X
	VMUL.F32 S20,S18,S2;1/7*Z
	VSUB.F32 S19,S20;1/2*X-1/7*Z
	VMUL.F32 S5,S17,S19;7/26*[1/2*X-1/7*Z]
	;Caculo de y1=1/2*X-4*x1
	VDIV.F32 S17,S15,S14;1/2
	VMUL.F32 S17,S0;1/2*X
	VMUL.F32 S18,S14,S14;4
	VMUL.F32 S18,S3;4*x1
	VSUB.F32 S6,S17,S18;1/2*X-4*x1
	;Calculo de y2=Y-x2
	VSUB.F32 S7,S1,S4
	;Calculo de y3=1/7*Z-2/7*x3
	VDIV.F32 S17,S15,S11;1/7
	VDIV.F32 S18,S14,S11;2/7
	VMUL.F32 S17,S2;1/7*Z
	VMUL.F32 S18,S5;2/7*x3
	VSUB.F32 S8,S17,S18;1/7*Z-2/7*x3
	;Cambio de constantes
	VLDR.F32 S12,=150
	VLDR.F32 S13,=300
	;Calculo de distancias -> Tx=150*xx+300*yx
	;Distancia 1 de los pares x1,y1 -> T1=150*x1+300*y1
	VMUL.F32 S17,S12,S3; 150*x1
	VMUL.F32 S18,S13,S6; 300*y1
	VADD.F32 S9,S17,S18; 150*x1+300*y1
	;Distancia 2 de los pares x2,y2 -> T2=150*x2+300*y2
	VMUL.F32 S17,S12,S4; 150*x2
	VMUL.F32 S18,S13,S7; 300*y2
	VADD.F32 S10,S17,S18; 150*x2+300*y2
	;Distancia 3 de los pares x3,y3 -> T3=150*x3+300*y3
	VMUL.F32 S17,S12,S5; 150*x3
	VMUL.F32 S18,S13,S8; 300*y3
	VADD.F32 S11,S17,S18; 150*x3+300*y3	
	;Toma de decision
	VLDR.F32 S15,=1
	VLDR.F32 S16,=0
	LDR R0,=0
	LDR R1,=0
	B cmp_s6s15

;Se compara si las soluciones son mayores a 1 de lo contrario no se toman en cuenta, debido a que no es posible ordenar algo menor a 1 contenedor
cmp_s6s15 ; Compara el valor de y1>=1
	VCMP.F32 S6,S15
	VMRS APSR_nzcv, FPSCR
	BGE cmp_s6s7   ; si se cumple la condicion se comparar y1<y2
	BLT cmp_s7s15  ; si no se pasa al siguiente y2>1
	
cmp_s7s15 ; Compara el valor de y2>=1
	VCMP.F32 S7,S15
	VMRS APSR_nzcv, FPSCR
	BGE cmp_s7s8 ; si se cumple la condicion se comparar y2<y3
	BLT cmp_s8s15	; si no se pasa al siguiente y3>1
	
cmp_s8s15 ; Compara el valor de y3>=1
	VCMP.F32 S8,S15
	VMRS APSR_nzcv, FPSCR
	BGE min_s8 ; si se cumple entonces esta es la solucion del problema x3, y3 y Dt3
	BLT na	; si y3 no es mayor a 1 entonces se colocan valores por dfef
	
cmp_s6s7 ; El menor resultado de y1, y2 y y3, -> S6, S7 y S8
	VCMP.F32 S6,S7
	VMRS APSR_nzcv, FPSCR
	BLT cmp_s6s8 ; se compara si y1<y2 si se cumple se compara si y1<y3
	BHI cmp_s7s15 ; si no se cumple se comprara y2>1

cmp_s6s8
	VCMP.F32 S6,S8
	VMRS APSR_nzcv, FPSCR
	BLT min_s6 ; si y1<y3 entonces se da la solucion de x1, y1 y Dt1
	BHI cmp_s8s15 ; si no se cumple se compara si y3>1

cmp_s7s8
	VCMP.F32 S7,S8
	VMRS APSR_nzcv, FPSCR
	BLT min_s7 ; si y2<y3 entonces se da la solucion de x2, y2, Dt2
	BHI cmp_s8s15; si no se comprar si y3>1
	
; comparacion de x1, x2 o x3 >= 1
min_s6
	VCMP.F32 S3,S15
	VMRS APSR_nzcv, FPSCR
	BGE resultado_0 ; si x1>1 entonces se procede a indicar la respuesta del problema con los datos ingresados
	BLT cmp_s7s15 ; si no se cumple se descarta el primer par de respuestas y se evaluan el resto
	B main
	
min_s7
	VCMP.F32 S4,S15
	VMRS APSR_nzcv, FPSCR
	BGE resultado_1; si x2>1 se muestra el resultado
	BLT cmp_s8s15 ; si no se descarta x2, y se evalua la ultima respuesta y>1
	B main
	
min_s8
	VCMP.F32 S5,S15
	VMRS APSR_nzcv, FPSCR
	BGE resultado_2; si x3>1 se muestra el resultado
	BLT na         ; se dan resultados por defecto para indicar que no se logra encontrar algun valor que optimize el problema
	B main

na
	VLDR.F32 S20,=111
	VLDR.F32 S21,=111
	VLDR.F32 S22,=111
	B main

resultado_0 ; se colocan los valores de S20 = x1, S21 = y1 y s22 = Dt1
	VMOV.F32 S20,S3
	VMOV.F32 S21,S6
	VMOV.F32 S22,S9
	B main
	
resultado_1 ; se colocan los valores de S20 = x2, S21 = y2 y s22 = Dt2
	VMOV.F32 S20,S4
	VMOV.F32 S21,S7
	VMOV.F32 S22,S10
	B main

resultado_2 ; se colocan los valores de S20 = x3, S21 = y3 y s22 = Dt3
	VMOV.F32 S20,S5
	VMOV.F32 S21,S8
	VMOV.F32 S22,S11
	B main
	
main
 	NOP
	NOP
	NOP
	B main
	ALIGN
	END	
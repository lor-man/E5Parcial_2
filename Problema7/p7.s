;Autor: Omar Damian
;Escriba un programa que pueda ingresar N datos
;(minimo 20), y con estos datos dar el resultado
;de la suma y su promedio
;----------------------------------------------------
    AREA codigo, CODE, READONLY, ALIGN =2
    THUMB   
    EXPORT Start

Start ; Inicio de la sumatoria de los N numeros, por defecto se tienen 20 al inicio los cuales se pueden cambiar.
	VLDR.F32 S0,=0
	VLDR.F32 S1,=4586;#1
	VADD.F32 S0,S1   
	VLDR.F32 S1,=8795;#2
	VADD.F32 S0,S1   
	VLDR.F32 S1,=5648;#3
	VADD.F32 S0,S1   
	VLDR.F32 S1,=3356;#4
	VADD.F32 S0,S1   
	VLDR.F32 S1,=4798;#5
	VADD.F32 S0,S1   
	VLDR.F32 S1,=8794;#6
	VADD.F32 S0,S1   
	VLDR.F32 S1,=4583;#7
	VADD.F32 S0,S1   
	VLDR.F32 S1,=4577;#8
	VADD.F32 S0,S1   
	VLDR.F32 S1,=8921;#9
	VADD.F32 S0,S1   
	VLDR.F32 S1,=8623;#10
	VADD.F32 S0,S1   
	VLDR.F32 S1,=54  ;#11
	VADD.F32 S0,S1   
	VLDR.F32 S1,=8753;#12
	VADD.F32 S0,S1   
	VLDR.F32 S1,=2546;#13
	VADD.F32 S0,S1   
	VLDR.F32 S1,=5461;#14
	VADD.F32 S0,S1   
	VLDR.F32 S1,=2164;#15
	VADD.F32 S0,S1   
	VLDR.F32 S1,=2135;#16
	VADD.F32 S0,S1   
	VLDR.F32 S1,=8795;#17
	VADD.F32 S0,S1   
	VLDR.F32 S1,=3216;#18
	VADD.F32 S0,S1   
	VLDR.F32 S1,=2168;#19
	VADD.F32 S0,S1   
	VLDR.F32 S1,=8765;#20
	VADD.F32 S0,S1   
;Desde este punto se puede seguir agregando numeros para la sumatoria, COPIANDO LAS 2 LINEAS DE CODIGO SIGUIENTES LAS VECES NECE
;SARIAS PARA CUBRIR EL NUMERO DE DATOS DESEADO
;	VLDR.F32 S1,=N
;	VADD.F32 S0,S1   ;#N
;--------------------------------------------------------------------
	VLDR.F32 S2,=20 ; El valor de este registro debe de ser cambiado para dividir dentro del numero total de datos y obtener el 
	VDIV.F32 S3,S0,S2 ; de los datos ingresados
main
	NOP
	NOP
	NOP
	NOP
	B main
    ALIGN
    END
# Ferrovie
# DATI

set N := 0..9;										# nodi
set Archi within N cross N;			# archi
param nt {Archi};								# numero treni
param nv {Archi};								# numero vagoni
param cap {Archi};							# capacita' vagone [ton]
set Merci;
param limite {N,Merci};
param val {Merci};

# VARIABILI

# N-N = da dove a dove (le merci sugli archi che esistono)
var x {i in N,j in N,Merci: (i,j) in Archi} >= 0;

# VINCOLI

# Vincoli di conservazione del flusso (j non 0 e non 9)
subject to Flow {j in N, k in Merci: j not in {0,9}}:
	sum {(i,j) in Archi} x[i,j,k] = sum {(j,i) in Archi} x[j,i,k];

# Vincoli di capacita' sugli archi
subject to Arc_capacity {(i,j) in Archi}:
	sum {k in Merci} x[i,j,k] <= nt[i,j] * nv[i,j] * cap[i,j];

# Vincoli di capacita' sui nodi
subject to Node_capacity {j in N,k in Merci}:
	sum {(i,j) in Archi} x[i,j,k] <= limite[j,k];
subject to Node_capacity0 {k in Merci}:
	sum {(0,j) in Archi} x[0,j,k] <= limite[0,k];

# OBIETTIVO

# Massimizzare il valore totale trasportato
maximize z: sum {j in N, k in Merci: (0,j) in Archi} val[k] * x[0,j,k];

###

data;

param:	  nt     nv     cap :=
0,1			   4	   10     20
0,2			   4		8      15
1,3			   2 	   10     20
1,4			   3 		6      20
2,4    		   8   	2      16
2,5			   1  		8      16
3,6			   5       4      16
3,7			   4       6      16
4,6			   3       5      16
4,7			   3       4      16
4,8			   3    	5      16
5,7			   4      18     10
5,8			   4      10     10
6,9			   3        9      18
7,9			   5        3      20
8,9			   2     	11     18
;

# s e t diventano nodo 0 e nodo 9
set Archi :=
0 1,
0 2,
1 3,
1 4,
2 4,
2 5,
3 6,
3 7,
4 6,
4 7,
4 8,
5 7,
5 8,
6 9,
7 9,
8 9,
;

set Merci := A B C;

param limite :	A				B				C :=
0						1000		1000		1000
1						300			1800		1400
2						250			900			100
3						900			650			1400
4						2000		1500		2000
5						1000		1000		1000
6						1200		1200		1400
7						600			700			950
8						300			1700		1900
9						1000		1000		1000
;

param val :=
A		80
B		50
C		65
;

end;

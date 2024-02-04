# Trasmissioni da Marte
# DATI

param nB;
param nT;

set B := 1..nB;						# numero banchi di memoria
set T := 1..nT;						# numero intervalli temporali

param prod_dati {T,B};			# produzione di dati [Mbit]
param cap {B};						# capacita' memoria [Mbit]
param occ {B};						# occupazione iniziale della memoria [Mbit]
param durata {T};					# durata della trasmissione [s]
param bit_rate {T};				# bit-rate della trasmissione [Mbit/s]

# VINCOLI

var x {B} >= 0;

# VINCOLI

# Vincolo sulla capacita' massima del banco
# (la produzione di dati non deve eccedere la capacita' massima
# inoltre tengo conto dello svuotamento della memoria)
subject to Max_size {b in B}:
	sum {t in T} (prod_dati[t,b] * x[b] - bit_rate[t] * durata[t]) <= cap[b] - occ[b];

# Vincolo FIFO
subject to Fifo:
	sum {b in B} x[b] = 1;

# OBIETTIVO

minimize z: sum {b in B} occ[b] / cap[b] * x[b];

###
data;

param nB := 6;
param nT := 9;

param prod_dati:   1    2    3    4    5    6 :=
1      					4   11   31    3   18   27
2      					6    8   34    4   19   23
3      					7   23   38    5   21   19
4      					3   31   35    6   15   18
5      					3   14   37    7   14   23
6      					8    8   35    6   14   24
7      					1   10   31    5   14   25
8      					3   20   40    4   18   20
9      					4   13   28    5   19   13
;

param cap :=
1	  32
2	  60
3	100
4	  30
5	  50
6	  80
;

param occ :=
1	  8
2	15
3	25
4	  5
5	16
6	23
;

param durata :=
1	490
2	420
3	460
4	485
5	400
6	455
7	480
8	380
9	450
;

param bit_rate :=
1	0.195
2	0.160
3	0.180
4	0.195
5	0.160
6	0.180
7	0.195
8	0.160
9	0.180
;

end;

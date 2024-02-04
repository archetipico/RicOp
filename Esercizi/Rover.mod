# Rover
# DATI

param nS;						# numero siti
param init_S;					# posizione iniziale
param c_spos;					# consumo per spostamento [J/min]
param b;							# energia disponibile [J]
param t;							# tempo disponibile [min]

set S := 1..nS;					# siti
set SA := 1..nS+1;

param t_spos {SA,SA};		# tempo di spostamento [min]
param t_espl {S};				# tempo di esplorazione [min]
param c {S};						# consumo per l'esplorazione [J]
param e_espl {S};				# valore atteso di ogni esplorazione

# VARIABILI

var x {S} binary;				# siti visitati
var y {SA} binary;				# spostamenti effettuati
var z;								# variabile ausiliaria per la f.o.

# VINCOLI

# Vincolo sul fatto che il rover inizia al sito 7 (e non e' di interesse)
# dunque verifico che il rover visiti punti che siano anche punti di interesse
subject to Init:
	sum {s in S} x[s] = 6;

# Vincolo sul tempo massimo spendibile
# Considero due cose:
# - il tempo di esplorazione * i siti esplorati
# - il tempo di spostamento * gli spostamenti effettuati
subject to Max_time {sa2 in SA}:
	(sum {s in S} t_espl[s] * x[s]) + (sum {sa1 in SA} t_spos[sa1,sa2] * y[sa1]) <=  t;

# Vincolo sull'energia massima spendibile
# Considero due cose:
# - il consumo dell'esplorazione del sito * siti visitati
# - il consumo dello spostamento * gli spostamenti effettuati
subject to Max_energy:
	(sum {s in S} c[s] * x[s]) + (sum {sa in SA} c_spos * y[sa]) <= b;

# OBIETTIVO

# Massimizzo per visitare tutti i siti
#maximize z1: sum {s in S} e_espl[s] * x[s];

# So che visito tutti i siti, allora ottimizzo le risorse
minimize z2: (sum {s in S} c[s] * x[s]) + (sum {sa in SA} c_spos * y[sa]);

###

data;

param nS := 6;
param init_S := 7;
param c_spos := 8;
param b := 1000;
param t := 400;

param t_spos:     1   2   3   4   5   6  7 :=
 1   					0  13  14  16  13  13 13
 2  					13   0  15  14  16  14 11
 3  					14  15   0  15  18  13 17
 4  					16  14  15   0  17  16 18
 5  					13  16  18  17   0  18 15
 6  					13  14  13  16  18   0 15
 7  					13  11  17  18  15  15  0
 ;

param t_espl :=
1	35
2	20
3	40
4	60
5	25
6	10
;

param c :=
1	60
2	45
3	70
4	110
5	50
6	25
;

param e_espl :=
1	90
2	50
3	20
4	100
5	120
6	50
;

end;

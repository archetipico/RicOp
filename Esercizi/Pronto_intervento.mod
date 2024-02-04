# Pronto intervento
# DATI

param nO;								# numero obiettivi
param nS;								# numero squadre
param nL;								# numero luoghi

set O := 1..nO;						# obiettivi
set L := 1..nL;						# luoghi

param t {L,O};						# tempi di intervento [min]

# VARIABILI

var x {L} binary;					# indica se nel luogo e' presente una squadra
var y {O,L} binary;				# assegnamento dell'obiettivo al luogo
var z;										# variabili ausiliaria

# VINCOLI

# Vincolo sul numero di squadre in citta'
subject to Count_squadre:
	sum {l in L} x[l] = nS;

# Vincolo che assicura che l'obiettivo sia in un solo luogo
# La somma dei valori di ogni luogo, per un dato obiettivo = 1
subject to Obiettivo_assign {o in O}:
	sum {l in L} y[o,l] = 1;

# Vincolo sull'obiettivo da assegnare alla squadra
# Non ci puo' essere un obiettivo assegnato ad un
# luogo (y[o,l]=1) se in quel luogo non c'e' una
# squadra (x[l]=0). Quindi se x[l]=1 allora l'
# obiettivo per quel luogo puo' essere 1 (se e'
# assegnato in quel luogo) oppure 0 (se e' da
# un'altra parte). Se x[l]=0, io NON voglio che
# sia assegnato un obiettivo a quel luogo. Il senso
# e' che per ogni luogo, io mi metto a vedere se
# l'obiettivo appartiene alla squadra, quindi 0 o 1,
# ergo basta che sia <= x[l] che e' 1 quando c'e' la
# squadra nel luogo, e ovviamente y[o,l] deve essere
# 0 quando x[l]=0 perche' tanto se non ho squadra
# non ho obiettivo. Inoltre non faccio la somma
# degli obiettivi perche' per ogni luogo potrebbero
# esserci piu' obiettivi e se ho magari 1 luogo
# con 2 obiettivi, risulta > x[l] che segna =1 in quanto
# possiede almeno una squadra (e quindi viene scartato
# dato che 2 non e' <= x[l])
subject to Obiettivo_squadra {l in L, o in O}:
	y[o,l] <= x[l];

# Vincolo sul fatto che ogni squadra debba controllare
# al massimo Math.ceil( nO / nS ) obiettivi
#
# Dato che in totale ci sono nS squadre e x[l]
# vale 1 quando c'e' una squadra, 0 altrimenti, mi
# assicuro che la somma degli obiettivi per ogni
# luogo sia <= al ceil * il numero di squadre nel luogo.
# Cosi' facendo, gli obiettivi sono 0 se non ci
# squadre (dato che moltiplico per zero), altrimenti
# il numero degli obiettivi nel luogo non deve
# superare ceil( nO / nS )
subject to Obiettivi_max {l in L}:
	sum {o in O} y[o,l] <= ceil( nO / nS ) * x[l] ;

# OBIETTIVO

# Massimo dei tempi di intervento
subject to Max_temp {l in L, o in O}:
	z >= t[l,o] * y[o,l];

# Minimizzo z
minimize z1: z;

###

data;

param nO := 7;
param nS := 3;
param nL := 6;

param t :    1    2    3    4     5   6     7 :=
  1            	0    9    7  15     3   4     2
  2           	  12    0    2  14     8   4     3
  3            	6    4    9     9  19  11  15
  4            	5    1    8     0    6  12  17
  5            	2  10  11  10    0    6   20
  6            	8   7   15     5    5    0   12
;

end;

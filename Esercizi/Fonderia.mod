# Fonderia
# DATI

set P;								# prodotti
set M;								# materie prime

param dis {M};				# disponibilita' M [kg/giorno]
param a {M,P};				# percentuale M per P
param c1 {P};				# prezzi primo scenario [eur/kg]
param c2 {P};				# prezzi secondo scenario [eur/kg]

# VARIABILI

var x {P} >= 0;
var z;

# VINCOLI

# Vincolo sulla disponibilita'
subject to Max_disp {m in M}:
	sum {p in P} a[m,p] * x[p] <= dis[m];

# OBIETTIVO

# Voglio OTTIMIZZARE tra i due CASI PEGGIORI
# (il caso peggiore vale di meno dato che mi fa
# guadagnare meno, quindi la differenza dara'
# un risultato piu' alto, per quello massimizzo,
# almeno prendo il valore maggiore)
maximize z_ott: z;
# Scenario 1
subject to Scenario1:
	sum {p in P} c1[p] * x[p] - z >= 0;
# Scenario 2
subject to Scenario2:
	sum {p in P} c2[p] * x[p] - z >= 0;

# Qui sotto per vedere di quanto si discosta il ricavo

# Ricavo ottenuto dal primo scenario
#maximize z1: sum {p in P} c1[p] * x[p];

# Ricavo ottenuto dal secondo scenario
#maximize z2: sum {p in P} c2[p] * x[p];

# Per quanto riguarda i rifornimenti, guardo
# le variabili SLACK UPPER BOUND, nell'
# analisi di sensitivita': se la prima riga ha un
# valore, sotto trovo un ., questo significa che
# il prodotto addirittura mi avanza. Se invece
# nella prima riga ho un ., nella seconda avro'
# un valore che e' il prezzo ombra. Se il prezzo
# ombra >= ai valori che ho io in `rifornimenti
# ulteriori` allora mi conviene comprare (dato
# che significa che i miei prezzi di rifornimento
# sono buoni), altrimenti non mi conviene
# (perche' infatti significa che mi costerebbe
# troppo per comprare ulteriori rifornimenti)

###

data;

set P := P1 P2 P3;
set M := M1 M2 M3 M4;

param dis :=
M1				2900
M2				2200
M3				4000
M4				1550
;

param a :		P1   P2   P3 :=
M1 	        	   .58   .22   .30
M2      		   .12   .15   .60
M3     	    	   .20   .53   .14
M4      		   	.10   .15   .23
;

param c1 :=
P1	 			     6
P2				   10
P3				   12
;

param c2 :=
P1				   12
P2				   10
P3	 			     6
;

end;

# Hong Kong
# DATI

param nA;						# numero appuntamenti
param b;							# valore massimo biglietto (budget)

set A := 1..nA;					# appuntamenti

param c {A};						# costo unitario tragitto
param v {A};						# valore unitario dell'affare

# VARIABILI

var x {A} binary;				# appuntamento completato
var y {A} binary;				# ultimo appuntamento

# VINCOLI

# Vincolo sul fatto che l'ultimo appuntamento e' solo uno
# (il solutore non sa che y[a] e' grande 1, devo dirglielo)
subject to One:
	sum {a in A} y[a] = 1;

# Vincolo che mi permette di definire y come ultimo
# Quello che non voglio che accada e' che y[a]=1 e
# x[a]=0, violando il vincolo <= e dunque dicendo che
# y[a] e' stato assegnato prima di x[a] (quindi non e' ultimo)
subject to Last {a1 in A,a2 in A}:
	y[a1] <= 1 - x[a2];

# Vincolo sul budget massimo
# -1 perche' ho bisogno di almeno 1 punto per spostarmi
subject to Upper_budget:
	sum {a in A} c[a] * x[a] <= b - 1;

# OBIETTIVO

maximize z: sum {a in A} v[a] * (x[a] + y[a]);

###

data;

param nA := 20;
param b := 850;

param c :=
1		200
2		180
3		165
4		141
5		138
6		130
7		122
8		115
9		109
10	104
11	  90
12	  79
13	  61
14	  50
15	  42
16	  34
17	  27
18	  20
19	  12
20	    9
;

param v :=
1		112
2		105
3		104
4		  99
5		  97
6		  90
7		  81
8		  78
9		  66
10	  58
11	  55
12	  52
13	  50
14	  43
15	  41
16	  37
17	  35
18	  33
19	  30
20	  25
;

end;

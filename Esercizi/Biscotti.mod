# Biscotti
# DATI

# Trimestre = 12 sett di 5 giorni lavorativi => 1 sett = 5gg & 12 sett = 60gg
set B;						# biscotti
set I;						# ingredienti

param ingr {I,B};			# perc. ingredienti
param upperq_prod {B};		# produzione massima giornaliera [kg/giorno]
param v {B};				# prezzo di vendita [eur/kg]
param c {I};				# costo ingredienti [eur/kg]
param lowerq_tobuy {I};		# quantita' minime da acquistare [kg/5gg]
param lower {B};			# quantita' minime da produrre / sett [kg/5gg]
param upper {B};			# quantita' massime da produrre / sett [kg/5gg]
param budget;				# budget disponibile per il trimestre [60gg]
#param c_camp;				# costo campagna per il trimestre [60gg]

# VARIABILI

var x {B} >= 0;
var y {I} >= 0;

# VINCOLI

# Vincolo sulla quantita' massima giornaliera
subject to Max_dailyprod {b in B}:
	sum{i in I} ingr[i,b] * x[b] <= upperq_prod[b];

# Vincolo sulle quantita' minime di ingredienti da acquistare
subject to Min_tobuy {i in I}:
	y[i] >= lowerq_tobuy[i];

# Vincolo sulle quanitta' minime da produrre
subject to Min_prod {b in B}:
	sum{i in I} ingr[i,b] * x[b] * 5 >= lower[b];

# Vincolo sulle quantita' massime da produrre
subject to Max_prod {b in B}:
	sum{i in I} ingr[i,b] * x[b] * 5 <= upper[b];

# Vincolo sul budget trimestrale
subject to Max_budget {b in B}:
	sum {i in I} c[i] * y[i] <= budget;

# OBIETTIVO

maximize z: sum {b in B, i in I} (v[b] - c[i]) * x[b];

###
data;

set B := Svegliallegra Frollino Alba ProntiVia;
set I := Farina Uova Zucchero Burro Latte Additivi Nocciole Acqua;

param ingr:	   Svegliallegra   Frollino      Alba      ProntiVia :=
Farina           .20           .25           .30           .20
Uova             .15            .0           .10           .20
Zucchero         .20           .15           .25           .10
Burro             .0            .0           .10           .10
Latte            .10           .20           .20           .15
Additivi         .15           .20            .0           .15
Nocciole         .10            .0            .0            .0
Acqua            .10           .20            .5           .10
;

param upperq_prod :=
Svegliallegra    165
Frollino         250
Alba		     500
ProntiVia        250
;

param v :=
Svegliallegra    1.75
Frollino		 1.00
Alba		     1.25
ProntiVia        1.50
;

param c :=
Farina    0.5
Uova      2
Zucchero  0.5
Burro     1
Latte     1.5
Additivi  1
Nocciole  5
Acqua	  0
;

param lowerq_tobuy :=
Farina    450
Uova      200
Zucchero  320
Burro     140
Latte     320
Additivi  100
Nocciole   50
Acqua	    0
;

param lower :=
Svegliallegra       50
Frollino		   100
Alba		       500
ProntiVia          300
;

param upper :=
Svegliallegra      300
Frollino		   500
Alba		      1000
ProntiVia          500
;

param budget := 21600;
#param c_camp := 5000;

end;

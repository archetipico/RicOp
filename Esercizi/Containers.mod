# Containers
# DATI

param nO;								# numero oggetti diversi
param nC;								# numero containers diversi

set O := 1..nO;							# oggetti diversi
set C := 1..nC;							# containers

param n {O};							# numero di oggetti
param v {O};								# volume oggetti
param cap {C};							# containers

# VARIABILI

var x {O} integer >= 0;				# oggetti posizionati
var y {C} integer >= 0;				# container utilizzati

# VINCOLI

# # Vincolo sul fatto che io debba trasportare tutti gli oggetti
# x[o] deve essere uguale al numero di oggetti disponibili
subject to Max_objects {o in O}:
	x[o] = n[o];

# Vincolo sulla capacita' massima
# La somma di ogni singolo volume[i] * numero di
# oggetti per quella i <= capacita' massima
subject to Max_capacity {c in C}:
	sum {o in O} v[o] * x[o] <= cap[c] * y[c];

# OBIETTIVO

minimize z: sum {c in C} cap[c] * y[c];

###

data;

param nO := 10;
param nC := 3;

param n :=
1           68
2           90
3           10
4           48
5           28
6           70
7           56
8           10
9           45
10         12
;

param v :=
1           30
2           25
3         200
4           40
5         105
6         150
7           18
8         250
9           54
10         67
;

param cap :=
1	      5000
2		  3000
3		  4000
;

end;

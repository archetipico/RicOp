# Atomi
# DATI

set Atomi := 1..10;

param x {Atomi};
param y {Atomi};
param z {Atomi};
param A {Atomi};
param B {Atomi};

# VARIABILI

# Posizione dell'atomo sonda
var xx;
var yy;
var zz;

# Basta fare Pitagora 3D, ho rimosso il sqrt e lavoro con tutto al quadrato
var d2 {i in Atomi} = (xx - x[i])^2 + (yy - y[i])^2 + (zz - z[i])^2;

# VINCOLI
# Nessuno

# OBIETTIVO

minimize energia: sum {i in Atomi} (A[i]/d2[i]^6 - B[i]/d2[i]^3);

###

data;

param:	           		x	 y	      z :=
1    		3.2  2.5   4.8
2    		2.1  3.7   8.4
3    		7.5  2.5   5.0
4    		6.6  1.2   4.5
5    		0.8  5.1   5.6
6    		6.3  8.8   3.5
7    		2.4  1.0   3.1
8    		1.2  4.6   9.0
9  			8.5  7.8   1.5
10    		4.1  9.3   0.9
;

param:				A		B :=
1			     	1.0		200
2				1.1		400
3				2.1		320
4				3.0		250
5				0.5		400
6				0.2		200
7				0.8		120
8				1.1		300
9				1.5		100
10				1.7		500
;

end;

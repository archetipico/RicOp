# Zoo
# DATI

set A;					# animali
set P;					# prodotti
set S;					# sostanze

param anim {A};			# vettore degli animali
param comp {S,P};		# matrice sostanze/prodotto
param fabb {A,S};		# matrice animali/fabbisogno [kg]
param c {P};			# costo dei prodotti [eur/kg]

# VARIABILI

var x {S} >= 0;

# VINCOLI

subject to Min_fabbisogno {a in A, s in S}:
	sum {p in P} comp[s,p] * anim[a] >= fabb[a,s] * anim[a];

# OBIETTIVO

minimize z: sum {s in S, p in P} c[p] * x[s];

###
data;

set A := Antilope Babbuino Canguro Dromedario Elefante Fringuello Giraffa Ippopotamo Koala Leone Muflone Narvalo Orso Pappagallo Rinoceronte Serpente Tapiro Upupa Visone Zebra;
set P := P1 P2 P3 P4;
set S := Carne Latte Frutta Verdure Zuccheri Grassi Farine Acqua;

param anim :=
Antilope			1
Babbuino			2
Canguro				1
Dromedario  		1
Elefante			1
Fringuello			8
Giraffa				1
Ippopotamo			1
Koala				3
Leone				2
Muflone				2
Narvalo				1
Orso				1
Pappagallo			8
Rinoceronte			1
Serpente 			6
Tapiro				1
Upupa				4
Visone				4
Zebra				2
;

param comp:	P1      P2      P3      P4 :=
Carne     	80       5       0      25
Latte      	 0       5       0       0
Frutta     	 0      25      30       5
Verdure    	 5      40      25      10
Zuccheri   	 5       0       0       0
Grassi    	 0       0       0      15
Farine     	 0       0      25       0
Acqua     	10      25      20      45
;

param fabb:		 Carne Latte Frutta Verdure Zuccheri Grassi Farine Acqua :=
Antilope			0.0  0.0  0.0  2.0  0.2  0.5  1.0  3.0
Babbuino   			1.0  1.0  3.0  0.3  0.2  0.2  0.0  2.0
Canguro   			0.1  0.5  0.1  1.0  0.1  0.3  0.0  4.0
Dromedario   		0.5  0.5  1.0  0.5  0.1  0.5  0.5  5.0
Elefante   			0.0  0.5  5.0  9.0  0.5  1.0  1.0  9.0
Fringuello   		0.0  0.0  0.0  0.0  0.0  0.0  0.1  0.1
Giraffa   			0.0  0.0  0.2  3.0  0.0  0.0  0.0  4.0
Ippopotamo   		0.0  0.0  8.0  6.0  0.5  1.0  0.0 20.0
Koala   			0.0  1.0  1.0  1.0  0.0  0.0  0.2  0.5
Leone   			5.0  0.0  0.0  0.0  1.0  0.5  0.0  5.0
Muflone   			0.0  1.0  0.0  5.0  0.0  0.0  0.0  3.0
Narvalo   			0.0  0.0  0.0  0.0  0.0  0.0  3.0  0.0
Orso   				5.0  0.5  3.0  1.0  0.0  0.0  0.0 10.0
Pappagallo   		0.0  0.0  0.0  0.0  0.0  0.0  0.2  0.5
Rinoceronte   		1.0  0.0  0.0 12.0  0.0  2.0  0.0 15.0
Serpente   			0.5  0.0  0.0  0.1  0.0  0.0  0.0  0.1
Tapiro   			0.0  0.2  1.0  9.0  0.2  0.5  0.0  6.0
Upupa   			0.0  0.0  0.0  0.5  0.1  0.0  0.5  1.0
Visone   			0.0  0.2  0.5  3.0  0.0  0.0  1.0  1.0
Zebra   			0.0  0.0  0.0  5.0  0.5  0.2  0.5  5.0
;

param c :=
P1   		5
P2   		2
P3   		3
P4   		4
;

end;

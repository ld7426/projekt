(* Datoteka s pravili za spremembo stanj *)




(* Funkcija spremeni_stanje sprejme tuple sosedov predvidene dolžine (bool * bool * bool ... * bool) in trenutno stanje : bool, ter vrne končno stanje : bool 
trenutno nastavljeno na obliko
	  |1| |2|
	|3|4|x|5|6|
	  |7| |8| |9|

kjer so po vrsti v sosedituple kot so napisane številke, x je pa trenutna. Tej okolici bomo zdaj pravili dinozaver, saj nas lahko z veliko domišljije spominja na stegozavra https://en.wikipedia.org/wiki/Stegosaurus

kakšne zahteve želimo:
-> da če ima vse okoli sebe prazno rata tudi sam prazen (ne glede na osnovno stanje)
-> ob malem številu sosedov v večini situacij umre
-> ob srednjem številu sosedov v večini situacij oživi
-> ob prevelikem številu sosedov umre


recimo da damo preprosto tako:
-> če je mrtev in ima 3 ali manj živih sosedov potem ostane mrtev
-> če je živ in ima 2 ali manj živih sosedov potem umre
-> če je mrtev in ima med 3 in 9 sosedov potem oživi
-> če je živ in ima med 4 in 8 živih sosedov potem ostane živ
-> Živ in 9 sosedov potem umre

*)
let rec sestejlist seznam =
match seznam with
| true ::tail -> 1 + (sestejlist tail)
| false :: tail -> sestejlist tail
|[] -> 0


let spremeni_stanje sosedilist trenutno_stanje =
let zivisosedi = sestejlist sosedilist in
if zivisosedi <=4 && (not trenutno_stanje) then false
else if zivisosedi <=3 && trenutno_stanje then false
else if not trenutno_stanje then true
else if zivisosedi<=8 then true
else false

let spremeni_stanje_zivi zivisosedi trenutno_stanje =
if zivisosedi <=3 && (not trenutno_stanje) then false
else if zivisosedi <=1 && trenutno_stanje then false
else if not trenutno_stanje then true
else if zivisosedi<=8 then true
else false


let matrikasestejizloceni izloci matrika =
let m = Array.length matrika in
let n = Array.length matrika.(0) in
Array.init m (fun i -> Array.init n (fun j -> sestejlist @@ izloci matrika m n i j))

let kopirajmatriko matrika = (*za sprobavat sem rabil to funkcijo, da nisem spreminjal matrike*)
Array.map Array.copy matrika

let korak izloci matrika = (*glavna funkcija ki jo kličemo skupaj s funkcijo izlocisosede iz izlocisosede.ml, primer: let trenutna = korak izlocisosede zacetnamatrika *)
let m = Array.length matrika in
let n = Array.length matrika.(0) in
Array.init m (fun i -> Array.init n (fun j -> spremeni_stanje_zivi (sestejlist @@ izloci matrika m n i j) matrika.(i).(j) ))

let zacetnamatrika = [|[|false; true; true; true; true; true; true|]; (* za večje primere si je najbolje generirati naključno matriko z ukazom: let matrika = randommatrika m n, ki je v izlocisosede.ml*)
    [|false; true; true; true; true; true; true|];
    [|true; true; true; true; true; true; true|];
    [|false; false; true; true; true; false; true|];
    [|false; false; false; true; false; true; false|]|]


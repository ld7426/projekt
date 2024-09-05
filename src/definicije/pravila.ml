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
   
    
(*želim funkcijo, ki vzame matriko dobljeno z izločeno in na podlagi pravila določi ali bo nov element živ ali ne, mogoče modificiram matriko s številom sosedov, da vključuje podatek, ali je kvaddratek sam živ ali mrtev*)
(*ideja za pravila je npr urejen seznam mej med tem, ali so živi ali mrtvi*)
(*druga ideja je samo seznam vseh vrednosti, za katere ostane živ*)
let rec notri element mnozica=
match mnozica with (*sem se hotel izogniti temu, da preverja do konca ampak ne vem kako bi to naredil efficiently, hopefully ima ocaml že implementirano,
da je    true || (KARKOLI) = true    kar pa malo dvomim...    ...*)
|h::t -> (h==element) || (notri element t)
|[] -> false

let pravilo (trenutnostanje,stsosed) (pravilazivi, pravilamrtvi)=
match trenutnostanje with
|true -> notri stsosed pravilazivi
|false -> notri stsosed pravilamrtvi

let init_matrix rows cols f = (* POZOR!!!funkcija definirana tukaj in v izlocisosede *)
  Array.init rows (fun i -> Array.init cols (fun j -> f i j))


(*let naredikorak matrikasosedov (pravilazivi, pravilamrtvi)=
let m = Array.length matrikasosedov in
let n = Array.length matrikasosedov.(0) in
init_matrix m n (fun i j -> pravilo matrikasosedov.(i).(j) (pravilazivi, pravilamrtvi))
(*funkcija init_matrix je iz izlocisosede, a bo to problem ko bom poganjal?*)

let naredimatrikovsot celamatrika matrikasosescine =
  let m = Array.length celamatrika in
  let n = Array.length celamatrika.(0) in 
  let k = Array.length matrikasosescine in 
  init_matrix m n (fun i j -> (celamatrika.(i).(j), (izlocivsotososedov celamatrika matrikasosescine k i j)))*)

(*hočem definirati funkcijo poenotenkorak, ki se bo obnašala kot funkcija naredikorak (naredimatrikovsot !matrika sosedi) pravila*)

let intofbool = function
| true -> 1
| false -> 0

let boolofint = function
| 1 -> true
| 0 -> false
| _ -> true


let dotprod matrikaa matrikab = (*kot dot product samo z booli*)
  let m = Array.length matrikaa in
  let n = Array.length matrikaa.(0) in
  let vsota = ref 0 in
  for i = 0 to m - 1 do
    for j = 0 to n - 1 do
      vsota := !vsota + (intofbool (matrikaa.(i).(j) && matrikab.(i).(j)))
    done
  done;
  !vsota


let mojmod x m = ((x mod m)+m) mod m (*če je negativno nam da iz druge strani m-ja, ker drugače nam da -2 mod 3 = -2, zdaj je pa 1*)

let izlocivsotososedov celamatrika matrikasosescine k prviindeks drugiindeks =
  let m = Array.length celamatrika in
  let n = Array.length celamatrika.(0) in
  let vsota = ref 0 in
  for i = 0 to k - 1 do
    for j = 0 to k - 1 do
      let x = mojmod (i + prviindeks - k / 2) m in
      let y = mojmod (j + drugiindeks - k / 2) n in
      let celamatrika_value = celamatrika.(x).(y) in
      let matrikasosescine_value = matrikasosescine.(i).(j) in
      vsota := !vsota + (intofbool (celamatrika_value && matrikasosescine_value))
    done
  done;
  !vsota

let poenotenkorak matrika sosedi pravila =
  let m = Array.length matrika in
  let n = Array.length matrika.(0) in
  let k = Array.length sosedi in  
  init_matrix m n (fun i j -> pravilo (matrika.(i).(j), (izlocivsotososedov matrika sosedi k i j)) pravila)

(*conway*)
let zacetnapravila = ([2;3], [3]) (*Conway*)
let zacetnik = 3
let zacetnisosedi = [|[|true; true; true|]; [|true; false; true|]; [|true; true; true|]|]
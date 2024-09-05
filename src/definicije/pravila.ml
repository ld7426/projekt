(* Datoteka s pravili za spremembo stanj *)
(*želim funkcijo, ki vzame matriko dobljeno z izločeno in na podlagi pravila določi ali bo nov element živ ali ne, mogoče modificiram matriko s številom sosedov, da vključuje podatek, ali je kvaddratek sam živ ali mrtev*)
(*ideja za pravila je npr urejen seznam mej med tem, ali so živi ali mrtvi*)
(*druga ideja je samo seznam vseh vrednosti, za katere ostane živ*)

let rec randomarray n =
  match n with
  | 0 -> [| |]
  | k -> Array.append [|Random.bool()|] (randomarray (k-1))
  
let rec randommatrika m n =
  match m with 
  | 0 -> [| |]
  | k -> Array.append [|randomarray n|] (randommatrika (k-1) n)

let (^^^) x y = x ^ " " ^ y

let izpisimatrikobool matrika =
  print_string "[|\n";
  Array.iter (fun vrstica ->
    print_string ("[|" ^ (Array.fold_left (^^^) "" @@ Array.map string_of_bool vrstica) ^"|] \n")
  ) matrika;
  print_string "|]\n"

let izpisilistint listint = (*želim da izpiše list, ne pa array*)
  List.iter (fun x -> print_int x; print_string " :: ") listint;
  print_string "[]";

let rec notri element mnozica=
  match mnozica with (*sem se hotel izogniti temu, da preverja do konca ampak ne vem kako bi to naredil efficiently, hopefully ima ocaml že implementirano,
  da je    true || (KARKOLI) = true    kar pa malo dvomim...    ..., načeloma bodo množice relativno majhne, tako da to ne bo vplivalo preveč na performance*)
  |h::t -> (h==element) || (notri element t)
  |[] -> false

let pravilo (trenutnostanje,stsosed) (pravilazivi, pravilamrtvi)= 
(*iz trenutnega stanja in pravil, ki se ločijo glede na trenutno stanje določi ali bo v naslednji iteraciji živ*)
  match trenutnostanje with
  |true -> notri stsosed pravilazivi
  |false -> notri stsosed pravilamrtvi

let init_matrix rows cols f = (* ta funkcija bi mogla bit že vključena v Array, pa ni... POZOR!!!funkcija definirana tukaj in v izlocisosede *)
  Array.init rows (fun i -> Array.init cols (fun j -> f i j))

let intofbool = function
  | true -> 1
  | false -> 0

let mojmod x m = ((x mod m)+m) mod m (*če je negativno nam da iz druge strani m-ja, ker drugače nam da -2 mod 3 = -2, zdaj je pa 1*)

let izlocivsotososedov celamatrika matrikasosescine k prviindeks drugiindeks =
  (*funkcija prešteje število sosedov celice na mestu prviindeks drugiindeks*)
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
  (*vrne matriko po eni iteraciji, naredi novo matriko, kar je verjetno slabo za spomin???*)
  (*verjetno bi lahko to izboljšal, če bi v matriko vključil še prejšnje vrednosti, sam bi bilo pa veliko dela in matrike bi bile 3D potem*)
  let m = Array.length matrika in
  let n = Array.length matrika.(0) in
  let k = Array.length sosedi in  
  init_matrix m n (fun i j -> pravilo (matrika.(i).(j), (izlocivsotososedov matrika sosedi k i j)) pravila)

(*conway pravila*)
let zacetnapravila = ([2;3], [3]) (*Conway*)
let zacetnik = 3
let zacetnisosedi = [|[|true; true; true|]; [|true; false; true|]; [|true; true; true|]|]
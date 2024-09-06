(* Datoteka s pravili za spremembo stanj *)
(*Imamo matriko sosedov, ki nam definira, katere sosede vzamemo, nato preštejemo koliko od teh je živih in imamo
shranjeno kaj se zgodi s celico glede na to, kakšno stanje je imela trenutno in koliko sosedov je živih*)


(*########################################################################################################*)
(*Pomožne funkcije brez posebne teorije, dost self-explanatory*)
let rec randomarray n =
  match n with
  | 0 -> [| |]
  | k -> Array.append [|Random.bool()|] (randomarray (k-1))
  
let rec randommatrika m n =
  match m with 
  | 0 -> [| |]
  | k -> Array.append [|randomarray n|] (randommatrika (k-1) n)


let init_matrix rows cols f = (* ta funkcija bi mogla bit že vključena v Array, pa ni... *)
Array.init rows (fun i -> Array.init cols (fun j -> f i j))

let intofbool = function
| true -> 1
| false -> 0

let mojmod x m = ((x mod m)+m) mod m (*če je negativno nam da iz druge strani m-ja, ker drugače nam da -2 mod 3 = -2, zdaj je pa 1*)

let (^^^) x y = x ^ " " ^ y

let izpisimatrikobool matrika =
  print_string "[|\n";
  Array.iter (fun vrstica ->
    print_string ("[|" ^ (Array.fold_left (^^^) "" @@ Array.map string_of_bool vrstica) ^"|] \n")
  ) matrika;
  print_string "|]\n"

let izpisilistint listint = (*želim da izpiše list, ne pa array*)
  List.iter (fun x -> print_int x; print_string " :: ") listint;
  print_string "[]"

(*let rec notri element mnozica=
(*zamenjana funkcija s funkcijo List.mem, ki ima isto funkcionalnost, ampak je verjetno boljše napisana, ker je njihova*)
  match mnozica with (*sem se hotel izogniti temu, da preverja do konca ampak ne vem kako bi to naredil efficiently, hopefully ima ocaml že implementirano,
  da je    true || (KARKOLI) = true    kar pa malo dvomim...    ..., načeloma bodo množice relativno majhne, tako da to ne bo vplivalo preveč na performance*)
  |h::t -> (h==element) || (notri element t)
  |[] -> false*)


(*########################################################################################################*)
(*Glavne funkcije, ki definirajo pravilo*)
let pravilo (trenutnostanje,stsosed) (pravilazivi, pravilamrtvi) = 
(*iz trenutnega stanja in pravil, ki se ločijo glede na trenutno stanje določi ali bo v naslednji iteraciji živ*)
  match trenutnostanje with
  |true -> List.mem stsosed pravilazivi
  |false -> List.mem stsosed pravilamrtvi


let izlocivsotososedov celamatrika matrikasosescine k prviindeks drugiindeks =
  (*funkcija prešteje število sosedov celice na mestu prviindeks drugiindeks*)
  (*Načeloma ima array.(i).(j) O(1) čas, tako da ima ta funkcija zahtevnost enako O(k^2), ampak k in število sosedov, ki jih rabimo gledati sta dosti blizu*)
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
  (*Časovna zahtevnost tega je O(m*n)*O(izlocivsotososedov) = O(m*n*k^2), če rečemo da so pravila konstantna*)
  let m = Array.length matrika in
  let n = Array.length matrika.(0) in
  let k = Array.length sosedi in  
  init_matrix m n (fun i j -> pravilo (matrika.(i).(j), (izlocivsotososedov matrika sosedi k i j)) pravila)


(*########################################################################################################*)
(*začetna conway pravila*)
let zacetnapravila = ([2;3], [3]) (*Conway*)
let zacetnik = 3
let zacetnisosedi = [|[|true; true; true|]; [|true; false; true|]; [|true; true; true|]|]
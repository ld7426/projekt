(* tu not bodo funkcije, ki nam iz podane matrike (ne vem še kakšna bo) izločijo sosede v obliki kot sem jo določil 
treba bo prvo določiti meje sistema ali pač da je neskončen in da se bo torej dodajalo stvari

mogoče najprej rečemo, da so periodični boundary conditioni, je najlažje

trenutno nastavljeno na obliko

     j-2,j-1,j,j+1,j+2, j+3
	  |1| |2|	i-1
	|3|4|x|5|6|   vrstica i
	  |7| |8| |9|   i+1
	stolpec j

*)
let rec randomarray n =
match n with
| 0 -> [| |]
| k -> Array.append [|Random.bool()|] (randomarray (k-1))

let rec randommatrika m n =
match m with 
| 0 -> [| |]
| k -> Array.append [|randomarray n|] (randommatrika (k-1) n)

let (^^^) x y = x ^ " " ^ y

let izpisimatrikoint matrika =
 Array.map (fun vrstica -> print_string ((Array.fold_left (^^^) "" @@ Array.map string_of_int vrstica) ^ "\n")) matrika

let mapmatrix f mat =
Array.map (fun vrstica -> Array.map f vrstica) mat

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

let init_matrix rows cols f = (*ta funkcija bi mogla bit že definirana je pisal na spletu??? POZOR, definirana tukaj in v pravila.ml *)
  Array.init rows (fun i -> Array.init cols (fun j -> f i j))


let mojmod x m = ((x mod m)+m) mod m (*če je negativno nam da iz druge strani m-ja, ker drugače nam da -2 mod 3 = -2, zdaj je pa 1*)
  
  
let izlocisosedskomatriko celamatrika k prviindeks drugiindeks = (* dobimo matriko sosedov kvadrata i j *)
let m = Array.length celamatrika in
let n = Array.length celamatrika.(0) in
init_matrix k k (fun i j -> celamatrika.(mojmod (i + prviindeks -k/2) m).(mojmod (j + drugiindeks -k/2) n))(*ker matrika sosedov je 2l+1x2l+1 =kxk, indekse pa rabim klicati pravilno*)

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



init_matrix k k (fun i j -> celamatrika.(mojmod (i + prviindeks -k/2) m).(mojmod (j + drugiindeks -k/2) n))

let naredimatrikovsot celamatrika matrikasosescine =
let m = Array.length celamatrika in
let n = Array.length celamatrika.(0) in 
let k = Array.length matrikasosescine in 
init_matrix m n (fun i j -> (celamatrika.(i).(j), (izlocivsotososedov celamatrika matrikasosescine k i j)))

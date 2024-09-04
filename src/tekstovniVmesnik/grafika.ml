(*#require "graphics"*)
open Graphics
open Unix
open Definicije
open Pravila
open Izlocisosede
(*open Brr*)

(*let praznamatrika m n =
  Array.make m (Array.make n false) *)

(*let polnamatrika m n =
  Array.make m (Array.make n true)*)

let rec randomarray n =
match n with
| 0 -> [| |]
| k -> Array.append [|Random.bool()|] (randomarray (k-1))

let rec randommatrika m n =
match m with 
| 0 -> [| |]
| k -> Array.append [|randomarray n|] (randommatrika (k-1) n)

let naredi_graf matrika =
let m = Array.length matrika in
let n = Array.length matrika.(0) in
let stranicakvadrata = min (1024/n) (512/m) in (*hočem da je maks 1024x712, da gre lepo na majhne resolucije kot je moja*)
let sirina = n*stranicakvadrata in
let visina = m*stranicakvadrata + 200 in
let zacetnistring = " "^(string_of_int sirina) ^ "x" ^ (string_of_int visina) in
Graphics.open_graph zacetnistring

let zaprigraf = Graphics.close_graph

(*
(*pazi, ker fill_rect gleda od spodaj gor namesto od zgoraj dol*)
let rec narisigrafpovrstici vrstica i j stranica= (*tukaj je pomembno, da je vrstica list in ne array!!!*)
let barva = point_color (i*stranica) (j*stranica + 200) in
if barva = white then match vrstica with (*white je mrtev, torej false*)
  | true :: tail -> fill_rect (i*stranica) (j*stranica + 200) stranica stranica; narisigrafpovrstici tail (i+1) j stranica
  | false :: tail -> narisigrafpovrstici tail (i+1) j stranica
  | _ -> ()
else match vrstica with
  | true :: tail -> narisigrafpovrstici tail (i+1) j stranica
  | false :: tail -> set_color white; fill_rect (i*stranica) (j*stranica + 200) stranica stranica; set_color black; narisigrafpovrstici tail (i+1) j stranica
  | _ -> ()


*)
let rec narisigrafpovrstici vrstica i j stranica = 
  let barva = point_color (i * stranica) (j * stranica + 200) in
  if barva == white then 
    match vrstica with
    | true :: tail -> 
        fill_rect (i * stranica) (j * stranica + 200) stranica stranica; 
        narisigrafpovrstici tail (i + 1) j stranica
    | false :: tail -> 
        narisigrafpovrstici tail (i + 1) j stranica
    | _ -> ()
  else 
    match vrstica with
    | true :: tail -> 
        narisigrafpovrstici tail (i + 1) j stranica
    | false :: tail -> 
        set_color white; 
        fill_rect (i * stranica) (j * stranica + 200) stranica stranica; 
        set_color black; 
        narisigrafpovrstici tail (i + 1) j stranica
    | _ -> ()



(*let rec narisigrafpovrstici vrstica i j stranica= (*tukaj je pomembno, da je vrstica list in ne array!!!*)
match vrstica with
| true :: tail -> fill_rect (i*stranica) (j*stranica + 200) stranica stranica; narisigrafpovrstici tail (i+1) j stranica
| false :: tail -> set_color white; fill_rect (i*stranica) (j*stranica + 200) stranica stranica; set_color black; narisigrafpovrstici tail (i+1) j stranica
| _ -> ()
*)



let rec obrniseznam seznam =(*hkrati spremeni elemente iz Arraya v list*)
match seznam with
| head :: tail -> (obrniseznam tail) @ [Array.to_list head]
| [] -> []

let rec pomoznanarisiseznam seznam i j stranica= (*Sprejme matriko v obliki list list in indeksa i in j*)
match seznam with
| head :: tail -> narisigrafpovrstici head i j stranica; pomoznanarisiseznam tail i (j+1) stranica
| [] -> ()



let naredi_gumb x y width height label =
  set_color green;
  fill_rect x y width height;
  set_color black;
  moveto (x + 10) (y + (height / 2) - 5);
  draw_string label

(*preveri, če je klik v gumbu*)
let is_inside x y bx by bwidth bheight =
  x >= bx && x <= bx + bwidth && y >= by && y <= by + bheight

(* obrni element na poziciji m n*)
let spremeni_matriko matrika m n =
  matrika.(m).(n) <- not matrika.(m).(n)

let narisimatriko matrika =
let stranica = min (1024/(Array.length matrika.(0))) (512/(Array.length matrika )) in
let seznam = obrniseznam (Array.to_list matrika) in 
pomoznanarisiseznam seznam 0 0 stranica;
naredi_gumb 100 75 100 50 "Naprej"; naredi_gumb 250 75 100 50 "Nastavi"; naredi_gumb 400 75 100 50 "Izhod"

let spremeniprvomatriko prvamatrika drugamatrika = 
  for i = 0 to Array.length prvamatrika - 1 do
    for j = 0 to Array.length prvamatrika - 1 do
      prvamatrika.(i).(j) <- drugamatrika.(i).(j)
    done
  done

let korakmatrike matrika =
  spremeniprvomatriko matrika (korak izlocisosede matrika)

let rec rocnasprememba matrika =
let stranica = min (1024/(Array.length matrika.(0))) (512/(Array.length matrika )) in
let seznam = obrniseznam (Array.to_list matrika) in
pomoznanarisiseznam seznam 0 0 stranica;
naredi_gumb 400 75 100 50 "Koncano";
let status = wait_next_event [Button_down] in
let xm = (status.mouse_x)/(stranica) in
let ym = (status.mouse_y-200+stranica)/(stranica)-1 in (*če bi dal samo (status-200)/stranica se npr -10/stranica zaokroži lahko na 0*)
if ym<0 then () (*izhod iz spremembe, ker je klik izven polj -> ni usklajeno z GUI ampak jbg, program se pa sesuje če nekdo ročno poveča okno in klikne na desni ven :D*)
  (*if is_inside status.mouse_x status.mouse_y 400 75 100 50 then ()
  else rocnasprememba matrika*)
else 
  begin
    spremeni_matriko matrika (Array.length matrika - ym -1) xm;
    rocnasprememba matrika
  end








let _ =
  let visina = read_int () in
  let sirina = read_int () in
  let nekamatrika = randommatrika visina sirina in
  naredi_graf nekamatrika;
  narisimatriko nekamatrika;
  
(*Graphics.set_font "./Trueno-75PE.otf"; ni mi ratalo uporabiti fonta, ki bi supportal čšž*)
let rec event_loop () =
  let status = wait_next_event [Button_down; Key_pressed] in
  if status.keypressed && status.key = '\027' then
    zaprigraf ()
  else
    begin
      if is_inside status.mouse_x status.mouse_y 100 75 100 50 then
        begin
          korakmatrike nekamatrika;
          narisimatriko nekamatrika;
          event_loop ()
        end
      else if is_inside status.mouse_x status.mouse_y 250 75 100 50 then
        begin
          Graphics.clear_graph();
          rocnasprememba nekamatrika;
          Graphics.clear_graph();
          narisimatriko nekamatrika;
          event_loop ()
        end
      else if is_inside status.mouse_x status.mouse_y 450 75 100 50 then
        begin
          zaprigraf ();
        end
      else
        begin
          narisimatriko nekamatrika;
          event_loop ()
        end
    end
in
event_loop ();



  sleep 1;
  zaprigraf ()

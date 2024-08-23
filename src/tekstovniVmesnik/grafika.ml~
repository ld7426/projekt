(*#require "graphics"*)
open Graphics
open Unix
open Definicije
open Pravila
open Izlocisosede
(*open Brr*)



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
let sirina = n*100 in
let visina = (m+2)*100 in
let zacetnistring = " "^(string_of_int sirina) ^ "x" ^ (string_of_int visina) in
Graphics.open_graph zacetnistring

let zaprigraf = Graphics.close_graph

(*pazi, ker fill_rect gleda od spodaj gor namesto od zgoraj dol*)
let rec narisigrafpovrstici vrstica i j= (*tukaj je pomembno, da je vrstica list in ne array!!!*)
match vrstica with
| true::[] -> fill_rect (i*100) ((j+2)*100) 100 100;
| true :: tail -> Graphics.fill_rect (i*100) ((j+2)*100) 100 100; narisigrafpovrstici tail (i+1) j
| false :: tail -> narisigrafpovrstici tail (i+1) j
| _ -> ()


let rec obrniseznam seznam =(*hkrati spremeni emelente iz Arraya v list*)
match seznam with
| head :: tail -> (obrniseznam tail) @ [Array.to_list head]
| [] -> []

let rec pomoznanarisiseznam seznam i j= (*Sprejme matriko v obliki list list in indeksa i in j*)
match seznam with
| head :: tail -> narisigrafpovrstici head i j; pomoznanarisiseznam tail i (j+1)
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
let seznam = obrniseznam (Array.to_list matrika) in
Graphics.clear_graph(); pomoznanarisiseznam seznam 0 0;
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
let seznam = obrniseznam (Array.to_list matrika) in
Graphics.clear_graph(); pomoznanarisiseznam seznam 0 0;
naredi_gumb 400 75 100 50 "Koncano";
let status = wait_next_event [Button_down] in
let xm = (status.mouse_x)/(100) in
let ym = (status.mouse_y)/(100)-2 in
if ym<0 then ()
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
          rocnasprememba nekamatrika;
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

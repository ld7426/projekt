(*#require "graphics"*)
open Graphics
open Unix
open Definicije
open Pravila
open Izlocisosede
(*open Brr*)

(*nigga pretepel te bom če ne boš commital*)
let praznamatrika m n =
  Array.make m (Array.make n false)

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
let stranicakvadrata = min (1024/n) (450/m) in (*hočem da je maks 1024x712, da gre lepo na majhne resolucije kot je moja*)
let sirina = (max (n*stranicakvadrata) 420) in
let visina = m*stranicakvadrata + 200 in
let zacetnistring = " "^(string_of_int sirina) ^ "x" ^ (string_of_int visina) in
Graphics.open_graph zacetnistring;
auto_synchronize false

let zaprigraf = Graphics.close_graph

(*definicije gumbov*)
type gumb = {
  x: int; 
  y: int; 
  width: int; 
  height: int; 
  label: string}

(*gumbi na zacetnem*)
let gumbnaprej = {x = 25; y = 25; width = 100; height = 50; label = "Naprej"}
let gumbnastavi = {x = 150; y = 25; width = 100; height = 50; label = "Nastavi"}
let gumbsosedska = {x = 25; y = 125; width = 100; height = 50; label = "Sosedje"}
let gumbizhod = {x = 150; y = 125; width = 100; height = 50; label = "Izhod"}


(*gumbi na nastavi*)
let gumbprazna = {x = 25; y = 25; width = 100; height = 50; label = "Prazna"}
let gumbpolna = {x = 150; y = 25; width = 100; height = 50; label = "Polna"}
let gumbkonc = {x = 25; y = 125; width = 100; height = 50; label = "Koncano"}



(*naredi gumb z danimi koordinatami in napisom*)

let naredi_gumb gumbi =
  set_color green;
  fill_rect gumbi.x gumbi.y gumbi.width gumbi.height;
  set_color black;
  moveto (gumbi.x + 10) (gumbi.y + (gumbi.height / 2) - 5);
  draw_string gumbi.label

(*preveri, če je klik v gumbu*)
let is_inside x y gumbi=
  x >= gumbi.x && x <= gumbi.x + gumbi.width && y >= gumbi.y && y <= gumbi.y + gumbi.height

(* obrni element na poziciji m n*)
let spremeni_matriko matrika m n =
  matrika.(m).(n) <- not matrika.(m).(n)

let izrisisamomatriko matrika stranica=
for i = 0 to Array.length matrika.(0) - 1 do
  for j = 0 to Array.length matrika - 1 do
    let barva = point_color (i * stranica+1) (j * stranica + 200+1) in (*ali je tale point_color ful počasen? *)
    let pravastranica = stranica - 1 in (*da se ne prekrivajo kvadrati, ker fill_rect actually naredi (n+1)*(n+1) kvadrat ...*)
    if barva = white then 
      match matrika.(Array.length matrika - j -1).(i) with
      |true -> fill_rect (i * stranica) (j * stranica + 200) pravastranica pravastranica
      |false -> ()
    else 
      match matrika.(Array.length matrika - j -1).(i) with
      |true -> ()
      |false -> set_color white; fill_rect (i * stranica) (j * stranica + 200) pravastranica pravastranica; set_color black
  done
done

let narisimatriko matrika =
let stranica = min (1024/(Array.length matrika.(0))) (450/(Array.length matrika )) in
izrisisamomatriko matrika stranica;
naredi_gumb gumbnaprej; naredi_gumb gumbnastavi; naredi_gumb gumbizhod; naredi_gumb gumbsosedska;
synchronize ()

let spremeniprvomatriko prvamatrika drugamatrika = 
  for i = 0 to Array.length prvamatrika - 1 do
    for j = 0 to Array.length prvamatrika.(0) - 1 do
      prvamatrika.(i).(j) <- drugamatrika.(i).(j)
    done
  done

let korakmatrike matrika sosedi pravila =
  spremeniprvomatriko matrika (naredikorak (naredimatrikovsot matrika sosedi) pravila)

let rec rocnasprememba matrika =
let stranica = min (1024/(Array.length matrika.(0))) (450/(Array.length matrika )) in
(*let seznam = obrniseznam (Array.to_list matrika) in
pomoznanarisiseznam seznam 0 0 stranica;*)
naredi_gumb gumbprazna; naredi_gumb gumbpolna; naredi_gumb gumbkonc;
synchronize ();
let status = wait_next_event [Button_down] in
let xm = (status.mouse_x)/(stranica) in
let ym = (status.mouse_y-200+stranica)/(stranica)-1 in (*če bi dal samo (status-200)/stranica se npr -10/stranica zaokroži lahko na 0*)
if ym<0 then (*izhod iz spremembe, ker je klik izven polj -> ni usklajeno z GUI ampak to mi je boljše, da lahko kjerkoli spodaj kliknem, program se pa sesuje če nekdo ročno poveča okno in klikne na desni ven :D*)
  (*if is_inside status.mouse_x status.mouse_y 400 75 100 50 then ()
  else rocnasprememba matrika*)
  begin
    if is_inside status.mouse_x status.mouse_y gumbprazna then
      begin
        for i = 0 to Array.length matrika - 1 do
          for j = 0 to Array.length matrika.(0) - 1 do
            matrika.(i).(j) <- false
          done
        done;
        set_color white;
        fill_rect 0 200 ((Array.length matrika.(0)) * stranica - 1) ((Array.length matrika) * stranica - 1);
        set_color black;
        synchronize ();
        rocnasprememba matrika
      end
    else if is_inside status.mouse_x status.mouse_y gumbpolna then
      begin
        for i = 0 to Array.length matrika - 1 do
          for j = 0 to Array.length matrika.(0) - 1 do
            matrika.(i).(j) <- true
          done
        done;
        fill_rect 0 200 ((Array.length matrika.(0)) * stranica - 1) ((Array.length matrika) * stranica - 1);
        synchronize ();
        rocnasprememba matrika
      end
    else if is_inside status.mouse_x status.mouse_y gumbkonc then
      ()
    else
      rocnasprememba matrika
  end
else
  begin
    spremeni_matriko matrika (Array.length matrika - ym - 1) xm;
    if matrika.(Array.length matrika - ym - 1).(xm) then set_color black
    else set_color white;
    fill_rect (xm * stranica) (ym * stranica + 200) (stranica - 1) (stranica - 1);
    set_color black;
    synchronize ();
    rocnasprememba matrika
  end
  
let rec dodajkseznamu seznam =
  let x = read_int () in
  if x = -1 then seznam
  else dodajkseznamu (x::seznam)







let _ =
  let k =  ref zacetnik in
  let sosedi = ref zacetnisosedi in
  let pravila = ref zacetnapravila in
  let visina = read_int () in
  let sirina = read_int () in
  let stranica = min (1024/(sirina)) (450/(visina)) in
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
      if is_inside status.mouse_x status.mouse_y gumbnaprej then
        begin
          korakmatrike nekamatrika !sosedi !pravila;
          narisimatriko nekamatrika;
          event_loop ()
        end
      else if is_inside status.mouse_x status.mouse_y gumbnastavi then
        begin
          Graphics.clear_graph();
          izrisisamomatriko nekamatrika stranica;
          rocnasprememba nekamatrika;
          Graphics.clear_graph();
          narisimatriko nekamatrika;
          event_loop ()
        end
      else if is_inside status.mouse_x status.mouse_y gumbsosedska then
        begin
          zaprigraf ();
          k := read_int ();
          k := (!k/2)*2 + 1; (*da je k lih*)
          sosedi := praznamatrika !k !k;
          naredi_graf !sosedi;
          izrisisamomatriko !sosedi (450/(!k));
          rocnasprememba !sosedi; (*koncana sprememba sosedov, zdaj je treba se pravila*)
          zaprigraf ();
          print_string "Vnesena matrika sosedov: ";
          izpisimatrikobool !sosedi;
          print_string "Vnesi pravila za žive celice: ";
          let pravilazivi = dodajkseznamu [] in
          print_string "Vnesena pravila za žive celice: ";
          izpisilistint pravilazivi;
          print_string "Vnesi pravila za mrtve celice: ";
          let pravilamrtvi = dodajkseznamu [] in
          print_string "Vnesena pravila za mrtve celice: ";
          izpisilistint pravilamrtvi;
          pravila := (pravilazivi, pravilamrtvi);
          naredi_graf nekamatrika;
          narisimatriko nekamatrika;
          event_loop ()
        end
      else if is_inside status.mouse_x status.mouse_y gumbizhod then
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

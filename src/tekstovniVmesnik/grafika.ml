(*#require "graphics"*)
open Graphics
open Unix
open Definicije
open Pravila
(*########################################################################################################*)
(*definicija velikosti zaslona, jaz sem delal na 1080x768, tako da sem rekel, da lahko riše le majhne zaslone*)
(*globalne, ki ostanejo konstantne pri izvajanju*)
let sirinazaslona = 1080 in
let dejsirina = sirinazaslona -60

let visinazaslona = 768 in
let dejvisina = visinazaslona - 280

(*########################################################################################################*)

(*###*)
(*definicija inicializacije matrik*)
let praznamatrika m n =
  Array.make_matrix m n false

let rec randomarray n =
match n with
| 0 -> [| |]
| k -> Array.append [|Random.bool()|] (randomarray (k-1))

let rec randommatrika m n =
match m with 
| 0 -> [| |]
| k -> Array.append [|randomarray n|] (randommatrika (k-1) n)

let rec dodajkseznamu seznam =
  let x = read_int () in
  if x = -1 then seznam
  else dodajkseznamu (x::seznam)


(*########################################################################################################*)
(*glavne grafične stvari za inicializacijo*)
let naredi_graf matrika =
let m = Array.length matrika in
let n = Array.length matrika.(0) in
let stranicakvadrata = min (dejsirina/n) (dejvisina/m) in (*hočem da je maks dejsirinax712, da gre lepo na majhne resolucije kot je moja*)
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

(* negiraj na poziciji m n*)
let spremeni_matriko matrika m n =
  matrika.(m).(n) <- not matrika.(m).(n)


(*########################################################################################################*)
(*definicija izrisa matrike in glavnih lastnosti grafike*)
let izrisisamomatriko matrika stranica=
set_color white;
fill_rect 0 200 ((Array.length matrika.(0)) * stranica - 1) ((Array.length matrika) * stranica - 1);
set_color black; (*letsgo, to da sem dal stran point_color pa zej barvam sam črne je ene desetkrat pohitrilo benchmark 10x100x200*)
for i = 0 to Array.length matrika.(0) - 1 do
  for j = 0 to Array.length matrika - 1 do
    let pravastranica = stranica - 1 in (*da se ne prekrivajo kvadrati, ker fill_rect actually naredi (n+1)*(n+1) kvadrat ...*)
      match matrika.(Array.length matrika - j -1).(i) with
      |true -> fill_rect (i * stranica) (j * stranica + 200) pravastranica pravastranica
      |false -> ()
  done
done

let narisimatriko matrika =
let stranica = min (dejsirina/(Array.length matrika.(0))) (dejvisina/(Array.length matrika )) in
izrisisamomatriko matrika stranica;
naredi_gumb gumbnaprej; naredi_gumb gumbnastavi; naredi_gumb gumbizhod; naredi_gumb gumbsosedska;
synchronize ()

(*########################################################################################################*)
(*definicija ročne spremembe matrike, tale del kode je kr ogaben, ampak ima pač kar veliko case-ov*)
(* je pa tale del precej hiter, tako da ne vem če bi ga optimiziral*)

let rec rocnasprememba matrika =
let stranica = min (dejsirina/(Array.length matrika.(0))) (dejvisina/(Array.length matrika )) in
naredi_gumb gumbprazna; naredi_gumb gumbpolna; naredi_gumb gumbkonc;
synchronize ();
let status = wait_next_event [Button_down] in
let xm = (status.mouse_x)/(stranica) in (* program se sesuje če nekdo ročno poveča okno in klikne na desni ven :D*)
let ym = (status.mouse_y-200+stranica)/(stranica)-1 in (*če bi dal samo (status-200)/stranica se npr -10/stranica zaokroži lahko na 0*)
if ym<0 then 
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
  
(*########################################################################################################*)
(*Izgleda kot nedolžna funkcija ampak samo zadaj je cel pravila.ml*)
let korakmatrike matrika sosedi pravila =
  matrika := poenotenkorak !matrika sosedi pravila




(*########################################################################################################*)
(*########################################################################################################*)
(*########################################################################################################*)
(*ZAČETEK MAIN FUNKCIJE*)

let _ =
  print_string "Vnesi št. korakov pred vsakim prikazom: ";
  let stkorakov = read_int () in
  let k =  ref zacetnik in
  let sosedi = ref zacetnisosedi in
  let pravila = ref zacetnapravila in
  print_string "\nVnesi št. vrstic matrike: ";
  let visina = read_int () in
  print_string "\nVnesi št. stolpcev matrike: ";
  let sirina = read_int () in
  let stranica = min (dejsirina/(sirina)) (dejvisina/(visina)) in
  let nekamatrika = ref (randommatrika visina sirina) in
  naredi_graf !nekamatrika; (*inicializacija grafike*)
  narisimatriko !nekamatrika;
  
(*Graphics.set_font "./Trueno-75PE.otf"; ni mi ratalo uporabiti fonta, ki bi supportal čšž za napise na grafiki*)
let rec event_loop () = (*glavni loop za vse stvari*)
  let status = wait_next_event [Button_down; Key_pressed] in
  if status.keypressed && status.key = '\027' then (*ESC zapre graf*)
    zaprigraf ()
  else
    begin
      if is_inside status.mouse_x status.mouse_y gumbnaprej then (*dejanski korak/naslednja iteracija*)
        begin
          let rec veckorakov = function
          |0 -> ()
          |n -> korakmatrike nekamatrika !sosedi !pravila; veckorakov (n-1)
          in
          veckorakov stkorakov;
          
          narisimatriko !nekamatrika;
          event_loop ()
        end
      else if is_inside status.mouse_x status.mouse_y gumbnastavi then (*ročna nastavitev*)
        begin
          Graphics.clear_graph();
          izrisisamomatriko !nekamatrika stranica;
          rocnasprememba !nekamatrika;
          Graphics.clear_graph();
          narisimatriko !nekamatrika;
          event_loop ()
        end
      else if is_inside status.mouse_x status.mouse_y gumbsosedska then (*nastavitev vseh stvari glede sosedov*)
        begin
          zaprigraf ();
          print_string "\nVnesi velikost matrike sosedov: ";
          k := read_int ();
          k := (!k/2)*2 + 1; (*da je k lih*)
          sosedi := praznamatrika !k !k;
          naredi_graf !sosedi;
          izrisisamomatriko !sosedi (dejvisina/(!k));
          rocnasprememba !sosedi; (*koncana sprememba sosedov, zdaj je treba se pravila*)
          zaprigraf ();
          print_string "\nVnešena matrika sosedov: ";
          izpisimatrikobool !sosedi;
          print_string "\nVnesi pravila za žive celice: "; (*Pravilo je samo seznam števil, in se preveri, ali je v seznamu št sosedov*)
          let pravilazivi = dodajkseznamu [] in
          print_string "\nVnešena pravila za žive celice: ";
          izpisilistint pravilazivi;
          print_string "\nVnesi pravila za mrtve celice: ";
          let pravilamrtvi = dodajkseznamu [] in
          print_string "\nVnešena pravila za mrtve celice: ";
          izpisilistint pravilamrtvi;
          pravila := (pravilazivi, pravilamrtvi);
          naredi_graf !nekamatrika;
          narisimatriko !nekamatrika;
          event_loop ()
        end
      else if is_inside status.mouse_x status.mouse_y gumbizhod then (*zapri graf*)
        begin
          zaprigraf ();
        end
      else (*če klikne kamorkoli drugam potem se samo še enkrat ponovi loop*)
        begin
          event_loop ()
        end
    end
in
event_loop ();



  sleep 1;
  zaprigraf ()

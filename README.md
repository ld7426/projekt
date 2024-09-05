


# Celični avtomat

Glavna datoteka je grafika.ml, pomožni sta pravila.ml in izlocisosede.ml. Na začetku datoteka vpraša za višino in širino, čeprav ni izpisanega stringa za to
mogoče bi še grafiko dal posebej da bo main lepo kratek in naredil .mli datoteke za vsako stvar, idk

TODO: ugotoviti, zakaj širina večja od *višine* ne dela, preveriti, če je s pravili vse v redu, da so res periodični boundary conditioni DONE


TODO: Narediti customizable pravila - dodaten gumb, ki bo zaprl graf in nas vprašal za velikost n, potem se odpre nazaj grafika in nam pokaže 2n+1 veliko tabelo, ki jo obkljukamo/odkljukamo, nato pa izberemo meje, kdaj živa umre in mrtva oživi
Pravilo bo simple, da se samo prešteje število živih sosedov in glede na to sklepa, ali umre ali živi, bom pa dopustil uporabo zapletenih okolic. DONE

TODO: Spremeniti velikost celic, da so pri velikih tabelah posamezni kvadratki majhni, ker ne sme biti fiksna velikost 100 DONE
TODO: Izboljšati posodabljanje celic, da posodabljamo res samo tiste celice, ki se spremenijo, drugače se mi zdi, da tole vzame preveč časa in zgleda glitchy DONE

TODO naredi class gumbov, s katerimi bo lažje delati, da preverim, ali sem kliknil nanje DONE

TODO: dodaj možnost, da se matrika nastavi na same mrtve/žive, to je izi en gumb DONE

TODO: Ugotoviti zakaj je tako počasno??? Risanje sem zej kar pohitril, še posebej za večinoma mrtve matrike, zej pa lahko probam pohitriti še korak
TODO: Naredi bolj user friendly, dodaj izpise, označi malo 

poganjanje: dune build
./grafika.exe
(vnesi višino)
(vnesi širino)
Zaenkrat so zraven še vse profesorjeve datoteke, da si lahko pomagam z njimi, na koncu jih moram odstraniti

# Končni avtomati

Projekt vsebuje implementacijo končnih avtomatov, enega najpreprostejših računskih modelov, ter njihovo uporabo pri karakterizaciji nizov. Končni avtomat začne v enem izmed možnih stanj, nato pa glede na trenutno stanje in trenutni simbol preide v neko novo stanje. Če ob pregledu celotnega niza konča v enem od sprejemnih stanj, je niz sprejet, sicer pa ni.

Za tekoči primer si oglejmo avtomat, ki sprejema nize, sestavljene iz ničel in enic, v katerih da vsota enic pri deljenju s 3 ostanek 1. Tak avtomat predstavimo z naslednjim diagramom, na katerem je začetno stanje označeno s puščico, sprejemna stanja pa so dvojno obkrožena.

TODO

## Matematična definicija

Končni avtomat je definiran kot nabor $(\Sigma, Q, q_0, F, \delta)$, kjer so:

- $\Sigma$ množica simbolov oz. abeceda,
- $Q$ množica stanj,
- $q_0 \in Q$ začetno stanje,
- $F \subseteq Q$ množica sprejemnih stanj in
- $\delta : Q \times \Sigma \to Q$ prehodna funkcija.

Na primer, zgornji končni avtomat predstavimo z naborom $(\{0, 1\}, \{q_0, q_1, q_2\}, q_0, \{q_1\}, \delta)$, kjer je $\delta$ podana z naslednjo tabelo:

| $\delta$ | `0`   | `1`   |
| -------- | ----- | ----- |
| $q_0$    | $q_0$ | $q_1$ |
| $q_1$    | $q_2$ | $q_0$ |
| $q_2$    | $q_1$ | $q_2$ |

## Navodila za uporabo

Ker projekt služi kot osnova za večje projekte, so njegove lastnosti zelo okrnjene. Konkretno implementacija omogoča samo zgoraj omenjeni končni avtomat. Na voljo sta dva vmesnika, tekstovni in grafični. Oba prevedemo z ukazom `dune build`, ki v korenskem imeniku ustvari datoteko `tekstovniVmesnik.exe`, v imeniku `html` pa JavaScript datoteko `spletniVmesnik.bc.js`, ki se izvede, ko v brskalniku odpremo `spletniVmesnik.html`.

Če OCamla nimate nameščenega, lahko še vedno preizkusite tekstovni vmesnik prek ene od spletnih implementacij OCamla, najbolje <http://ocaml.besson.link/>, ki podpira branje s konzole. V tem primeru si na vrh datoteke `tekstovniVmesnik.ml` dodajte še vrstice

```ocaml
module Avtomat = struct
    (* celotna vsebina datoteke avtomat.ml *)
end
```

### Tekstovni vmesnik

TODO

### Spletni vmesnik

TODO

## Implementacija

### Struktura datotek

TODO

### `avtomat.ml`

TODO

### `model.ml`

TODO

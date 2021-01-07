# # Pakiety do wszystkich zadań
using CategoricalArrays
using Statistics
using StatsBase
using DataFrames
using CSV
using FreqTables
using StringEncodings
using Plots
using TexTables
using LinearAlgebra
using Literate # Literate.markdown("rozdzial2/rozdzial-2.jl", "rozdzial2/"; documenter=false, execute=true)

# # R Zadanie 2.1

# Odczytaj ramkę danych z zadania 1.13. Następnie zamień dane liczbowe z kolumny Wiek na zmienną czynnikową, dzieląc pacjentki na 3 grupy: o wieku do 45 lat, o wieku powyżej 55 lat i o wieku pośrednim. Poziomy tej zmiennej powinny nazywać się następująco: `"wiek <45", "45<= wiek <= 55", "wiek >55"`. Następnie wyświetl macierz kontyngencji dla tej zmiennej i dla pary zmiennych wieku oraz dla płci. Dodaj do macierzy sumy brzegowe. Wyświetl płaską macierz kontyngencji dla trójki zmiennych czynnikowych, dwóch powyższych i jeszcze zmiennej `WIT`.

daneBT = CSV.read(open(read, "rozdzial1/daneBioTech", enc"ISO-8859-2"), DataFrame; 
                  delim=';', decimal=',', header=true, normalizenames = true)

daneBT.Wiek_poziomy = cut(daneBT.Wiek, [0, 45, 55.5, maximum(daneBT.Wiek)], 
                          labels = ["wiek <45", "45<= wiek <=55", "wiek > 55"], 
                          extend=true)

# pierwsza tabela                          
freqtable(daneBT, :Wiek_poziomy)
# druga tabela                          
freqtable(daneBT, :Wiek_poziomy, :Płeć_K_0_M_1)
# trzecia tabela
freqtable(daneBT, :Wiek_poziomy, :Płeć_K_0_M_1, :WIT) 

# niestety, nie ma funkcji typu `addmargins` czy ftable (flat table)

# # RR Zadanie 2.2
# Pod adresem http://www.biecek.pl/R/dane/imieniny.txt znajduje się plik tekstowy z imionami i datami imienin dla kolejnych imion. Plik jest w dosyć kłopotliwym formacie, mianowicie w każdym wierszu w pierwszej pozycji znajduje się imię, a po nim występują daty imienin. Wszystkie te pola rozdzielone są spacją. Ponieważ jednak różne imiona mają różne liczby imienin dane te nie są w postaci tabelarycznej. Odczytaj dane tak, by każdy wiersz był jednym elementem (można np. za separator wskazać ; nie występuje on w tym pliku, cała linia zostanie więc traktowana jako jeden element). Sprawdź ile imion znajduje się w tym pliku z danymi.

download("http://www.biecek.pl/R/dane/imieniny.txt", "rozdzial2/imieniny.txt")
linie = readlines("rozdzial2/imieniny.txt", enc"ISO-8859-2");
linie[1:10]

# # RRR Zadanie 2.3

# Po odczytaniu danych z zadania 2.2 użyj `strsplit()` i `sapply()`, by z odczytanych danych wydobyć tylko informacje o imionach. Zlicz liczby znaków w kolejnych imionach i wyznacz macierz kontyngencji opisującą ile imion ma określoną długość. Sprawdź, które imię ma najwięcej znaków i które imiona mają najmniej znaków. Większość imion żeńskich kończy się literą ‘a’, wykorzystując tę informację zlicz liczbę żeńskich imion. Sprawdź ile liter rozpoczyna się literą A, ile B, ile C itp. Sprawdź, które imiona kończą się suffixem anna. Polskie litery występujące w imionach zamień na odpowiedniki łacińskie, np. ą na a, ź na z itp. Sprawdź, ile imion zawierało polskie litery.

imiona = map(x -> x[1], split.(linie, " "))
dlugosciImion = length.(imiona);
# dlugosci imion
freqtable(dlugosciImion)
# ktore najkrotsze
imiona[dlugosciImion .== minimum(dlugosciImion)]
# ktore najdluzsze
imiona[dlugosciImion .== maximum(dlugosciImion)]
# ktore konczą się na a
imiona[contains.(imiona, r"a$")] |> length
# pierwsze litery
SubString.(imiona, 1, 1) |> freqtable
# które zawierają anna
imiona[contains.(imiona, r"anna$")]
# zawierają polskie znaki
imiona[ contains.(imiona, r"[ąęśćłńóźżĄĘŚĆŁŃÓŹŻ]{1,}")]

# # RR Zadanie 2.4

# Po odczytaniu danych z powyższego zadania sprawdź, kto ma imieniny 30 października. Wyświetl te imiona w porządku leksykograficznym. Sprawdź, które imię ma najczęściej imieniny. Sprawdź, w którym dniu roku najwięcej imion ma imieniny. Sprawdź, w którym dniu miesiąca a następnie, w którym miesiącu najwięcej imion ma imieniny.

# Na bazie wszystkich imion zrób analizę używalności poszczególnych liter. Która litera jest najpopularniejsza? Dlaczego?

# które imiona obchodzą imieniny 30.10
imiona[contains.(linie, r"( 30.X$| 30.X )")] |> sort
linie_splitted = split.(linie, " ");
# które imię ma najwięcej imien
linie[linie_splitted .|>  length |> argmax]
linie_splitted_full = map(x -> x[2:end], linie_splitted) |> (x -> vcat(x...)) .|> string ;
# w który dzień jest najwięcej imion
linie_splitted_full |> countmap |> argmax
dniImienin = [i.match for i in filter(!isnothing,match.(r"\d{1,2}", linie_splitted_full))]
dniImienin = parse.(Int, dniImienin)
linie_miesiace = map(x -> x[end], split.(linie_splitted_full, "."))
linie_miesiace = filter(x -> length(x) >0, linie_miesiace);

# dni 
freqtable(dniImienin)
# miesiące 
freqtable(linie_miesiace)

# wykres wedlug dni
bar(freqtable(dniImienin), xticks = 1:31)
# wykres według miesiecy
bar(freqtable(linie_miesiace), xticks = (1:12, sort(unique(linie_miesiace))))

# pierwsze litery 
litery = lowercase.(string.(vcat(split.(imiona,"")...)))
freqtable(litery) |> sort

# # R Zadanie 2.5

# Odczytaj ramkę danych z zadania 1.13. Następnie używając funkcji by() wyświetl podsumowanie zmiennej Wiek osobno dla grupy WIT=brak i dla grupy WIT=obecny.

by(daneBT, :WIT, describe)

# alternatywnie z TexTables.jl
summarize_by(daneBT,  :WIT, :Wiek)

# # R Zadanie 2.6

# Wyznacz wyznacznik, wartości własne oraz wektory własne macierzy:

mat = [1 5 3; 2 0 5; 1 2 1]
det(mat)
eigen(mat)

# # RR Zadanie 2.7
# Używając funkcji outer() zbuduj i wyświetl na ekranie tabliczkę mnożenia liczb od 1 do 10.
(1:10) * (1:10)'

# # R Zadanie 2.8
# Odczytaj ramkę danych z zadania 1.13. Następnie wyznacz histogram dla zmiennej Wiek i zapisz go do pliku hist.pdf w wymiarach 5×5 cali

p1 = histogram(daneBT.Wiek, bins = :auto, size = (5*96, 5*96), legend = false, color = "white")
savefig(p1, "rozdzial2/hist.pdf")

# # RRR Zadanie 2.9

# Pod adresem http://money.pl/ można odczytać aktualne wartości indeksów giełdowych. Wczytaj zawartość tej strony do programu R, a następnie wyciągnij z niej dane o nazwie i wartościach indeksów. Zauważ, że w treści HTML tabela z nazwami i wartościami indeksów rozpoczyna się od linii <table id="tgpw" class="tabela">.

# **Opis jest nieaktualny.**

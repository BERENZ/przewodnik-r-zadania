# # pakiety do wszystkich zadań
using DataFrames
using StatsBase
using CSV
using Literate # Literate.markdown("zadania/rozdzial-1.jl", "zadania/"; documenter=false, execute=true)

# # R Zadanie 1.1
# Skonstruuj wektor kwadratów liczb od 1 do 100. Następnie używając operatora dzielenia modulo i funkcji factor() zlicz, które cyfry oraz jak często występują na pozycji jedności w wyznaczonych kwadratach.

wektor = (1:100).^2
sort(countmap(wektor .% 10))

# # RR Zadanie 1.2
# Zbuduj własne tablice trygonometryczne. Przygotuj ramkę danych, w których zebrane będą informacje o wartościach funkcji sinus, cosinus, tangens i cotangens dla kątów: $0$ , $30$ , $45$ , $60$ , $90$ . Zauważ, że funkcje trygonometryczne w R przyjmują argumenty w radianach.

rad2dec(x) = x*π/180
x = rad2dec.([0,30,45,60,90])
DataFrame("sin" => sin.(x), "cos" => cos.(x), "tan" => tan.(x), "atan" => 1 ./tan.(x))

# # R Zadanie 1.3
# Przygotuj wektor 30 łańcuchów znaków następującej postaci: liczba.litera, gdzie liczba to kolejne liczby od 1 do 30 a litera to trzy duże litery A, B, C występujące cyklicznie.

string.(collect(1:30)) .* "." .* repeat(["A", "B", "C"], 10)

# # R Zadanie 1.4
# Wczytaj zbiór danych `daneO` i napisz funkcję lub pętlę sprawdzającą typ i klasę każdej kolumny tego zbioru.
# *Uwaga:* tu jest trochę zabawy bo pierwsza kolumna zaiwera indeksy ale nie ma nazwy więc trochę trzeba do obejść
download("http://www.biecek.pl/R/dane/daneO.csv", "zadania/daneO.csv")
daneO = CSV.read("zadania/daneO.csv", DataFrame, limit=1); ## colnames
daneO = CSV.read("zadania/daneO.csv", DataFrame, header = vcat("id", names(daneO)), delim = ";", 
                 datarow = 2, missingstring = "NA")
select!(daneO, Not(:id))

for col in eachcol(daneO)
    println("klasa: ", eltype(col), ", typ: " , typeof(col))
end

# albo jak w rozwiązaniu z R
for (ind, col) in enumerate(eachcol(daneO))
    println(names(daneO)[ind], ": klasa: ", eltype(col), ", typ: " , typeof(col))
end

# # R Zadanie 1.5
# Z odczytanej ramki danych `dane0` wyświetl tylko dane z wierszy o parzystych indeksach.

daneO[2:2:end, :]

# # R Zadanie 1.6
# Używając operatorów logicznych wyświetl ze zbioru danych tylko wiersze odpowiadające: pacjentkom starszym niż 50 lat u których wystąpiły przerzuty do węzłów chłonnych (cecha Wezly.chlonne=1).

daneO[(daneO.Wiek .< 50) .& (daneO."Wezly.chlonne" .==1),:]

# alternatywnie z operatorem @.

@. daneO[(daneO.Wiek < 50) & (daneO."Wezly.chlonne" == 1), :]

# # R Zadanie 1.7
# Wyświetl nazwy kolumn w zbiorze danych daneO, a następnie oblicz długość (liczbę znaków) nazw kolejnych kolumn.

# Nazwy
names(daneO)
# Liczba znaków
length.(names(daneO))

# # R Zadanie 1.8
# Napisz funkcję, która za argumenty przyjmie wektor liczb, a jako wynik zwróci trzy najmniejsze i trzy największe liczby. Jeżeli wejściowy wektor jest krótszy niż trzy liczby, to wyświetlany powinien być napis “za krótki argument”.

# # RR Zadanie 1.9
# Zmodyfjkuj funkcję z poprzedniego zadania tak, by otrzymywała też drugi argument ile, którym można określić liczbę skrajnych wartości wyznaczanych jako wynik. Domyślną wartością tego argumentu powinna być liczba 3.

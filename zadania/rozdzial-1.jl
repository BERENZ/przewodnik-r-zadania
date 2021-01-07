# # pakiety do wszystkich zadań
using DataFrames
using StatsBase
using CSV
using Plots
using Literate # Literate.markdown("zadania/rozdzial-1.jl", "zadania/"; documenter=false, execute=true)

# # R Zadanie 1.1
# Skonstruuj wektor kwadratów liczb od 1 do 100. Następnie używając operatora dzielenia modulo i funkcji factor() zlicz, które cyfry oraz jak często występują na pozycji jedności w wyznaczonych kwadratach.

wektor = (1:100).^2
sort(countmap(wektor .% 10))

# # RR Zadanie 1.2
# Zbuduj własne tablice trygonometryczne. Przygotuj ramkę danych, w których zebrane będą informacje o wartościach funkcji sinus, cosinus, tangens i cotangens dla kątów: $0^{\circ}$ , $30^{\circ}$ , $45^{\circ}$ , $60^{\circ}$ , $90^{\circ}$ . Zauważ, że funkcje trygonometryczne w R przyjmują argumenty w radianach.

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

function skrajne(x) 
    if length(x) < 3
        return "za krótki argument"
    else
        sort!(x)
        return x[1:3], x[end-2:end]
    end
end

skrajne(rand(10))

# # RR Zadanie 1.9
# Zmodyfjkuj funkcję z poprzedniego zadania tak, by otrzymywała też drugi argument ile, którym można określić liczbę skrajnych wartości wyznaczanych jako wynik. Domyślną wartością tego argumentu powinna być liczba 3.

function skrajne(x, ile = 3) 
    if length(x) < ile
        return "za krótki argument"
    else
        sort!(x)
        return x[1:ile], x[end-(ile-1):end]
    end
end

skrajne(rand(10), 4)

# # RR Zadanie 1.10
#  Napisz funkcję `poczatek()`` przyjmującą za pierwszy argument wektor, macierz lub ramkę a za drugi argument liczbę n. Niech to będzie przeciążona funkcja. Dla wektora powinna ona w wyniku zwracać n pierwszych elementów, dla macierzy i ramki danych powinna zwracać podmacierz o wymiarach n × n.

# *UWAGA:* przyklad multiple dispatch

# # RR Zadanie 1.11

# Napisz funkcję, która w układzie biegunowym ma współrzędne:
# \begin{equation}
# \begin{cases}
# r &= 1 + sin(t) \\
# \phi &= c * t
# \end{cases}
# \end{equation}
# dla $c \in \{1, 1.1, 2.2 \}$

# ``` 
# Wskazówka: trzeba zamienić współrzędne na układ kartezjański przekształceniami x=rcos(ϕ) i y=rsin(ϕ). Autor upierał się, że tego uczą w gimnazjum i takie podpowiedzi są zbędne, ale prawda jest taka, że autor nigdy nie był w gimnazjum. Przyp. żony.
# ```

function rysuj(c, max=100)
    t = 0:0.001:max
    r = 1 .+ sin.(t)
    ϕ = c*t
    x = r .* cos.(ϕ)
    y = r .* sin.(ϕ)
    plot(x, y,  legend = false)
end

# c=1
rysuj(1)
# c=0.1
rysuj(0.1)
# c=2.2
rysuj(2.2)

# # R Zadanie 1.12
# Używając instrukcji curve() narysuj wykres funkcji $f(x)=2x^3-x^2+3$ na przedziale [0, 1].

# Na wykresie tej funkcji zaznacz punkty odpowiadające wartościom w punktach 0.2 i 0.8, a następnie na wykres nanieś napisy opisujące współrzędne tych punktów. 

fun(x) = 2*x^3-x^2+3

plot(fun, 0, 1, legend = false) ## jak funkcja curve
scatter!([0.2, 0.8], fun.([0.2, 0.8]))
annotate!(0.2, fun(0.2), text(string([0.2, round(fun(0.2),digits=1)]), :bottom))
annotate!(0.8, fun(0.8), text(string([0.8, round(fun(0.8),digits=1)]), :bottom))

# # R Zadanie 1.13
# Pod adresem http://www.biecek.pl/R/dane/daneBioTech.csv znajduje się plik tekstowy z danymi. Dane są w formacie tabelarycznym, mają nagłówek, kolejne pola rozdzielane są średnikiem a kropką dziesiętną jest przecinek. Wczytaj te dane do programu R i przypisz je do zmiennej daneBT.

download("http://www.biecek.pl/R/dane/daneBioTech.csv", "daneBioTech")

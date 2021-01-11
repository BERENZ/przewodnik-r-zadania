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
download("http://www.biecek.pl/R/dane/daneO.csv", "zadania/rozdzial1/daneO.csv")
daneO = CSV.read("zadania/rozdzial1/daneO.csv", DataFrame, limit=1); ## colnames
daneO = CSV.read("zadania/rozdzial1/daneO.csv", DataFrame, header = vcat("id", names(daneO)), delim = ";", 
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
#  Napisz funkcję `poczatek()` przyjmującą za pierwszy argument wektor, macierz lub ramkę a za drugi argument liczbę n. Niech to będzie przeciążona funkcja. Dla wektora powinna ona w wyniku zwracać n pierwszych elementów, dla macierzy i ramki danych powinna zwracać podmacierz o wymiarach n × n.

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

download("http://www.biecek.pl/R/dane/daneBioTech.csv", "zadania/rozdzial1/daneBioTech")
daneBT = CSV.read(open(read, "zadania/rozdzial1/daneBioTech", enc"ISO-8859-2"), DataFrame; 
                  delim=';', decimal=',', header=true, normalizenames = true)

# # R Zadanie 1.14
# Z odczytanych w poprzednim zadaniu danych wybierz tylko pierwsze trzy kolumny i pierwsze 10 wierszy. Zapisz ten fragment danych do pliku `maleDane.txt` na dysk `c:\`` (użytkownicy Linuxa mogą zapisać do innego katalogu). Rozdzielaj kolejne pola znakiem tabulacji a kropką dziesiętną będzie kropka. Sprawdź w dowolnym edytorze tekstowym, co zapisało się do tego pliku.

CSV.write( "zadania/rozdzial1/maleDane.txt", daneBT[1:10, 1:3], delim = "\t", decimal='.')

# # RR Zadanie 1.15
# Skonstruuj wektor 100 liczb, który jest symetryczny (tzn. elementy czytane od końca tworzą ten sam wektor co elementy czytane od początku). Pierwsze 20 liczb to kolejne liczby naturalne, następnie występuje 10 zer, następnie 20 kolejnych liczb parzystych (pozostałe elementy określone są przez warunek symetrii). Napisz funkcję, która sprawdza czy wektor jest symetryczny i sprawdź czy wygenerowany wektor jest symetryczny.

# # RRR Zadanie 1.16

# Napisz funkcję `localMin()`, której argumentem będzie ramka danych, a wynikiem będą te wiersze, w których w jakiejkolwiek liczbowej kolumnie występuje wartość najmniejsza dla tej kolumny. Kolumny z wartościami nieliczbowymi nie powinny być brane pod uwagę.

# Innymi słowy jeżeli ramka ma trzy kolumny z wartościami liczbowymi, to wynikiem powinny być wiersze, w których w pierwszej kolumnie występują wartości minimalne dla pierwszej kolumny oraz wiersze, w których w drugiej kolumnie występują wartości minimalne dla drugiej kolumny oraz wiersze, w których w trzeciej kolumnie występują wartości minimalne dla trzeciej kolumny. Odczytaj ramkę danych z zadania 1.13 i sprawdź działanie napisanej funkcji.


# # R Zadanie 1.17
# Poniższa funkcja nie działa poprawnie, powinna wyznaczać kwadraty kolejnych liczb ale tego nie robi. Skopiuj ją do programu R a następnie użyj instrukcji fix(), by poprawić funkcję kwadratyLiczb().

# ```
# kwadratyLiczb <- function(x) {
# 1:x^2
# }
# ```

kwadratyLiczb(x) = (1:x).^2
kwadratyLiczb(10)

# # R Zadanie 1.18
# Funkcja `ecdf()`, wyznacza dystrybuantę empiryczną. Przyjrzyj się trzeciej linii z poniższego przykładu oraz spróbuj przewidzieć co jest wynikiem tego wyrażenia i jaka funkcja jest wywoływana jako druga.

iris = dataset("datasets", "iris")
x = iris[:, 1]
ecdf(x)(x)

# # R Zadanie 1.19
# Znajdź liczbę `x` z przedziału `[0 − 1]`` dla którego poniższe wyrażenie zwraca wartość `FALSE`.
# `x + 0.1 + 0.1 == 0.1 + 0.1 + x`

x = 0:0.1:1
@. x + 0.1 + 0.1 == 0.1 + 0.1 + x

# # R Zadanie 1.20
# Dla zbioru danych `iris` narysuj wykres przedstawiający zależność pomiędzy dwoma wybranymi zmiennymi. Użyj funkcji `png()` i `pdf()` aby zapisać ten wykres do pliku.


p1 = scatter(iris.SepalLength,iris.SepalWidth)
savefig(p1, "zadania/rozdzial1/plotR_01.pdf")
savefig(p1, "zadania/rozdzial1/plotR_01.png")
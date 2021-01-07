```julia
using DataFrames
using Literate # Literate.markdown("zadania/rozdzial-1.jl", "zadania/"; documenter=false)
using StatsBase
using CSV
```

# R Zadanie 1.1
Skonstruuj wektor kwadratów liczb od 1 do 100. Następnie używając operatora dzielenia modulo i funkcji factor() zlicz, które cyfry oraz jak często występują na pozycji jedności w wyznaczonych kwadratach.

```julia
wektor = (1:100).^2
sort(countmap(wektor .% 10))
```

```
OrderedCollections.OrderedDict{Int64,Int64} with 6 entries:
  0 => 10
  1 => 20
  4 => 20
  5 => 10
  6 => 20
  9 => 20
```

# RR Zadanie 1.2
Zbuduj własne tablice trygonometryczne. Przygotuj ramkę danych, w których zebrane będą informacje o wartościach funkcji sinus, cosinus, tangens i cotangens dla kątów: $0$ , $30$ , $45$ , $60$ , $90$ . Zauważ, że funkcje trygonometryczne w R przyjmują argumenty w radianach.

```julia
rad2dec(x) = x*π/180
x = rad2dec.([0,30,45,60,90])
DataFrame("sin" => sin.(x), "cos" => cos.(x), "tan" => tan.(x), "atan" => 1 ./tan.(x))
```

```
5×4 DataFrame
│ Row │ sin      │ cos         │ tan        │ atan        │
│     │ Float64  │ Float64     │ Float64    │ Float64     │
├─────┼──────────┼─────────────┼────────────┼─────────────┤
│ 1   │ 0.0      │ 1.0         │ 0.0        │ Inf         │
│ 2   │ 0.5      │ 0.866025    │ 0.57735    │ 1.73205     │
│ 3   │ 0.707107 │ 0.707107    │ 1.0        │ 1.0         │
│ 4   │ 0.866025 │ 0.5         │ 1.73205    │ 0.57735     │
│ 5   │ 1.0      │ 6.12323e-17 │ 1.63312e16 │ 6.12323e-17 │
```

# R Zadanie 1.3
Przygotuj wektor 30 łańcuchów znaków następującej postaci: liczba.litera, gdzie liczba to kolejne liczby od 1 do 30 a litera to trzy duże litery A, B, C występujące cyklicznie.

```julia
string.(collect(1:30)) .* "." .* repeat(["A", "B", "C"], 10)
```

```
30-element Array{String,1}:
 "1.A"
 "2.B"
 "3.C"
 "4.A"
 "5.B"
 "6.C"
 "7.A"
 "8.B"
 "9.C"
 "10.A"
 "11.B"
 "12.C"
 "13.A"
 "14.B"
 "15.C"
 "16.A"
 "17.B"
 "18.C"
 "19.A"
 "20.B"
 "21.C"
 "22.A"
 "23.B"
 "24.C"
 "25.A"
 "26.B"
 "27.C"
 "28.A"
 "29.B"
 "30.C"
```

# R Zadanie 1.4
Wczytaj zbiór danych `daneO` i napisz funkcję lub pętlę sprawdzającą typ i klasę każdej kolumny tego zbioru.

```julia
download("http://www.biecek.pl/R/dane/daneO.csv", "zadania/daneO.csv")
daneO = CSV.read("zadania/daneO.csv", DataFrame, limit=1); ## colnames
dane0 = CSV.read("zadania/daneO.csv", DataFrame, header = vcat("id", names(daneO)), delim = ";",
                 datarow = 2, missingstring = "NA")

for col in eachcol(daneO)
    println("klasa: ", eltype(col), ", typ: " , typeof(col))
end
```

```
┌ Warning: thread = 1 warning: parsed expected 9 columns, but didn't reach end of line around data row: 2. Ignoring any extra columns on this row
└ @ CSV /Users/berenz/.julia/packages/CSV/la2cd/src/file.jl:604
klasa: Int64, typ: Array{Int64,1}
klasa: Int64, typ: Array{Int64,1}
klasa: Int64, typ: Array{Int64,1}
klasa: Int64, typ: Array{Int64,1}
klasa: Int64, typ: Array{Int64,1}
klasa: String, typ: PooledArrays.PooledArray{String,UInt32,1,Array{UInt32,1}}
klasa: String, typ: PooledArrays.PooledArray{String,UInt32,1,Array{UInt32,1}}
klasa: String, typ: PooledArrays.PooledArray{String,UInt32,1,Array{UInt32,1}}
klasa: Int64, typ: Array{Int64,1}

```

albo jak w rozwiązaniu z R

```julia
for (ind, col) in enumerate(eachcol(daneO))
    println(names(dane0)[ind], ": klasa: ", eltype(col), ", typ: " , typeof(col))
end
```

```
id: klasa: Int64, typ: Array{Int64,1}
Wiek: klasa: Int64, typ: Array{Int64,1}
Rozmiar.guza: klasa: Int64, typ: Array{Int64,1}
Wezly.chlonne: klasa: Int64, typ: Array{Int64,1}
Nowotwor: klasa: Int64, typ: Array{Int64,1}
Receptory.estrogenowe: klasa: String, typ: PooledArrays.PooledArray{String,UInt32,1,Array{UInt32,1}}
Receptory.progesteronowe: klasa: String, typ: PooledArrays.PooledArray{String,UInt32,1,Array{UInt32,1}}
Niepowodzenia: klasa: String, typ: PooledArrays.PooledArray{String,UInt32,1,Array{UInt32,1}}
Okres.bez.wznowy: klasa: Int64, typ: Array{Int64,1}

```

# R Zadanie 1.5
Z odczytanej ramki danych `dane0` wyświetl tylko dane z wierszy o parzystych indeksach.

```julia
daneO
collect(2:2:10)
```

```
5-element Array{Int64,1}:
  2
  4
  6
  8
 10
```

---

*This page was generated using [Literate.jl](https://github.com/fredrikekre/Literate.jl).*


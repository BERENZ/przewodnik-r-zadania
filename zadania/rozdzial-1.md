# pakiety do wszystkich zadań

```julia
using DataFrames
using StatsBase
using CSV
using Literate # Literate.markdown("zadania/rozdzial-1.jl", "zadania/"; documenter=false, execute=true)
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
daneO = CSV.read("zadania/daneO.csv", DataFrame, header = vcat("id", names(daneO)), delim = ";",
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
klasa: Union{Missing, Int64}, typ: SentinelArrays.SentinelArray{Int64,1,Int64,Missing,Array{Int64,1}}
klasa: Union{Missing, String}, typ: PooledArrays.PooledArray{Union{Missing, String},UInt32,1,Array{UInt32,1}}
klasa: Union{Missing, String}, typ: PooledArrays.PooledArray{Union{Missing, String},UInt32,1,Array{UInt32,1}}
klasa: String, typ: PooledArrays.PooledArray{String,UInt32,1,Array{UInt32,1}}
klasa: Union{Missing, Int64}, typ: SentinelArrays.SentinelArray{Int64,1,Int64,Missing,Array{Int64,1}}
klasa: Int64, typ: Array{Int64,1}

```

albo jak w rozwiązaniu z R

```julia
for (ind, col) in enumerate(eachcol(daneO))
    println(names(daneO)[ind], ": klasa: ", eltype(col), ", typ: " , typeof(col))
end
```

```
id: klasa: Int64, typ: Array{Int64,1}
Wiek: klasa: Int64, typ: Array{Int64,1}
Rozmiar.guza: klasa: Int64, typ: Array{Int64,1}
Wezly.chlonne: klasa: Int64, typ: Array{Int64,1}
Nowotwor: klasa: Union{Missing, Int64}, typ: SentinelArrays.SentinelArray{Int64,1,Int64,Missing,Array{Int64,1}}
Receptory.estrogenowe: klasa: Union{Missing, String}, typ: PooledArrays.PooledArray{Union{Missing, String},UInt32,1,Array{UInt32,1}}
Receptory.progesteronowe: klasa: Union{Missing, String}, typ: PooledArrays.PooledArray{Union{Missing, String},UInt32,1,Array{UInt32,1}}
Niepowodzenia: klasa: String, typ: PooledArrays.PooledArray{String,UInt32,1,Array{UInt32,1}}
Okres.bez.wznowy: klasa: Union{Missing, Int64}, typ: SentinelArrays.SentinelArray{Int64,1,Int64,Missing,Array{Int64,1}}
VEGF: klasa: Int64, typ: Array{Int64,1}

```

# R Zadanie 1.5
Z odczytanej ramki danych `dane0` wyświetl tylko dane z wierszy o parzystych indeksach.

```julia
daneO[2:2:end, :]
```

```
48×10 DataFrame
│ Row │ id    │ Wiek  │ Rozmiar.guza │ Wezly.chlonne │ Nowotwor │ Receptory.estrogenowe │ Receptory.progesteronowe │ Niepowodzenia │ Okres.bez.wznowy │ VEGF  │
│     │ Int64 │ Int64 │ Int64        │ Int64         │ Int64?   │ String?               │ Union{Missing, String}   │ String        │ Int64?           │ Int64 │
├─────┼───────┼───────┼──────────────┼───────────────┼──────────┼───────────────────────┼──────────────────────────┼───────────────┼──────────────────┼───────┤
│ 1   │ 2     │ 29    │ 1            │ 0             │ 2        │ (++)                  │ (++)                     │ brak          │ 53               │ 1118  │
│ 2   │ 4     │ 32    │ 1            │ 0             │ 3        │ (++)                  │ (++)                     │ brak          │ 26               │ 1793  │
│ 3   │ 6     │ 33    │ 1            │ 1             │ 3        │ (-)                   │ (++)                     │ wznowa        │ 36               │ 2776  │
│ 4   │ 8     │ 35    │ 2            │ 1             │ 2        │ (+)                   │ (++)                     │ brak          │ 38               │ 3827  │
│ 5   │ 10    │ 36    │ 1            │ 1             │ 2        │ (-)                   │ (++)                     │ brak          │ 37               │ 834   │
│ 6   │ 12    │ 37    │ 1            │ 0             │ 3        │ (-)                   │ (+)                      │ wznowa        │ 40               │ 3331  │
│ 7   │ 14    │ 38    │ 1            │ 1             │ 3        │ (++)                  │ (+++)                    │ wznowa        │ 16               │ 2759  │
│ 8   │ 16    │ 40    │ 1            │ 1             │ 2        │ (+)                   │ (++)                     │ brak          │ 27               │ 3038  │
│ 9   │ 18    │ 41    │ 1            │ 1             │ 2        │ missing               │ missing                  │ brak          │ 19               │ 1981  │
│ 10  │ 20    │ 41    │ 1            │ 0             │ 3        │ (+)                   │ (-)                      │ brak          │ 18               │ 989   │
│ 11  │ 22    │ 42    │ 1            │ 1             │ 2        │ (+++)                 │ (++)                     │ wznowa        │ 29               │ 5994  │
│ 12  │ 24    │ 42    │ 1            │ 1             │ 2        │ (+++)                 │ (+++)                    │ brak          │ 47               │ 532   │
│ 13  │ 26    │ 42    │ 1            │ 0             │ missing  │ (-)                   │ (+)                      │ brak          │ 33               │ 1531  │
│ 14  │ 28    │ 43    │ 1            │ 0             │ 3        │ missing               │ missing                  │ brak          │ 39               │ 1348  │
│ 15  │ 30    │ 44    │ 1            │ 0             │ 1        │ (++)                  │ (+)                      │ brak          │ 47               │ 2402  │
│ 16  │ 32    │ 44    │ 2            │ 0             │ 2        │ (++)                  │ (+++)                    │ brak          │ 48               │ 483   │
│ 17  │ 34    │ 44    │ 1            │ 1             │ 3        │ (+)                   │ (++)                     │ brak          │ 36               │ 596   │
│ 18  │ 36    │ 44    │ 2            │ 1             │ 3        │ (-)                   │ (-)                      │ brak          │ 53               │ 164   │
│ 19  │ 38    │ 45    │ 1            │ 0             │ 2        │ (+++)                 │ (++)                     │ brak          │ 33               │ 951   │
│ 20  │ 40    │ 45    │ 1            │ 1             │ 2        │ (++)                  │ (++)                     │ brak          │ 54               │ 1275  │
│ 21  │ 42    │ 46    │ 1            │ 0             │ 2        │ (+)                   │ (+++)                    │ brak          │ 23               │ 2018  │
│ 22  │ 44    │ 46    │ 1            │ 0             │ 2        │ (++)                  │ (+++)                    │ brak          │ 42               │ 1197  │
│ 23  │ 46    │ 46    │ 1            │ 0             │ 2        │ (+)                   │ (++)                     │ brak          │ 51               │ 780   │
│ 24  │ 48    │ 46    │ 1            │ 1             │ 3        │ (-)                   │ (+)                      │ brak          │ 36               │ 2703  │
│ 25  │ 50    │ 46    │ 1            │ 0             │ missing  │ missing               │ missing                  │ brak          │ 28               │ 1526  │
│ 26  │ 52    │ 47    │ 1            │ 0             │ 2        │ (+)                   │ (++)                     │ brak          │ 31               │ 286   │
│ 27  │ 54    │ 47    │ 2            │ 0             │ 2        │ (+++)                 │ (+++)                    │ brak          │ 33               │ 2442  │
│ 28  │ 56    │ 47    │ 1            │ 0             │ 3        │ (+)                   │ (++)                     │ brak          │ 38               │ 326   │
│ 29  │ 58    │ 48    │ 1            │ 1             │ 3        │ (-)                   │ (-)                      │ wznowa        │ 21               │ 5194  │
│ 30  │ 60    │ 49    │ 1            │ 0             │ 1        │ (++)                  │ (++)                     │ brak          │ 36               │ 4355  │
│ 31  │ 62    │ 49    │ 1            │ 1             │ 2        │ (+)                   │ (++)                     │ brak          │ 36               │ 3101  │
│ 32  │ 64    │ 49    │ 2            │ 1             │ 3        │ (-)                   │ (-)                      │ brak          │ 39               │ 189   │
│ 33  │ 66    │ 50    │ 2            │ 1             │ 1        │ (-)                   │ (-)                      │ brak          │ 28               │ 1485  │
│ 34  │ 68    │ 50    │ 1            │ 0             │ 2        │ (++)                  │ (+++)                    │ brak          │ 29               │ 118   │
│ 35  │ 70    │ 50    │ 2            │ 1             │ 2        │ (++)                  │ (-)                      │ brak          │ 33               │ 1694  │
│ 36  │ 72    │ 50    │ 2            │ 0             │ 3        │ (-)                   │ (-)                      │ brak          │ 39               │ 1738  │
│ 37  │ 74    │ 50    │ 2            │ 1             │ 3        │ (+++)                 │ (+++)                    │ brak          │ 49               │ 3946  │
│ 38  │ 76    │ 50    │ 2            │ 1             │ missing  │ (+++)                 │ (-)                      │ brak          │ 27               │ 7665  │
│ 39  │ 78    │ 51    │ 1            │ 1             │ 2        │ (++)                  │ (++)                     │ brak          │ 33               │ 629   │
│ 40  │ 80    │ 51    │ 1            │ 0             │ 2        │ (+)                   │ (+++)                    │ brak          │ 50               │ 223   │
│ 41  │ 82    │ 51    │ 2            │ 0             │ 3        │ (-)                   │ (-)                      │ wznowa        │ 10               │ 13953 │
│ 42  │ 84    │ 51    │ 2            │ 1             │ missing  │ (-)                   │ (-)                      │ brak          │ 30               │ 8064  │
│ 43  │ 86    │ 52    │ 1            │ 0             │ 2        │ (++)                  │ (++)                     │ brak          │ 42               │ 357   │
│ 44  │ 88    │ 52    │ 2            │ 1             │ 2        │ (+)                   │ (+)                      │ wznowa        │ 48               │ 1927  │
│ 45  │ 90    │ 52    │ 1            │ 0             │ missing  │ (-)                   │ (+)                      │ brak          │ 48               │ 3547  │
│ 46  │ 92    │ 53    │ 1            │ 0             │ 3        │ (-)                   │ (-)                      │ wznowa        │ 50               │ 590   │
│ 47  │ 94    │ 55    │ 1            │ 0             │ 1        │ (+)                   │ (++)                     │ brak          │ 36               │ 1354  │
│ 48  │ 96    │ 55    │ 1            │ 0             │ missing  │ missing               │ missing                  │ brak          │ missing          │ 1255  │
```

# R Zadanie 1.6
Używając operatorów logicznych wyświetl ze zbioru danych tylko wiersze odpowiadające: pacjentkom starszym niż 50 lat u których wystąpiły przerzuty do węzłów chłonnych (cecha Wezly.chlonne=1).

```julia
daneO[(daneO.Wiek .< 50) .& (daneO."Wezly.chlonne" .==1),:]
```

```
27×10 DataFrame
│ Row │ id    │ Wiek  │ Rozmiar.guza │ Wezly.chlonne │ Nowotwor │ Receptory.estrogenowe │ Receptory.progesteronowe │ Niepowodzenia │ Okres.bez.wznowy │ VEGF  │
│     │ Int64 │ Int64 │ Int64        │ Int64         │ Int64?   │ String?               │ Union{Missing, String}   │ String        │ Int64?           │ Int64 │
├─────┼───────┼───────┼──────────────┼───────────────┼──────────┼───────────────────────┼──────────────────────────┼───────────────┼──────────────────┼───────┤
│ 1   │ 3     │ 30    │ 1            │ 1             │ 2        │ (-)                   │ (+)                      │ brak          │ 38               │ 630   │
│ 2   │ 6     │ 33    │ 1            │ 1             │ 3        │ (-)                   │ (++)                     │ wznowa        │ 36               │ 2776  │
│ 3   │ 8     │ 35    │ 2            │ 1             │ 2        │ (+)                   │ (++)                     │ brak          │ 38               │ 3827  │
│ 4   │ 9     │ 35    │ 1            │ 1             │ 3        │ (-)                   │ (-)                      │ wznowa        │ 38               │ 22554 │
│ 5   │ 10    │ 36    │ 1            │ 1             │ 2        │ (-)                   │ (++)                     │ brak          │ 37               │ 834   │
│ 6   │ 14    │ 38    │ 1            │ 1             │ 3        │ (++)                  │ (+++)                    │ wznowa        │ 16               │ 2759  │
│ 7   │ 15    │ 38    │ 1            │ 1             │ 3        │ (-)                   │ (-)                      │ brak          │ 44               │ 511   │
│ 8   │ 16    │ 40    │ 1            │ 1             │ 2        │ (+)                   │ (++)                     │ brak          │ 27               │ 3038  │
│ 9   │ 17    │ 40    │ 1            │ 1             │ 2        │ (-)                   │ (++)                     │ brak          │ 36               │ 1027  │
│ 10  │ 18    │ 41    │ 1            │ 1             │ 2        │ missing               │ missing                  │ brak          │ 19               │ 1981  │
│ 11  │ 19    │ 41    │ 2            │ 1             │ 2        │ (++)                  │ (+++)                    │ brak          │ 41               │ 1489  │
│ 12  │ 21    │ 41    │ 1            │ 1             │ 3        │ (+)                   │ (+)                      │ wznowa        │ 41               │ 6175  │
│ 13  │ 22    │ 42    │ 1            │ 1             │ 2        │ (+++)                 │ (++)                     │ wznowa        │ 29               │ 5994  │
│ 14  │ 23    │ 42    │ 1            │ 1             │ 2        │ (++)                  │ (++)                     │ brak          │ 47               │ 3673  │
│ 15  │ 24    │ 42    │ 1            │ 1             │ 2        │ (+++)                 │ (+++)                    │ brak          │ 47               │ 532   │
│ 16  │ 27    │ 42    │ 2            │ 1             │ missing  │ (-)                   │ (+)                      │ brak          │ 30               │ 1339  │
│ 17  │ 34    │ 44    │ 1            │ 1             │ 3        │ (+)                   │ (++)                     │ brak          │ 36               │ 596   │
│ 18  │ 36    │ 44    │ 2            │ 1             │ 3        │ (-)                   │ (-)                      │ brak          │ 53               │ 164   │
│ 19  │ 37    │ 44    │ 1            │ 1             │ missing  │ (-)                   │ (-)                      │ brak          │ 38               │ 3836  │
│ 20  │ 40    │ 45    │ 1            │ 1             │ 2        │ (++)                  │ (++)                     │ brak          │ 54               │ 1275  │
│ 21  │ 43    │ 46    │ 1            │ 1             │ 2        │ (-)                   │ (-)                      │ brak          │ 42               │ 18201 │
│ 22  │ 48    │ 46    │ 1            │ 1             │ 3        │ (-)                   │ (+)                      │ brak          │ 36               │ 2703  │
│ 23  │ 49    │ 46    │ 1            │ 1             │ 3        │ (+)                   │ (++)                     │ brak          │ 38               │ 770   │
│ 24  │ 55    │ 47    │ 2            │ 1             │ 2        │ (-)                   │ (-)                      │ brak          │ 42               │ 4188  │
│ 25  │ 58    │ 48    │ 1            │ 1             │ 3        │ (-)                   │ (-)                      │ wznowa        │ 21               │ 5194  │
│ 26  │ 62    │ 49    │ 1            │ 1             │ 2        │ (+)                   │ (++)                     │ brak          │ 36               │ 3101  │
│ 27  │ 64    │ 49    │ 2            │ 1             │ 3        │ (-)                   │ (-)                      │ brak          │ 39               │ 189   │
```

alternatywnie z operatorem @.

```julia
@. daneO[(daneO.Wiek < 50) & (daneO."Wezly.chlonne" == 1), :]
```

```
27×10 DataFrame
│ Row │ id    │ Wiek  │ Rozmiar.guza │ Wezly.chlonne │ Nowotwor │ Receptory.estrogenowe │ Receptory.progesteronowe │ Niepowodzenia │ Okres.bez.wznowy │ VEGF  │
│     │ Int64 │ Int64 │ Int64        │ Int64         │ Int64?   │ String?               │ Union{Missing, String}   │ String        │ Int64?           │ Int64 │
├─────┼───────┼───────┼──────────────┼───────────────┼──────────┼───────────────────────┼──────────────────────────┼───────────────┼──────────────────┼───────┤
│ 1   │ 3     │ 30    │ 1            │ 1             │ 2        │ (-)                   │ (+)                      │ brak          │ 38               │ 630   │
│ 2   │ 6     │ 33    │ 1            │ 1             │ 3        │ (-)                   │ (++)                     │ wznowa        │ 36               │ 2776  │
│ 3   │ 8     │ 35    │ 2            │ 1             │ 2        │ (+)                   │ (++)                     │ brak          │ 38               │ 3827  │
│ 4   │ 9     │ 35    │ 1            │ 1             │ 3        │ (-)                   │ (-)                      │ wznowa        │ 38               │ 22554 │
│ 5   │ 10    │ 36    │ 1            │ 1             │ 2        │ (-)                   │ (++)                     │ brak          │ 37               │ 834   │
│ 6   │ 14    │ 38    │ 1            │ 1             │ 3        │ (++)                  │ (+++)                    │ wznowa        │ 16               │ 2759  │
│ 7   │ 15    │ 38    │ 1            │ 1             │ 3        │ (-)                   │ (-)                      │ brak          │ 44               │ 511   │
│ 8   │ 16    │ 40    │ 1            │ 1             │ 2        │ (+)                   │ (++)                     │ brak          │ 27               │ 3038  │
│ 9   │ 17    │ 40    │ 1            │ 1             │ 2        │ (-)                   │ (++)                     │ brak          │ 36               │ 1027  │
│ 10  │ 18    │ 41    │ 1            │ 1             │ 2        │ missing               │ missing                  │ brak          │ 19               │ 1981  │
│ 11  │ 19    │ 41    │ 2            │ 1             │ 2        │ (++)                  │ (+++)                    │ brak          │ 41               │ 1489  │
│ 12  │ 21    │ 41    │ 1            │ 1             │ 3        │ (+)                   │ (+)                      │ wznowa        │ 41               │ 6175  │
│ 13  │ 22    │ 42    │ 1            │ 1             │ 2        │ (+++)                 │ (++)                     │ wznowa        │ 29               │ 5994  │
│ 14  │ 23    │ 42    │ 1            │ 1             │ 2        │ (++)                  │ (++)                     │ brak          │ 47               │ 3673  │
│ 15  │ 24    │ 42    │ 1            │ 1             │ 2        │ (+++)                 │ (+++)                    │ brak          │ 47               │ 532   │
│ 16  │ 27    │ 42    │ 2            │ 1             │ missing  │ (-)                   │ (+)                      │ brak          │ 30               │ 1339  │
│ 17  │ 34    │ 44    │ 1            │ 1             │ 3        │ (+)                   │ (++)                     │ brak          │ 36               │ 596   │
│ 18  │ 36    │ 44    │ 2            │ 1             │ 3        │ (-)                   │ (-)                      │ brak          │ 53               │ 164   │
│ 19  │ 37    │ 44    │ 1            │ 1             │ missing  │ (-)                   │ (-)                      │ brak          │ 38               │ 3836  │
│ 20  │ 40    │ 45    │ 1            │ 1             │ 2        │ (++)                  │ (++)                     │ brak          │ 54               │ 1275  │
│ 21  │ 43    │ 46    │ 1            │ 1             │ 2        │ (-)                   │ (-)                      │ brak          │ 42               │ 18201 │
│ 22  │ 48    │ 46    │ 1            │ 1             │ 3        │ (-)                   │ (+)                      │ brak          │ 36               │ 2703  │
│ 23  │ 49    │ 46    │ 1            │ 1             │ 3        │ (+)                   │ (++)                     │ brak          │ 38               │ 770   │
│ 24  │ 55    │ 47    │ 2            │ 1             │ 2        │ (-)                   │ (-)                      │ brak          │ 42               │ 4188  │
│ 25  │ 58    │ 48    │ 1            │ 1             │ 3        │ (-)                   │ (-)                      │ wznowa        │ 21               │ 5194  │
│ 26  │ 62    │ 49    │ 1            │ 1             │ 2        │ (+)                   │ (++)                     │ brak          │ 36               │ 3101  │
│ 27  │ 64    │ 49    │ 2            │ 1             │ 3        │ (-)                   │ (-)                      │ brak          │ 39               │ 189   │
```

# R Zadanie 1.7
Wyświetl nazwy kolumn w zbiorze danych daneO, a następnie oblicz długość (liczbę znaków) nazw kolejnych kolumn.

Nazwy

```julia
names(daneO)
```

```
10-element Array{String,1}:
 "id"
 "Wiek"
 "Rozmiar.guza"
 "Wezly.chlonne"
 "Nowotwor"
 "Receptory.estrogenowe"
 "Receptory.progesteronowe"
 "Niepowodzenia"
 "Okres.bez.wznowy"
 "VEGF"
```

Liczba znaków

```julia
length.(names(daneO))
```

```
10-element Array{Int64,1}:
  2
  4
 12
 13
  8
 21
 24
 13
 16
  4
```

# R Zadanie 1.8
Napisz funkcję, która za argumenty przyjmie wektor liczb, a jako wynik zwróci trzy najmniejsze i trzy największe liczby. Jeżeli wejściowy wektor jest krótszy niż trzy liczby, to wyświetlany powinien być napis “za krótki argument”.

# RR Zadanie 1.9
Zmodyfjkuj funkcję z poprzedniego zadania tak, by otrzymywała też drugi argument ile, którym można określić liczbę skrajnych wartości wyznaczanych jako wynik. Domyślną wartością tego argumentu powinna być liczba 3.

---

*This page was generated using [Literate.jl](https://github.com/fredrikekre/Literate.jl).*


# Pakiety

```julia
using CSV
using DataFrames
using Dates
using RDatasets
```

## Rozdział 2.1

```julia
download("http://www.biecek.pl/R/auta.csv", "rozdzialy/dane/auta.csv")
auta = CSV.read("rozdzialy/dane/auta.csv", DataFrame)
head(auta, 5)
```

```
5×8 DataFrame
│ Row │ Marka   │ Model  │ Cena    │ KM    │ Pojemnosc │ Przebieg │ Paliwo  │ Produkcja │
│     │ String  │ String │ Float64 │ Int64 │ Int64     │ Float64  │ String  │ Int64     │
├─────┼─────────┼────────┼─────────┼───────┼───────────┼──────────┼─────────┼───────────┤
│ 1   │ Peugeot │ 206    │ 8799.0  │ 60    │ 1100      │ 85000.0  │ benzyna │ 2003      │
│ 2   │ Peugeot │ 206    │ 15500.0 │ 60    │ 1124      │ 114000.0 │ benzyna │ 2005      │
│ 3   │ Peugeot │ 206    │ 11900.0 │ 90    │ 1997      │ 215000.0 │ diesel  │ 2003      │
│ 4   │ Peugeot │ 206    │ 10999.0 │ 70    │ 1868      │ 165000.0 │ diesel  │ 2003      │
│ 5   │ Peugeot │ 206    │ 11900.0 │ 70    │ 1398      │ 146000.0 │ diesel  │ 2005      │
```

## Rozdział 2.2.1

```julia
#
[2, 3, 5, 7, 11, 13, 17]
#
collect(-3:3)
#
collect(0:11:100)
#
months = [Dates.monthname(i) for i in 1:12]
#
LETTERS = 'A':'Z'
#
print(collect(LETTERS))
#
print(collect(LETTERS[5:10]))
#
print(collect(LETTERS[[1,2,9,10,11,12,13,14]]))
#
print(collect('A':2:'Z'))
#
print(months[setdiff(1:length(months), 5:9)])
#
wartosc = (pion = 1, skoczek = 3, goniec = 3,  wieza = 5, hetman = 9, krol = Inf)
#
(wartosc.goniec, wartosc.wieza)
#
print([wartosc[i] for i in [:goniec, :wieza]])
```

```
['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z']['E', 'F', 'G', 'H', 'I', 'J']['A', 'B', 'I', 'J', 'K', 'L', 'M', 'N']['A', 'C', 'E', 'G', 'I', 'K', 'M', 'O', 'Q', 'S', 'U', 'W', 'Y']["January", "February", "March", "April", "October", "November", "December"][3, 5]
```

---

*This page was generated using [Literate.jl](https://github.com/fredrikekre/Literate.jl).*


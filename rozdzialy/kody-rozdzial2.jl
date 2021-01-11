# # Pakiety
using CSV
using DataFrames
using Dates
using RDatasets

# ## Rozdział 2.1
download("http://www.biecek.pl/R/auta.csv", "rozdzialy/dane/auta.csv")
auta = CSV.read("rozdzialy/dane/auta.csv", DataFrame)
head(auta, 5)

# ## Rozdział 2.2.1

[2, 3, 5, 7, 11, 13, 17]

collect(-3:3)

collect(0:11:100)

months = [Dates.monthname(i) for i in 1:12]

LETTERS = 'A':'Z'

print(collect(LETTERS))

print(collect(LETTERS[5:10]))

print(collect(LETTERS[[1,2,9,10,11,12,13,14]]))

print(collect('A':2:'Z'))

print(months[setdiff(1:length(months), 5:9)])

wartosc = (pion = 1, skoczek = 3, goniec = 3,  wieza = 5, hetman = 9, krol = Inf)

(wartosc.goniec, wartosc.wieza)

print([wartosc[i] for i in [:goniec, :wieza]])



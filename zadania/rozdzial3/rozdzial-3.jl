# # R Zadanie 3.1
# Napisz funkcję `momenty()`, która dla zadanego wektora liczb wyznaczy średnią, wariancję, skośność i kurtozę.

function momenty(x)
    NamedArray([mean(x), var(x), skewness(x), kurtosis(x)],
               ["średnia", "wariancja", "skośność", "kurtoza"])
end

momenty(rand(20))


# # RR Zadanie 3.2
# Ze zbioru danych `daneO` wyciągnij zmienną `VEGF` i narysuj dla niej histogram (ile podziałów przyjąć?). Co o zmiennej mówi ten histogram? Zastosuj transformację, która ustabilizuje tą zmienną, a następnie narysuj histogram dla transformowanych danych. Na histogramie zamiast liczebności zaznacz prawdopodobieństwa, następnie dorysuj do tego wykresu ocenę gęstości wyznaczoną z użyciem funkcji `density()`.

daneO = CSV.read("zadania/rozdzial1/daneO.csv", DataFrame, limit=1); ## colnames
daneO = CSV.read("zadania/rozdzial1/daneO.csv", DataFrame, header = vcat("id", names(daneO)), delim = ";", 
                 datarow = 2, missingstring = "NA", normalizenames = true)
select!(daneO, Not(:id))

# histogram
histogram(daneO.VEGF, legend = false)

# logarytm i wykres gęstości
daneO.VEGF_log = log.(daneO.VEGF)
histogram(daneO.VEGF_log, legend = false, bins = :fd, color = "white", normalize = :probability)
density!(daneO.VEGF_log)


# # R Zadanie 3.3

# W zbiorze danych `daneO` znajduje się zmienna liczbowa `Wiek` i czynnikowa `Receptory.estrogenowe`. Narysuj wykres pudełkowy dla zmiennej Wiek w rozbiciu na zmienną `Receptory.estrogenowe`. Narysuj wykres skrzypcowy dla zmiennej `Wiek` w rozbiciu na poziomy zmiennej `Niepowodzenia`.

# Wykres pudełkowy (są braki danych (missing))
boxplot(daneO.Receptory_estrogenowe, daneO.Wiek, legend = false, color = "white")

# Wykres skrzypcowy
violin(daneO.Receptory_estrogenowe, daneO.Wiek, legend = false, color = "white")
boxplot!(daneO.Receptory_estrogenowe, daneO.Wiek, legend = false, color = "white", fillalpha = 0.5, width=0.5)

# # R Zadanie 3.4
# Narysuj wykres rozrzutu dla zmiennych `Wiek` i `VEGF` (bez krzywej regresji nieparametrycznej). Czy wykres ten zmieni się, jeżeli zmienne będą podane w innej kolejności? Następnie zmienną `VEGF` narysuj w skali logarytmicznej. Narysuj też wykres rozrzutu dla tych zmiennych w rozbiciu na poziomy zmiennej `Niepowodzenia`.

# # R Zadanie 3.5
# Wygeneruj 20 liczb z rozkładu wykładniczego i narysuj dla wygenerowanego wektora dystrybuantę empiryczną. Następnie zrób to samo dla wektora 200 i 2000 liczb. Używając funkcji `MASS::fitdistr()` oceń parametr rate dla wylosowanego wektora.

Random.seed!(123)
## generujemy 20 obs
x = rand(Exponential(), 20)
## szacujemy parametr θ
fit_mle(Exponential, x)
## wykres ecdf
plot(ecdf(x), legend = false)

## generujemy 200 obs
x = rand(Exponential(), 200)
## szacujemy parametr θ
fit_mle(Exponential, x)
## wykres ecdf
plot(ecdf(x), legend = false)

## generujemy 2000 obs
x = rand(Exponential(), 2000)
## szacujemy parametr θ
fit_mle(Exponential, x)
## wykres ecdf
plot(ecdf(x), legend = false)

# # R Zadanie 3.6
# Używając metod analizy wariancji sprawdź, średnia której ze zmiennych ilościowych w zbiorze danych `daneO` różni się w zależności od poziomu zmiennej `Niepowodzenia`. Następnie zbuduj wektor zawierający p-wartości dla wyników z wykonanych analiz.
# Zmienna `Receptory.progesteronowe` ma wartości na 4 poziomach. Wykonaj dla niej analizę wariancji oraz testy post hoc.

# model 1
model1 = lm(@formula(Wiek ~ Niepowodzenia), daneO)

# model 2
model2 = lm(@formula(Okres_bez_wznowy ~ Niepowodzenia), daneO)

# model 3
model3 = lm(@formula(VEGF_log ~ Niepowodzenia), daneO)

## zestawienie parametrów
NamedArray([coeftable(model1).cols[4, 1][2], coeftable(model2).cols[4, 1][2], coeftable(model3).cols[4, 1][2]],
           ["Wiek", "Okres_bez_wznowy", "VEGF_log"])

# # R Zadanie 3.7
# Wykonaj model regresji liniowej dla zmiennych `cisnienie.skurczowe` i `wiek` ze zbioru danych daneSoc.
download("http://www.biecek.pl/R/dane/daneSoc.csv", "zadania/rozdzial3/daneSoc.csv")
daneSoc = CSV.read("zadania/rozdzial3/daneSoc.csv", DataFrame, normalizenames=true, missingstring = "NA")

## wykonujemy model
model_37 = lm(@formula(wiek ~ cisnienie_skurczowe), daneSoc)

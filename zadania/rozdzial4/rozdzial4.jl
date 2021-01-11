# # R Zadanie 4.1
# Dla pary zmiennych cisnienie.skurczowe i cisnienie.rozkurczowe ze zbioru danych daneSoc wyznacz histogram dwuwymiarowy. Aby poprawić czytelność wybierz odpowiednią liczbę klas.

daneSoc = CSV.read("zadania/rozdzial3/daneSoc.csv", DataFrame, normalizenames=true, missingstring = "NA")
marginalhist(daneSoc.cisnienie_skurczowe, daneSoc.cisnienie_rozkurczowe,  density=false)

# # R Zadanie 4.2
# Dla pary zmiennych `Nowotwor` i `Wiek` ze zbioru danych `daneO` wyznacz wykres słonecznikowy.


# # R Zadanie 4.3
# Narysuj macierz wykresów rozrzutu dla zbioru danych mieszkania.


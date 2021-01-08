# # Pakiety do wszystkich zadań
using DataFrames
using StatsBase
using CSV
using Plots
#using StatsPlots
using StringEncodings
using NamedArrays
using RDatasets
using Literate # Literate.markdown("rozdzial1/rozdzial-1.jl", "rozdzial1/"; documenter=false, execute=true)

# # R Zadanie 3.1
# Napisz funkcję `momenty()`, która dla zadanego wektora liczb wyznaczy średnią, wariancję, skośność i kurtozę.

function momenty(x)
    NamedArray([mean(x), var(x), skewness(x), kurtosis(x)],
               ["średnia", "wariancja", "skośność", "kurtoza"])
end

momenty(rand(20))


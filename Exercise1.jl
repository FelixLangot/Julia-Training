import Pkg
using Pkg
Pkg.add("Distributions")
Pkg.add("Plots")
Pkg.add("LaTeXStrings")
Pkg.add("ProgressBars")
using Plots
using LaTeXStrings
import Distributions: Uniform
using ProgressBars

# Parts a), b), c)

function arctan(X, N)
    n = 0
    C = 0
    if abs(X) <= 1
        while n <= N
            A = (-1)^n / (2 * n + 1)
            B = X^(2 * n + 1)
            C += A * B
            n += 1
        end
        return C

    elseif X > 1
        while n <= N
            A = (-1)^n / (2 * n + 1)
            B = (1 / X)^(2 * n + 1)
            C += A * B
            global D = pi / 2 - C
            n += 1
        end
        return D

    elseif X < 1
        while n <= N
            A = (-1)^n / (2 * n + 1)
            B = (1 / X)^(2 * n + 1)
            C += A * B
            global D = -pi / 2 - C
            n += 1
        end
        return D
    end
end

print("arctan(1) = ", arctan(1, 1000), " \n")
print("π/2 = ", pi / 4, "\n\n")
print("arctan(1/sqrt(3)) = ", arctan(1 / sqrt(3), 1000), "\n")
print("π/6 = ", pi / 6)

# Part d)

arctanvals = Vector{Float64}()
realarctan = Vector{Float64}()
xvals = rand(Uniform(-2, 2), 200)
Narray = ([2, 4, 6, 8, 10, 20, 50, 100, 1000])

for X in xvals
    append!(arctanvals, arctan(X, 1000))
    append!(realarctan, atan(X))
end

plt = plot(xvals, arctanvals, seriestype = :scatter)
plot!(xvals, realarctan, seriestype = :scatter)
display(plt)
print("done")

for Nmax in Narray
    arctanvals = Vector{Float64}()
    realarctan = Vector{Float64}()
    diff = Vector{Float64}()
    for X in xvals
        append!(arctanvals, arctan(X, Nmax))
        append!(realarctan, atan(X))
        append!(diff, arctan(X, Nmax) - atan(X))
    end

    plt = plot(xvals, arctanvals, seriestype = :scatter, xlabel = L"x", ylabel = L"arctan(x)")
    fontsize = 48
    plot!(xvals, realarctan, seriestype = :scatter)
    display(plt)
    plt2 = plot(xvals, diff, seriestype = :scatter, xlabel = L"x", ylabel = L"\Delta(x)")
    display(plt2)
end

# Part e)

# π to 7 significant figures is 3.141593 so 0.000001 precision = 1e-6, i.e. 6 digits

Diff = Vector{Float64}()
NNarray = ([5e5,1e6,5e6])
for Nmax in ProgressBar(NNarray)
    append!(Diff, abs(arctan(1, Nmax) * 4 - pi))
end
Thresh = Vector{Float64}(Diff)
fill!(Thresh,1e-6)

plt3 = plot(NNarray, Diff, xlabel=L"N", ylabel=L"\Delta \pi")
plot!(NNarray,Thresh)

4*arctan(1,1.2e6)
pi

N = 1.1814e6
Var1 = round(4*arctan(1,1e5), digits=6)
Var2 = round(pi,digits=6)
while Var1 != Var2
    Var1 = round(4*arctan(1,N), digits=6)
    Var2 = round(pi,digits=6)
    N += 1
end

N

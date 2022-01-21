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

# Part a) Write a Python program using the Euler method to calculate y(t) and vy (t) for a free falling body. You will need to provide sensible values for Cd, A and m. Use a starting height of 1 km and zero initial velocity. You will need to specify a condition for ending the simulation i.e. when the body reaches the ground. Plot your results.

Cd = 1.1  # slightly lower than ski jumper (1.2-1.3) for free falling body
A = 0.18  # Head down position cross-sectional area
ρ0 = 1.2
m = 70
g = 9.81

k = Cd * ρ0 * A / 2

z = 1000
v = 0
Δt = 1

V = Vector{Float64}()
Z = Vector{Float64}()

while z >= 0
    v += -Δt * (g + k / m * abs(v) * v)
    z += Δt * v
    print(v, z)
    append!(V, v)
    append!(Z, z)
end

T = Vector{Float64}(0:1:size(V, 1)-1)

plot(T, Z, xlabel = "t (s)", ylabel = "z (m)", label="z(t)")
plot(T, V, xlabel = "t (s)", ylabel = "v (m/s)", label="v(t)")

# Part b) Verify the correct functioning of your program by comparing with the following analytical prediction. N.B. In these equations, you can set y0 = 1 km and calculate y and vy for any t. Examine the effect on your solution of varying the step size Δt. Investigate how closely your solution tracks the real trajectory for a range of step sizes. What happens to the simulation when Δt is very large? Explore the effect on the motion of varying the ratio k/m.


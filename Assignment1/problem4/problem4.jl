### A Pluto.jl notebook ###
# v0.12.20

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : missing
        el
    end
end

# ╔═╡ f051efc0-71e0-11eb-1958-b764912842f8
using StatsBase

# ╔═╡ fa9b1b22-71ff-11eb-1014-d1706cffd3d6
using Plots

# ╔═╡ a897a01a-7282-11eb-2c8a-f54bbeb1eed5
md"Q4. (1 point) For this and the next question, we will setup an elaborate cybersecurity 🔐 context. 

Consider a plain-text authentication system where a password has to be 8 characters and can comprise of alphabets (both lower and upper case), numericals (0 to 9) and special characters (16 options ~ ! @ # $ % ^ & * ( ) _  + = - `). Every time a password is entered on a login website, it gets stored in a database if at least two characters in the entered password are exactly the same (position and value) as the actual password. 

If a hacker was to randomly try out different passwords, then (a) compute the probability of a password getting stored in the database using simple probability theory, and (b) confirm it with experiments in Julia. "

# ╔═╡ 67fc113a-71d8-11eb-355e-c77681e958c3
begin
	alphabet_s = ['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z']
	alphabet_c = ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z']
	number = [0,1,2,3,4,5,6,7,8,9]
	sp_ch = ['~','!','@','#','$','%','^','&','*','(',')','_','+','=','-','`']
end

# ╔═╡ ffa13964-71da-11eb-14b5-d5945be67a3c
begin
	alphanumeric_sp = vcat(alphabet_c,alphabet_s)
	alphanumeric_sp = vcat(alphanumeric_sp,number)
	alphanumeric_sp = vcat(alphanumeric_sp,sp_ch)
end

# ╔═╡ b801d87c-71db-11eb-1625-759c9536f7f3
# if Int(alphanumeric_sp[53]) == 0
#     md"x is less than y"
# else
# 	md"Hello"
# end

# ╔═╡ 792c5ed2-71e3-11eb-332f-39ce20fc7181
chosen_pass = [1,2,3,4,5,65,62,61]

# ╔═╡ 21ad518e-7206-11eb-03e3-0546c8c48ca6
chosen_password = [alphanumeric_sp[chosen_pass[j]] for j in 1:8]

# ╔═╡ 258144e2-7200-11eb-1057-f76578e7cb69
@bind rerun html"<button>Run</button>"

# ╔═╡ f62996e6-71e0-11eb-1248-79162a5a2b69
begin
	rerun
	N = 10^6
	password = [sample(1:78, 8, replace = false) for _ in 1:N]
end

# ╔═╡ d11ea014-71e3-11eb-1bcd-87051d71b95b
begin
	pass_match = [count([(Int(alphanumeric_sp[chosen_pass[j]]) ==Int(alphanumeric_sp[ password[i][j]])) for j in 1:8]) for i in 1:N]
	# arr = [count([ (1==0) for _ in 1:4]) for _ in 1:100]
end

# ╔═╡ 7dc9d006-7200-11eb-308e-15a177ea8fa7
begin
	prob_pass = [0,0,0,0,0,0,0,0]
	for i in 1:N
		prob_pass[pass_match[i]+1] += 1
	end
	prob_pass
end

# ╔═╡ 22299812-72d2-11eb-2185-6b4963116e50
begin
	prob_pass_ = [prob_pass[i]/N for i in 1:8] 
	prob_pass_
end

# ╔═╡ 6593d2e6-7202-11eb-37ac-619979f80ca0
ana_prob = 1-(prob_pass_[1]+prob_pass_[2])

# ╔═╡ 31753734-7408-11eb-22b7-7124a44908e6
theory_prob = sum([binomial(8,x)*(77^(8-x))/(78^8) for x in 2:8])

# ╔═╡ f6f0f174-7408-11eb-3ea9-a1195e55eb62
begin
	rerun
	plot(["Analytical", "Theoretical"], [ana_prob, theory_prob], normalize=true, ylabel="Probability", legend=false, title="Comparison of Analytical and Theoretical Solution")
	scatter!(["Analytical", "Theoretical"],[ana_prob, theory_prob],ma=0.5, ylabel="Probability",label=false)
end

# ╔═╡ Cell order:
# ╟─a897a01a-7282-11eb-2c8a-f54bbeb1eed5
# ╠═67fc113a-71d8-11eb-355e-c77681e958c3
# ╠═ffa13964-71da-11eb-14b5-d5945be67a3c
# ╠═b801d87c-71db-11eb-1625-759c9536f7f3
# ╠═792c5ed2-71e3-11eb-332f-39ce20fc7181
# ╠═21ad518e-7206-11eb-03e3-0546c8c48ca6
# ╠═f051efc0-71e0-11eb-1958-b764912842f8
# ╠═258144e2-7200-11eb-1057-f76578e7cb69
# ╠═f62996e6-71e0-11eb-1248-79162a5a2b69
# ╠═d11ea014-71e3-11eb-1bcd-87051d71b95b
# ╠═7dc9d006-7200-11eb-308e-15a177ea8fa7
# ╠═22299812-72d2-11eb-2185-6b4963116e50
# ╠═6593d2e6-7202-11eb-37ac-619979f80ca0
# ╠═fa9b1b22-71ff-11eb-1014-d1706cffd3d6
# ╠═31753734-7408-11eb-22b7-7124a44908e6
# ╠═f6f0f174-7408-11eb-3ea9-a1195e55eb62

### A Pluto.jl notebook ###
# v0.12.20

using Markdown
using InteractiveUtils

# ╔═╡ d0d3062e-744d-11eb-2b5b-cb9d3ce2ded4
using StatsBase

# ╔═╡ 775b8e4c-7205-11eb-0de0-2b13ccab429d
md"Q5. (1 point) Storing the attempts made into a database itself is also a security threat. Why? Many random password tries may overload the database and crash the authentication system. Given this system constraint, we would like to redesign our password check. 

Suppose we do not want to store more than 1,000 entries in the database when a million random password attempts are made by a hacker, how should you change the rule in the previous question of the password storage in the database. In the answer, first argue what you are doing, then write the Julia code that helps you figure out the new rule."

# ╔═╡ 3a2bcb00-72d1-11eb-083c-2b772d1f9b67
begin
	alphabet_s = ['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z']
	alphabet_c = ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z']
	number = [0,1,2,3,4,5,6,7,8,9]
	sp_ch = ['~','!','@','#','$','%','^','&','*','(',')','_','+','=','-','`']
end

# ╔═╡ b015fa54-744d-11eb-28cc-11ab96479ada
begin
	alphanumeric_sp = vcat(alphabet_c,alphabet_s)
	alphanumeric_sp = vcat(alphanumeric_sp,number)
	alphanumeric_sp = vcat(alphanumeric_sp,sp_ch)
end

# ╔═╡ b2cefc08-744d-11eb-393e-7549dac81a0b
chosen_pass = [1,2,3,4,5,65,62,61]

# ╔═╡ beef4e40-744d-11eb-2757-d573e3315bef
chosen_password = [alphanumeric_sp[chosen_pass[j]] for j in 1:8]

# ╔═╡ c51ba73c-744d-11eb-0722-6b38a9be95e1
begin
	N = 10^6
	password = [sample(1:78, 8, replace = false) for _ in 1:N]
end

# ╔═╡ f7af55c0-744d-11eb-34cb-db32aad3a790
begin
	pass_match = [count([(Int(alphanumeric_sp[chosen_pass[j]]) ==Int(alphanumeric_sp[ password[i][j]])) for j in 1:8]) for i in 1:N]
	# arr = [count([ (1==0) for _ in 1:4]) for _ in 1:100]
end

# ╔═╡ fe286632-744d-11eb-1caa-69b008551d5d
begin
	prob_pass = [0,0,0,0,0,0,0,0]
	for i in 1:N
		prob_pass[pass_match[i]+1] += 1
	end
	prob_pass
end

# ╔═╡ 013a5218-744e-11eb-056b-03f478e07126
begin
	prob_pass_ = [prob_pass[i]/N for i in 1:8] 
	prob_pass_
end

# ╔═╡ 077683f4-744e-11eb-2e7a-0f3b227f999f
#want to store more than 1,000 entries in the database when a million random password attempts are made by a hacker
req_prob = (10^3)/(10^6)

# ╔═╡ 2cb16dbc-744e-11eb-0705-3b593aca723c
ind = count([(prob_pass_[i]>req_prob) for i in 1:8])

# ╔═╡ ab42deba-744e-11eb-3eef-ed94ba8d601a


# ╔═╡ Cell order:
# ╟─775b8e4c-7205-11eb-0de0-2b13ccab429d
# ╠═3a2bcb00-72d1-11eb-083c-2b772d1f9b67
# ╠═b015fa54-744d-11eb-28cc-11ab96479ada
# ╠═b2cefc08-744d-11eb-393e-7549dac81a0b
# ╠═beef4e40-744d-11eb-2757-d573e3315bef
# ╠═d0d3062e-744d-11eb-2b5b-cb9d3ce2ded4
# ╠═c51ba73c-744d-11eb-0722-6b38a9be95e1
# ╠═f7af55c0-744d-11eb-34cb-db32aad3a790
# ╠═fe286632-744d-11eb-1caa-69b008551d5d
# ╠═013a5218-744e-11eb-056b-03f478e07126
# ╠═077683f4-744e-11eb-2e7a-0f3b227f999f
# ╠═2cb16dbc-744e-11eb-0705-3b593aca723c
# ╠═ab42deba-744e-11eb-3eef-ed94ba8d601a

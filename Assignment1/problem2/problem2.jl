### A Pluto.jl notebook ###
# v0.12.20

using Markdown
using InteractiveUtils

# ╔═╡ b3381d2a-6ffe-11eb-2b30-d9f6b04cc3ad
using Random

# ╔═╡ e4ff83d6-7004-11eb-2a5f-395f706407cb
using Plots

# ╔═╡ 83707f50-700a-11eb-2e7d-f9e143a069b7
using StatsBase

# ╔═╡ d9105f3e-7282-11eb-01e1-adb662eac584
md"Q2. (1 point) Consider a usual pack of playing cards. 

We are interested in computing the probability of picking n Jacks (of any suit) when drawing 5 random cards in two cases: (a) without replacement where a drawn card is not put back into the deck, and (b) with replacement where a drawn card is again put back into the deck.

Write Julia code to compute this (experimentally) and report the probabilities for different values n.  "

# ╔═╡ 2d18d79a-6fff-11eb-0bc9-cb47acd75356
 els = [1,2,3,4]

# ╔═╡ 8aa204a4-6fff-11eb-3e46-6326e38dde3d
# function vecin(set)
#   els = [1,2,3,4]
#   res = zeros(Bool,size(els))
#   res[findall(els,set)]=true
#   res
# end

# ╔═╡ 57fcdf34-6ffe-11eb-3d80-ebca2e94d9e6
#With replacement
begin
	# findall(els,[1,3,5,7])
	N = 10^6
	gen_arr = [[rand(1:52) for _ in 1:5] for _ in 1:N]
end

# ╔═╡ 0fc7e268-7003-11eb-26b2-75ddeb918d8d
begin
	gen_arr_bool = [count([els[j] in (gen_arr[i]) for j in 1:4]) for i in 1:N]
end

# ╔═╡ 255f37de-7283-11eb-151c-c5044edc4c82
begin
	wrep = [count([(gen_arr_bool[j] == i-1) for j in 1:N]) for i in 1:5]
	wrep_ = [wrep[i]/N for i in 1:5]
end

# ╔═╡ f2052ab6-7004-11eb-0892-ff959ae4801b
histogram(gen_arr_bool, bins = [0,1,2,3,4,5], normalize=true, legend=false)

# ╔═╡ d5733c0a-7009-11eb-0009-bdbcb2928131
#Without replacement
begin
	# findall(els,[1,3,5,7])
	N_ = 10^6
	gen_arr_ = [sample(1:52, 5, replace = false) for _ in 1:N_]
end

# ╔═╡ d23338b4-700a-11eb-1c2b-6f2ce81b20cb
begin
	gen_arr_bool_ = [count([els[j] in (gen_arr_[i]) for j in 1:4]) for i in 1:N_]
end

# ╔═╡ f456683a-7283-11eb-11ea-057704eb64c0
begin
	worep = [count([(gen_arr_bool_[j] == i-1) for j in 1:N]) for i in 1:5]
	worep_ = [worep[i]/N for i in 1:5]
end

# ╔═╡ eef047e4-700a-11eb-0cd1-792c65d84781
histogram(gen_arr_bool_, bins = [0,1,2,3,4,5], normalize=true, legend=false)

# ╔═╡ 03275982-7283-11eb-12fa-3deeb0cb8e5b
begin
	# histogram(all_prob, normalize=true, legend=false)
	scatter([0,1,2,3,4],wrep_,ma=0.5,label=false,xlabel="number of Jacks drawn", title="Analytical Solution")
	plot!([0,1,2,3,4],wrep_, label=false)
	scatter!([0,1,2,3,4],worep_,ma=0.5,label=false,xlabel="number of Jacks drawn", title="Analytical Solution")
	plot!([0,1,2,3,4],worep_, label=false, color="black")
end

# ╔═╡ Cell order:
# ╟─d9105f3e-7282-11eb-01e1-adb662eac584
# ╠═b3381d2a-6ffe-11eb-2b30-d9f6b04cc3ad
# ╠═2d18d79a-6fff-11eb-0bc9-cb47acd75356
# ╠═8aa204a4-6fff-11eb-3e46-6326e38dde3d
# ╠═57fcdf34-6ffe-11eb-3d80-ebca2e94d9e6
# ╠═0fc7e268-7003-11eb-26b2-75ddeb918d8d
# ╠═255f37de-7283-11eb-151c-c5044edc4c82
# ╠═e4ff83d6-7004-11eb-2a5f-395f706407cb
# ╠═f2052ab6-7004-11eb-0892-ff959ae4801b
# ╠═83707f50-700a-11eb-2e7d-f9e143a069b7
# ╠═d5733c0a-7009-11eb-0009-bdbcb2928131
# ╠═d23338b4-700a-11eb-1c2b-6f2ce81b20cb
# ╠═f456683a-7283-11eb-11ea-057704eb64c0
# ╠═eef047e4-700a-11eb-0cd1-792c65d84781
# ╠═03275982-7283-11eb-12fa-3deeb0cb8e5b

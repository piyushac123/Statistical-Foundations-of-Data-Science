### A Pluto.jl notebook ###
# v0.12.20

using Markdown
using InteractiveUtils

# ╔═╡ 84906b58-700b-11eb-09b9-578d22a72049
using Random

# ╔═╡ af1de7de-700d-11eb-26dd-87e3e26876d1
using Plots

# ╔═╡ 3f8f57c2-73f9-11eb-3090-5fbc931a83b9
md"Q1. (1 point) A popular law called the law of large numbers describes the result of performing the same experiment a large number of times. 

Consider the specific experiment of choosing a random integer and summing it with all previously chosen integers. By writing Julia code, demonstrate to yourself that this sum tends to 0 as we increase the number of chosen numbers. 
"

# ╔═╡ 2aac2f4a-700c-11eb-0a9e-352458854b93
begin
	N = 10^2
	arr = rand(Int, N)
end

# ╔═╡ c2f27bb0-700c-11eb-260f-f14ecc593bcb
arr_ = cumsum(arr)

# ╔═╡ cfcf08a0-700c-11eb-0c14-13e0a31e92c0
arr1 = [arr_[i]/i for i in 1:N]

# ╔═╡ 4911ded4-700d-11eb-31eb-e9a9bd859be2
begin
	# plot(x->x, x->arr1[x], 0, 4, legend=false)
	scatter([1:N],arr1,ma=0.5,label="average")
	plot!([1:N],arr1, label=false)
end

# ╔═╡ Cell order:
# ╠═3f8f57c2-73f9-11eb-3090-5fbc931a83b9
# ╠═84906b58-700b-11eb-09b9-578d22a72049
# ╠═2aac2f4a-700c-11eb-0a9e-352458854b93
# ╠═c2f27bb0-700c-11eb-260f-f14ecc593bcb
# ╠═cfcf08a0-700c-11eb-0c14-13e0a31e92c0
# ╠═af1de7de-700d-11eb-26dd-87e3e26876d1
# ╠═4911ded4-700d-11eb-31eb-e9a9bd859be2

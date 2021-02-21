### A Pluto.jl notebook ###
# v0.12.20

using Markdown
using InteractiveUtils

# ╔═╡ 56e4a7a6-7280-11eb-2cdb-37d18cab8c10
using Plots

# ╔═╡ 0f3f98fa-7282-11eb-2c18-25f668dc3a44
md"Q7. (1 point) The stock market game is quite a delight for a probability exercise and hence we will continue with it for this and the next question. 

Compute the probability of going bankrupt (at least once). Do this with code in Julia, again showing results for different values of p."

# ╔═╡ 32cdeb82-727d-11eb-3ff5-e9367b9d35ff
p_itr = [0,0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9,1]

# ╔═╡ 55fc611a-727d-11eb-313a-cf79ce333ce6
begin
	N = 10^5
	list_val = [[[if(rand() > p) 1 else -1 end for _ in 1:20] for _ in 1:N] for p in p_itr]
end

# ╔═╡ 6bbfe70a-727e-11eb-10f6-434dada04421
cum_list_val = [[cumsum(list_val[i][j]) for j in 1:N] for i in 1:11]

# ╔═╡ bea11250-727e-11eb-39ee-013cd19c5ea3
prob_cum_list_val = [count([(-10 in cum_list_val[i][j]) for j in 1:N])/N for i in 1:11]

# ╔═╡ 56902064-7280-11eb-28e6-6d135a52bee7


# ╔═╡ 23839946-7280-11eb-103d-4394ef7f88ea
begin
	# histogram(all_prob, normalize=true, legend=false)
	scatter(p_itr,prob_cum_list_val,ma=0.5,label=false,xlabel="Probability of lose", ylabel="Probability of going bankrupt (at least once)", title="Analytical Solution")
	plot!(p_itr,prob_cum_list_val, label=false)
end

# ╔═╡ Cell order:
# ╟─0f3f98fa-7282-11eb-2c18-25f668dc3a44
# ╠═32cdeb82-727d-11eb-3ff5-e9367b9d35ff
# ╠═55fc611a-727d-11eb-313a-cf79ce333ce6
# ╠═6bbfe70a-727e-11eb-10f6-434dada04421
# ╠═bea11250-727e-11eb-39ee-013cd19c5ea3
# ╠═56e4a7a6-7280-11eb-2cdb-37d18cab8c10
# ╟─56902064-7280-11eb-28e6-6d135a52bee7
# ╠═23839946-7280-11eb-103d-4394ef7f88ea

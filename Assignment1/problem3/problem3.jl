### A Pluto.jl notebook ###
# v0.12.20

using Markdown
using InteractiveUtils

# ╔═╡ 9227c222-72cf-11eb-05d9-1d7ec1bfd2c5
using Plots

# ╔═╡ a73a4d74-72cf-11eb-13ef-81a8b69aa4e1
using StatsBase

# ╔═╡ c60d86fa-72cd-11eb-15b1-316de0b6a429
md"Q3. (1 point) Let us continue with the previous question. Instead of running experiments, we would like to theoretically compute the probabilities. 


Go through the popular probability distributions and identify the ones that correspond to the two cases in the previous question. Then compare the values you got from your experiments with the theoretical ones. Are your results similar?"

# ╔═╡ 51eff102-72cf-11eb-23b7-f755db4fda1f
md"Experimental Solution"

# ╔═╡ 5ac76c06-72cf-11eb-05e6-d7f35cf0a6fb
md"With Replacement"

# ╔═╡ 47c11206-72cf-11eb-2739-7195f5468e1d
 els = [1,2,3,4]

# ╔═╡ 77488132-72cf-11eb-04b7-41709eafa01e
begin
	N = 10^6
	gen_arr = [[rand(1:52) for _ in 1:5] for _ in 1:N]
end

# ╔═╡ 83a1a574-72cf-11eb-34b8-1f4fb2646d38
begin
	gen_arr_bool = [count([els[j] in (gen_arr[i]) for j in 1:4]) for i in 1:N]
end

# ╔═╡ 89807ede-72cf-11eb-18a9-6df7fc9e2182
begin
	wrep = [count([(gen_arr_bool[j] == i-1) for j in 1:N]) for i in 1:5]
	wrep_ = [wrep[i]/N for i in 1:5]
end

# ╔═╡ 66f461f0-72cf-11eb-2525-0de88c87c877
md"Without Replacement"

# ╔═╡ 4e049e60-72cf-11eb-3b10-95475ccdc9bd
begin
	N_ = 10^6
	gen_arr_ = [sample(1:52, 5, replace = false) for _ in 1:N_]
end

# ╔═╡ b4440636-72cf-11eb-3797-0b2f070d2fce
begin
	gen_arr_bool_ = [count([els[j] in (gen_arr_[i]) for j in 1:4]) for i in 1:N_]
end

# ╔═╡ be31fe78-72cf-11eb-34c7-6bf678c871b7
begin
	worep = [count([(gen_arr_bool_[j] == i-1) for j in 1:N]) for i in 1:5]
	worep_ = [worep[i]/N for i in 1:5]
end

# ╔═╡ 3743b6f4-72cf-11eb-3a9b-7502ae80ed42
md"Theoretical Solution"

# ╔═╡ ecab45ae-72cd-11eb-3d87-c9565777eaff
md"With Replacement"

# ╔═╡ f71c951a-72cd-11eb-3535-33f6e422f333
prob_wrep = [(binomial(4+r-1,r)*binomial(48+(5-r)-1,(5-r)))/(binomial(56,5)) for r in 0:4]

# ╔═╡ e27c5982-72ce-11eb-09b7-0dff07303b91
md"Without Replacement"

# ╔═╡ ed520848-72ce-11eb-15b7-7770720d76fa
prob_worep = [(binomial(4,r)*binomial(48,(5-r)))/(binomial(52,5)) for r in 0:4]

# ╔═╡ 289d47be-72cf-11eb-3264-57cd14d017e9
begin
	# histogram(all_prob, normalize=true, legend=false)
	scatter([0,1,2,3,4],wrep_,ma=0.5,label=false,xlabel="number of Jacks drawn", title="With Replacement")
	plot!([0,1,2,3,4],wrep_, label="Analytical solution")
	scatter!([0,1,2,3,4],prob_wrep,ma=0.5,label=false)
	plot!([0,1,2,3,4],prob_wrep, label="Theoretical solution", color="black")
end

# ╔═╡ 98c54180-72d0-11eb-1e85-e1351fe4f53c
begin
	# histogram(all_prob, normalize=true, legend=false)
	scatter([0,1,2,3,4],worep_,ma=0.5,label=false,xlabel="number of Jacks drawn", title="Without Replacement")
	plot!([0,1,2,3,4],worep_, label="Analytical solution")
	scatter!([0,1,2,3,4],prob_worep,ma=0.5,label=false)
	plot!([0,1,2,3,4],prob_worep, label="Theoretical solution", color="black")
end

# ╔═╡ Cell order:
# ╟─c60d86fa-72cd-11eb-15b1-316de0b6a429
# ╠═9227c222-72cf-11eb-05d9-1d7ec1bfd2c5
# ╠═a73a4d74-72cf-11eb-13ef-81a8b69aa4e1
# ╟─51eff102-72cf-11eb-23b7-f755db4fda1f
# ╟─5ac76c06-72cf-11eb-05e6-d7f35cf0a6fb
# ╠═47c11206-72cf-11eb-2739-7195f5468e1d
# ╠═77488132-72cf-11eb-04b7-41709eafa01e
# ╠═83a1a574-72cf-11eb-34b8-1f4fb2646d38
# ╠═89807ede-72cf-11eb-18a9-6df7fc9e2182
# ╟─66f461f0-72cf-11eb-2525-0de88c87c877
# ╠═4e049e60-72cf-11eb-3b10-95475ccdc9bd
# ╠═b4440636-72cf-11eb-3797-0b2f070d2fce
# ╠═be31fe78-72cf-11eb-34c7-6bf678c871b7
# ╟─3743b6f4-72cf-11eb-3a9b-7502ae80ed42
# ╟─ecab45ae-72cd-11eb-3d87-c9565777eaff
# ╠═f71c951a-72cd-11eb-3535-33f6e422f333
# ╟─e27c5982-72ce-11eb-09b7-0dff07303b91
# ╠═ed520848-72ce-11eb-15b7-7770720d76fa
# ╠═289d47be-72cf-11eb-3264-57cd14d017e9
# ╠═98c54180-72d0-11eb-1e85-e1351fe4f53c

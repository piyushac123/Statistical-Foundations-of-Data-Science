### A Pluto.jl notebook ###
# v0.12.20

using Markdown
using InteractiveUtils

# ╔═╡ 68beaf14-73f0-11eb-1fe2-af200edac328
using Plots

# ╔═╡ 42b4b392-73e9-11eb-3343-996129836bb5
md"Q8. (2 point) In this last problem of this assignment, let us work out some conditional probability.  

We will combine the settings from Q6 and Q7. Given that you knew that you do not go bankrupt even once, what is the probability that you end up with Rs. 10 or more at the end of 20 days? 

First share your overall idea, then the code snippet which helps you compute this, and finally the answer and how it relates to the answers in the previous two questions
"

# ╔═╡ 1b09f3a4-727a-11eb-1057-33a34fadd1c2
p_itr = [0,0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9,1]

# ╔═╡ 08a2d9f8-727d-11eb-00c7-73a7cec19672


# ╔═╡ 4e6caf02-727a-11eb-1220-cf8ce0ce4a52
begin
	N = 10^5
	list_val = [[[if(rand() > p) 1 else -1 end for _ in 1:20] for _ in 1:N] for p in p_itr]
end

# ╔═╡ 7bafd7c4-73eb-11eb-3b7d-6fe904f6cdbb
cum_list_val = [[cumsum(list_val[i][j]) for j in 1:N] for i in 1:11]

# ╔═╡ 835c5c5e-73eb-11eb-2fc6-cde7c67cb7f4
prob_A_and_notB = [count([(-10 ∉ cum_list_val[i][j]) && (last(cum_list_val[i][j]) >= 0) for j in 1:N])/N for i in 1:11]

# ╔═╡ cdf0340c-73eb-11eb-2556-c9ebd41de211
prob_notB = [count([(-10 ∉ cum_list_val[i][j]) for j in 1:N])/N for i in 1:11]

# ╔═╡ 7207a388-73ef-11eb-001b-ad5d1fa187a7
prob_A_cond_notB = [(prob_A_and_notB[i]/prob_notB[i]) for i in 1:11]

# ╔═╡ b6ebb926-73ef-11eb-284c-0744c35d0fa2
begin
	# histogram(all_prob, normalize=true, legend=false)
	scatter(p_itr,prob_A_cond_notB,ma=0.5,label=false,xlabel="Probability of lose", ylabel="Conditional Probability", title="Analytical Solution")
	plot!(p_itr,prob_A_cond_notB, label=false)
end

# ╔═╡ 08a2cfa8-727d-11eb-38e4-2b1d82a69013


# ╔═╡ 08a2bf2c-727d-11eb-1a54-d7277eac295f


# ╔═╡ 08a2a9b0-727d-11eb-06c1-9b79bf04127b


# ╔═╡ Cell order:
# ╟─42b4b392-73e9-11eb-3343-996129836bb5
# ╠═1b09f3a4-727a-11eb-1057-33a34fadd1c2
# ╟─08a2d9f8-727d-11eb-00c7-73a7cec19672
# ╠═4e6caf02-727a-11eb-1220-cf8ce0ce4a52
# ╠═7bafd7c4-73eb-11eb-3b7d-6fe904f6cdbb
# ╠═835c5c5e-73eb-11eb-2fc6-cde7c67cb7f4
# ╠═cdf0340c-73eb-11eb-2556-c9ebd41de211
# ╠═7207a388-73ef-11eb-001b-ad5d1fa187a7
# ╠═68beaf14-73f0-11eb-1fe2-af200edac328
# ╠═b6ebb926-73ef-11eb-284c-0744c35d0fa2
# ╟─08a2cfa8-727d-11eb-38e4-2b1d82a69013
# ╟─08a2bf2c-727d-11eb-1a54-d7277eac295f
# ╟─08a2a9b0-727d-11eb-06c1-9b79bf04127b

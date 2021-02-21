### A Pluto.jl notebook ###
# v0.12.20

using Markdown
using InteractiveUtils

# ╔═╡ 00c02de0-726d-11eb-19ff-132441377418
using Plots

# ╔═╡ 3481ac52-7282-11eb-2997-a75414b54a56
md"Q6. (2 points + 2 bonus points) Let us talk now about stock markets, which many would (and some rich people would disagree) is a game of chance. 

You start with Rs 10 and play an investment game for 20 days wherein each day you may lose Re 1 with a probability of p or gain Re 1 with a probability of 1 - p.  

What is the probability that at the end of 20 days, you have at least Rs 10 with you? Notice that we have not specified p, and hence you are required to compute the probability for a range of values of p. You can also attempt a symbolic answer in terms of p for a bonus of 2 marks 🥇🥇.

If you think about this problem carefully, you will have a doubt: What happens if you went bankrupt in between (i.e., you had lost all your Rs 10)? For this question, assume that you can continue to play the game even if you are bankrupt. 
"

# ╔═╡ d3e44fb6-726e-11eb-09f1-a15feb067983
md"Theoretical Calculation"

# ╔═╡ 2a1851d2-726a-11eb-1f25-19daf8f3b8b7
p_itr = [0,0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9,1]

# ╔═╡ 5ce5622a-7268-11eb-2f9f-b1a65cf8ed21
# all_prob = [binomial(20,x) for p in range(0, 1, 0.1)]
all_prob = [sum([binomial(20,x)*(p^x)*((1-p)^(20-x)) for x in 0:10]) for p in p_itr]

# ╔═╡ e5faef1e-726b-11eb-1d36-5177f45a1769
begin
	# histogram(all_prob, normalize=true, legend=false)
	scatter(p_itr,all_prob,ma=0.5,label=false,xlabel="Probability of lose", ylabel="Probability of restoring atleast Rs 10 at the end of 20 days", title="Theoretical Solution")
	plot!(p_itr,all_prob, label=false)
end

# ╔═╡ f40665e0-726e-11eb-15ac-071442e40ef1
md"***Experimental calculation"

# ╔═╡ 7b746d04-7276-11eb-2673-857a75754968
begin
	N = 10^5
	final_prob = [count([(count([(rand() > p) for _ in 1:20]) >= 10) for _ in 1:N])/N for p in p_itr]
end

# ╔═╡ 10ef9e8e-7278-11eb-35e5-c36d0b1a9652
begin
	# histogram(all_prob, normalize=true, legend=false)
	scatter(p_itr,final_prob,ma=0.5,label=false,xlabel="Probability of lose", ylabel="Probability of restoring atleast Rs 10 at the end of 20 days", title="Analytical Solution")
	plot!(p_itr,final_prob, label=false)
end

# ╔═╡ ffb3659e-726e-11eb-35fa-11046d25ac06
# begin
# 	N = 2*10^2
# 	temp_arr = [-1,1]
# 	arr_stock = [sum([temp_arr[rand(1:2)] for _ in 1:20]) for _ in 1:N]
# 	final_stock = [arr_stock[i] + 10 for i in 1:N]
# end

# ╔═╡ 268507f4-7271-11eb-127a-b11650adc704
# final_prob_cum = [count([(final_stock[j] >= 10) for j in 1:i])/i for i in 1:N]

# ╔═╡ 5c5e380a-7271-11eb-3ef9-8912aed69b99
# begin
# 	# histogram(all_prob, normalize=true, legend=false)
# 	scatter([1:N],final_prob_cum,ma=0.5,label=false,xlabel="number of attempts")
# 	plot!([1:N],final_prob_cum, label=false)
# end

# ╔═╡ 3612d16c-7276-11eb-216d-e714ca6f4855
# rand()

# ╔═╡ Cell order:
# ╟─3481ac52-7282-11eb-2997-a75414b54a56
# ╟─d3e44fb6-726e-11eb-09f1-a15feb067983
# ╠═2a1851d2-726a-11eb-1f25-19daf8f3b8b7
# ╠═5ce5622a-7268-11eb-2f9f-b1a65cf8ed21
# ╠═00c02de0-726d-11eb-19ff-132441377418
# ╠═e5faef1e-726b-11eb-1d36-5177f45a1769
# ╟─f40665e0-726e-11eb-15ac-071442e40ef1
# ╠═7b746d04-7276-11eb-2673-857a75754968
# ╠═10ef9e8e-7278-11eb-35e5-c36d0b1a9652
# ╠═ffb3659e-726e-11eb-35fa-11046d25ac06
# ╠═268507f4-7271-11eb-127a-b11650adc704
# ╠═5c5e380a-7271-11eb-3ef9-8912aed69b99
# ╠═3612d16c-7276-11eb-216d-e714ca6f4855

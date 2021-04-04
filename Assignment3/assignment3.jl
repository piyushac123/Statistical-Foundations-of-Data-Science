### A Pluto.jl notebook ###
# v0.12.20

using Markdown
using InteractiveUtils

# ╔═╡ abced980-94ef-11eb-0745-2df34fe7a34b
using Distributions, Plots, PlutoUI, QuadGK, Random, CSV, Dates, DataFrames, StatsBase

# ╔═╡ 92e6815c-94ef-11eb-0eba-c9d1d57e3645
md"**Assignment 3**"

# ╔═╡ 2ce683f2-94ef-11eb-10f6-6936e4e77594
md"Question no. 1"

# ╔═╡ bffb933c-94ef-11eb-385e-e9296d30b1fd
kld(d_1, d_2, x1, x2) = quadgk(x->(pdf(d_1, x)*log(pdf(d_1,x)/pdf(d_2,x))),x1,x2)[1]

# ╔═╡ c917c556-94ef-11eb-0154-e12ac3854e81
final = [kld(Normal(), TDist(i), -10, 10) for i in 1:5]

# ╔═╡ 5d18d7de-94ef-11eb-3678-e33f2f6ac829
md"Question no. 2"

# ╔═╡ 33b97a8a-9527-11eb-1131-536b40bc030c
conv(d_1,d_2,x) = quadgk(k->(pdf(d_1, x-k)*pdf(d_2,k)), (-15,15)...)[1]

# ╔═╡ 4ca2c18c-9536-11eb-07a7-8fcd583258d4
begin
	begin
		norm_d_ = [conv(Uniform(0,1), Uniform(0,1), x) for x in -15:0.01:15]
		all_conv_d_ = []
		push!(all_conv_d_, fit(Normal, norm_d_))
		for i in 1:9
			conv_d_ = [conv(all_conv_d_[i], Uniform(0,1), x) for x in -15:0.01:15]
			push!(all_conv_d_, fit(Normal, conv_d_))
		end
		# conv_d_1 = [conv.(fit(Normal,conv_d), Uniform(0,1), x) for x in -15:0.01:15]
	end
end

# ╔═╡ 978a4dc8-9536-11eb-2fa1-49a8f8c0102b
kld_dists_ = [kld(all_conv_d_[i] , Normal(), (mean(all_conv_d_[i])-2*std(all_conv_d_[i])), (mean(all_conv_d_[i])+2*std(all_conv_d_[i]))) for i in 1:9]

# ╔═╡ a880a3d4-9536-11eb-13f8-47f1f06d0f8a
plot([2:10],kld_dists_, label="KL-Divergence", xlabel="number of random variables", ylabel="KL-Divergence of sum of n-random variables")

# ╔═╡ 51e4ad9e-94f1-11eb-3097-dd840d90670d
sgn(x,k) = if x<k return -1 elseif x==k return 0 else return 1 end

# ╔═╡ 4c13a2bc-94f1-11eb-15c4-37cd966f7e71
pdf_sum_uni(x,n) = (0.5/factorial(n-1))*sum([((-1)^k)*binomial(n,k)*((x-k)^(n-1))*sgn(x,k) for k in 0:n])

# ╔═╡ 3b5021f8-94f1-11eb-1a32-d557f1f741ad
kld_sum_uni(n) = quadgk(x->(pdf_sum_uni(x, n)*log(pdf_sum_uni(x,n)/pdf(Normal(n/2,sqrt(n/12)),x))),(n/2)-(2.2*sqrt(n/12)),(n/2)+(2.2*sqrt(n/12)))

# ╔═╡ 577c787c-94f1-11eb-20a1-ad6dc217239a
kld_sum = [kld_sum_uni(n)[1] for n in 2:10]

# ╔═╡ 5d1f407a-94f1-11eb-1d17-cb2296b75d74
plot([2:10],kld_sum, label="KL-Divergence", xlabel="number of random variables", ylabel="KL-Divergence of sum of n-random variables")

# ╔═╡ 6ecee8c2-94ef-11eb-14f6-b350ee10f37d
md"Question no. 3"

# ╔═╡ d67cabbc-94ef-11eb-343f-07afe8650bce
begin
	freq = [60, 110, 160, 210, 260, 300, 350, 460, 400, 260, 120, 80, 40, 30, 25, 15, 11, 7, 5, 3, 2, 1]  
	freq_dist = []
	for i in 1:length(freq)
		append!(freq_dist,rand(Uniform((i-1)*0.1,i*0.1),freq[i]))
	end
	mode = argmax(freq)
	freq_dist
end

# ╔═╡ 03846ea6-94f0-11eb-3800-35b5cfa7f7c6
mean(freq_dist)

# ╔═╡ 0b098882-94f0-11eb-06e5-abc6ddfd4fa5
median(freq_dist)

# ╔═╡ f7d205dc-94ef-11eb-0663-334faa92d591
begin
	histogram(freq_dist,bins=20, label="Distribution", xlabel="Data Distribution", ylabel="Data Frequency", title="Right skewed data with (Mean<Median)")
	plot!([mean(freq_dist),mean(freq_dist)],[0,freq[Int(ceil(mean(freq_dist)*10))]], line=(4, :dot, :green), label="Mean")
	plot!([median(freq_dist),median(freq_dist)],[0,freq[Int(ceil(median(freq_dist)*10))]], line=(4, :dot, :brown), label="Median")
	plot!([((mode-1)*0.1+mode*0.1)/2,((mode-1)*0.1+mode*0.1)/2],[0,freq[mode]], line=(4, :dot, :yellow), label="Mode")
end

# ╔═╡ 716977a0-94ef-11eb-0b0e-7b6a1709fb48
md"Question no. 4"

# ╔═╡ 25e4adda-94f0-11eb-240e-e7b305efee81
samp_uniform = [[rand(Uniform(0,1)) for _ in 1:30] for _ in 1:10000]

# ╔═╡ 2f4b5b30-94f0-11eb-202a-8b51cff54e78
range_samp(x) = maximum(x) - minimum(x)

# ╔═╡ 3426c4be-94f0-11eb-31ce-4372cafc18df
samp_range = [range_samp(samp_uniform[i]) for i in 1:size(samp_uniform)[1]]

# ╔═╡ 38c862de-94f0-11eb-293f-85df05501682
begin
	freq_bin = [0 for _ in 1:20]
	for i in 1:length(samp_range) freq_bin[Int(ceil((samp_range[i]-0.6)*50))] += 1 end
	freq_mode = argmax(freq_bin)
	samp_mode = ((freq_mode-1)*0.02+freq_mode*0.02+1.2)/2
end

# ╔═╡ 41478570-94f0-11eb-04b3-b94e6ae5e89c
begin
	samp_mean = mean(samp_range)
	samp_std = std(samp_range)
	samp_median = median(samp_range)
	histogram(samp_range, bins=20, xlabel="Ranges of given samples", ylabel="Frequency of Ranges of given samples",title="\nMean : "*string(samp_mean)*"\nMedian : "*string(samp_median)*"\nMode : "*string(samp_mode)*"")
	scatter!([samp_mean], [0, 1], label="Mean", legend=:topleft)
	scatter!([samp_median], [0, 1], label="Median", legend=:topleft)
	scatter!([samp_mode], [0, 1], label="Mode", legend=:topleft)
end

# ╔═╡ 741336d0-94ef-11eb-1139-d518664b7d0b
md"Question no. 5"

# ╔═╡ 7734cfd6-94ef-11eb-2ece-2b567172dd90
md"Question no. 6"

# ╔═╡ 5f82c504-94f0-11eb-0a36-a3d495f5d666
begin
	df_covid = DataFrame(CSV.File("states.csv"))
	unique(df_covid.State)
	df_covid
end

# ╔═╡ 7274e78c-94f0-11eb-2942-bdc848e16eb8
begin
	week_yr = [(Dates.week(df_covid[i,1]), Dates.year(df_covid[i,1])) for i in 1:size(df_covid)[1]]
	insertcols!(df_covid, 1, :Week_and_Year => week_yr, makeunique=true)
end

# ╔═╡ 7713f38c-94f0-11eb-1084-679b75cc7e46
begin
	df_week_state = DataFrame(Week_and_Year = unique(df_covid.Week_and_Year))
	col_names = unique(df_covid.State)
	insert!(col_names, 1, "Week_and_Year")
	for i in 1:size(col_names)[1]-1 insertcols!(df_week_state, 1+i, :d => [0 for _ in size(unique(df_covid.Week_and_Year))[1]], makeunique=true) end
	rename!(df_week_state, col_names)
	df_week_state
end

# ╔═╡ 7da97d16-94f0-11eb-1ca2-af87eeba23cb
begin
	ind = 1
	for i in 1:size(df_covid)[1]
		for j in 1:size(df_week_state)[1]
			if(df_week_state.Week_and_Year[j][1] .== df_covid[i, "Week_and_Year"][1] && df_week_state.Week_and_Year[j][2] .== df_covid[i, "Week_and_Year"][2])
				ind = j
			end
		end
		df_week_state[ind, df_covid[i,"State"]] += df_covid[i, "Confirmed"] 
	end
	df_week_state
end

# ╔═╡ cf37a054-94f0-11eb-39ac-c9ccc528b905
begin
	cov_mat = [[cov(df_week_state[:, i], df_week_state[:, j]) for j in 2:size(df_week_state)[2]] for i in 2:size(df_week_state)[2]]
	cor_mat = [[cor(df_week_state[:, i], df_week_state[:, j]) for j in 2:size(df_week_state)[2]] for i in 2:size(df_week_state)[2]]
	spearman_cor_mat = [[corspearman(df_week_state[:, i], df_week_state[:, j]) for j in 2:size(df_week_state)[2]] for i in 2:size(df_week_state)[2]]
end

# ╔═╡ e01488f6-94f0-11eb-37bb-43f0f9abcc4f
heatmap(hcat(cov_mat...)', xlabel="State number", ylabel="State number", title="Covariance Matrix")

# ╔═╡ e287e862-94f0-11eb-1438-dff6cff33459
heatmap(hcat(cor_mat...)', xlabel="State number", ylabel="State number", title="Correlation Matrix")

# ╔═╡ e80837ce-94f0-11eb-3ecb-4fc80de72c05
heatmap(hcat(spearman_cor_mat...)', xlabel="State number", ylabel="State number", title="Spearman Correlation Matrix")

# ╔═╡ ed13de62-94f0-11eb-15c9-e5622de7c634
scatter(df_week_state[:, 2], df_week_state[:, 3])

# ╔═╡ 7a1dbf1e-94ef-11eb-1aee-e36f22a3b02e
md"Question no. 7"

# ╔═╡ 07f405e2-94f1-11eb-02a5-21ddf05b2d84
function OneSidedTail_(d_,X)
	for x in -5:0.01:5 
		if(cdf(d_, x) > ((100-X)/100)) 
			return x
		end 
	end
end

# ╔═╡ 0ab191ce-94f1-11eb-1f27-4567813d40e4
OneSidedTail_(Normal(),95)

# ╔═╡ 0f115526-94f1-11eb-0ee6-390cac820e17
OneSidedTail_(TDist(10),95)

# ╔═╡ 1b26abc4-94f1-11eb-0729-7d6c474f2d65
begin
	plot(x->x, x->pdf(Normal(), x), -5, -1, label="Normal")
	plot!(x->x, x->pdf(TDist(10), x), -5, -1, label="T-Dist")
	plot!([OneSidedTail_(Normal(),95), OneSidedTail_(Normal(),95)], [0, pdf(Normal(), OneSidedTail_(Normal(),95))],  line=(4, :dot, :green), label="OneSidedTail(Normal)")
	plot!([OneSidedTail_(TDist(10),95), OneSidedTail_(TDist(10),95)], [0, pdf(Normal(), OneSidedTail_(TDist(10),95))],  line=(4, :dot, :brown), label="OneSidedTail(T_Dist)")
end

# ╔═╡ 1d77dd56-94f1-11eb-26e0-cbe17057ca2b
OneSidedTail(d_,x) = cquantile(d_, x)

# ╔═╡ 2777df18-94f1-11eb-1e60-cb165dc76e92
OneSidedTail(Normal(),0.95)

# ╔═╡ 2c2068dc-94f1-11eb-187d-41e485beae6b
OneSidedTail(TDist(10),0.95)

# ╔═╡ 313bbe2a-94f1-11eb-1de5-57ef683cf370
begin
	plot(x->x, x->pdf(Normal(), x), -5, -1, label="Normal")
	plot!(x->x, x->pdf(TDist(10), x), -5, -1, label="T-Dist")
	plot!([OneSidedTail(Normal(),0.95), OneSidedTail(Normal(),0.95)], [0, pdf(Normal(), OneSidedTail(Normal(),0.95))],  line=(4, :dot, :green), label="OneSidedTail(Normal)")
	plot!([OneSidedTail(TDist(10),0.95), OneSidedTail(TDist(10),0.95)], [0, pdf(Normal(), OneSidedTail(TDist(10),0.95))],  line=(4, :dot, :brown), label="OneSidedTail(T_Dist)")
end

# ╔═╡ Cell order:
# ╟─92e6815c-94ef-11eb-0eba-c9d1d57e3645
# ╟─2ce683f2-94ef-11eb-10f6-6936e4e77594
# ╠═abced980-94ef-11eb-0745-2df34fe7a34b
# ╠═bffb933c-94ef-11eb-385e-e9296d30b1fd
# ╠═c917c556-94ef-11eb-0154-e12ac3854e81
# ╟─5d18d7de-94ef-11eb-3678-e33f2f6ac829
# ╠═33b97a8a-9527-11eb-1131-536b40bc030c
# ╠═4ca2c18c-9536-11eb-07a7-8fcd583258d4
# ╠═978a4dc8-9536-11eb-2fa1-49a8f8c0102b
# ╠═a880a3d4-9536-11eb-13f8-47f1f06d0f8a
# ╠═3b5021f8-94f1-11eb-1a32-d557f1f741ad
# ╠═4c13a2bc-94f1-11eb-15c4-37cd966f7e71
# ╠═51e4ad9e-94f1-11eb-3097-dd840d90670d
# ╠═577c787c-94f1-11eb-20a1-ad6dc217239a
# ╠═5d1f407a-94f1-11eb-1d17-cb2296b75d74
# ╟─6ecee8c2-94ef-11eb-14f6-b350ee10f37d
# ╠═d67cabbc-94ef-11eb-343f-07afe8650bce
# ╠═03846ea6-94f0-11eb-3800-35b5cfa7f7c6
# ╠═0b098882-94f0-11eb-06e5-abc6ddfd4fa5
# ╠═f7d205dc-94ef-11eb-0663-334faa92d591
# ╟─716977a0-94ef-11eb-0b0e-7b6a1709fb48
# ╠═25e4adda-94f0-11eb-240e-e7b305efee81
# ╠═2f4b5b30-94f0-11eb-202a-8b51cff54e78
# ╠═3426c4be-94f0-11eb-31ce-4372cafc18df
# ╠═38c862de-94f0-11eb-293f-85df05501682
# ╠═41478570-94f0-11eb-04b3-b94e6ae5e89c
# ╟─741336d0-94ef-11eb-1139-d518664b7d0b
# ╟─7734cfd6-94ef-11eb-2ece-2b567172dd90
# ╠═5f82c504-94f0-11eb-0a36-a3d495f5d666
# ╠═7274e78c-94f0-11eb-2942-bdc848e16eb8
# ╠═7713f38c-94f0-11eb-1084-679b75cc7e46
# ╠═7da97d16-94f0-11eb-1ca2-af87eeba23cb
# ╠═cf37a054-94f0-11eb-39ac-c9ccc528b905
# ╠═e01488f6-94f0-11eb-37bb-43f0f9abcc4f
# ╠═e287e862-94f0-11eb-1438-dff6cff33459
# ╠═e80837ce-94f0-11eb-3ecb-4fc80de72c05
# ╠═ed13de62-94f0-11eb-15c9-e5622de7c634
# ╟─7a1dbf1e-94ef-11eb-1aee-e36f22a3b02e
# ╠═07f405e2-94f1-11eb-02a5-21ddf05b2d84
# ╠═0ab191ce-94f1-11eb-1f27-4567813d40e4
# ╠═0f115526-94f1-11eb-0ee6-390cac820e17
# ╠═1b26abc4-94f1-11eb-0729-7d6c474f2d65
# ╠═1d77dd56-94f1-11eb-26e0-cbe17057ca2b
# ╠═2777df18-94f1-11eb-1e60-cb165dc76e92
# ╠═2c2068dc-94f1-11eb-187d-41e485beae6b
# ╠═313bbe2a-94f1-11eb-1de5-57ef683cf370

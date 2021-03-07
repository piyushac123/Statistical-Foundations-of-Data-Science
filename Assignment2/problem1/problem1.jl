### A Pluto.jl notebook ###
# v0.12.20

using Markdown
using InteractiveUtils

# ╔═╡ b1e3a6aa-7a41-11eb-25f8-d94d42c9d08e
using DataFrames

# ╔═╡ 087e5576-7a46-11eb-1a88-e14caa744274
new_names = ["religion", "<\$10k", "\$10-20k", "\$20-30k", "\$30-40k", "\$40-50k", "\$50-75k"]

# ╔═╡ f7299b2c-7a41-11eb-2ffc-cf843f09a2e8
begin
	df3 = DataFrame(religion = String[], a1 = Int[], a2 = Int[], a3 = Int[], a4 = Int[], a5 = Int[], a6 = Int[])
	push!(df3,("Agnostic",27 ,  34 ,  60 ,  81 ,  76 , 137))
	push!(df3,("Atheist",12 ,  27 ,  37 ,  52 ,  35 ,  70))
	push!(df3,("Buddhist",27 ,  21 ,  30 ,  34 ,  33 ,  58))
	push!(df3,("Catholic",418 , 617 , 732 , 670 , 638 , 1116))
	push!(df3,("Don’t know/refused",15 ,  14 ,  15 ,  11 ,  10 ,  35))
	push!(df3,("Evangelical Prot",575 , 869 , 1064 , 982 , 881 , 1486))
	push!(df3,( "Hindu",1 ,   9 ,   7 ,   9 ,  11 ,  34))
	push!(df3,("Historically Black Prot",228 , 244 , 236 , 238 , 197 , 223))
	push!(df3,("Jehovah's Witness",20 ,  27 ,  24 ,  24 ,  21 ,  30))
	push!(df3,("Jewish", 19 ,  19 ,  25 ,  25 ,  30 ,  95))
end

# ╔═╡ 8edb9200-7a5a-11eb-10fe-d541ae743f47
names(df3)

# ╔═╡ dd38abde-7a57-11eb-117b-0912db799a48
rename!(df3, new_names)

# ╔═╡ 35a63498-7a54-11eb-2461-1fe35ad97b78
names(df3)

# ╔═╡ f67dc4aa-7b09-11eb-11ca-7f5d5883f6aa
df1 = select(df3, :religion => (x -> x) => :religion)

# ╔═╡ 880c95b2-7b0b-11eb-2022-e528e3a03d02
insertcols!(df1, 1, :Index => 1:10, makeunique=true)

# ╔═╡ 99e2dd66-7b0b-11eb-3c29-dfefc1d94215
df2 = DataFrame(Index = [x for x in 1:10 for _ in 1:6], income = [names(df3)[i] for _ in 1:10 for i in 2:7], freq = [df3[i,j] for i in 1:10 for j in 2:7])

# ╔═╡ 50a85146-7b11-11eb-1348-83200472d1f9
begin
	final = innerjoin(df1, df2, on = :Index)[:,2:4]
	final
end

# ╔═╡ 7d839152-7a45-11eb-07d1-4bcebbea991e
# s = open("tidy-data-master/data/pew-raw.tex") do file
#     read(file, String)
# end

# ╔═╡ Cell order:
# ╠═b1e3a6aa-7a41-11eb-25f8-d94d42c9d08e
# ╠═087e5576-7a46-11eb-1a88-e14caa744274
# ╠═f7299b2c-7a41-11eb-2ffc-cf843f09a2e8
# ╠═8edb9200-7a5a-11eb-10fe-d541ae743f47
# ╠═dd38abde-7a57-11eb-117b-0912db799a48
# ╠═35a63498-7a54-11eb-2461-1fe35ad97b78
# ╠═f67dc4aa-7b09-11eb-11ca-7f5d5883f6aa
# ╠═880c95b2-7b0b-11eb-2022-e528e3a03d02
# ╠═99e2dd66-7b0b-11eb-3c29-dfefc1d94215
# ╠═50a85146-7b11-11eb-1348-83200472d1f9
# ╠═7d839152-7a45-11eb-07d1-4bcebbea991e

### A Pluto.jl notebook ###
# v0.12.20

using Markdown
using InteractiveUtils

# ╔═╡ 8262fe0c-7d05-11eb-2338-f5527565586c
using DataFrames

# ╔═╡ 9b1444d8-7d05-11eb-1c7c-a98cd1a0284d
using JSON

# ╔═╡ f3e3d540-7d05-11eb-2009-f715814d54ea
using HTTP

# ╔═╡ 00f47156-7dab-11eb-2c6f-edbda15d81c0
using Dates

# ╔═╡ 8720320a-7dac-11eb-2433-2d0e6f5f9981
using Statistics

# ╔═╡ cd994b7e-7d05-11eb-142d-0f06607fdb6c
begin
	resp = HTTP.get("https://api.covid19india.org/data.json")
	str = String(resp.body)
	json_source = JSON.Parser.parse(str)
end

# ╔═╡ 562bc384-7d08-11eb-335d-ebca335405cd
json_source["cases_time_series"]

# ╔═╡ 2d2b544e-7d09-11eb-073c-2b87729fff1a
cases = reduce(vcat, DataFrame.(json_source["cases_time_series"]))

# ╔═╡ 302f082e-7daa-11eb-3f3d-15bb498dc123
dates = Date.(cases.dateymd, "y-m-d")

# ╔═╡ 61208bfa-7dab-11eb-354f-5787b1fab72b
begin
	yrs_mon = [yearmonth(d) for d in dates]
	insertcols!(cases, 1, :Year_and_Month => yrs_mon, makeunique=true)
	# mon = [yearmonth(d)[2] for d in dates]
	# insertcols!(cases, 1, :Month => mon, makeunique=true)
end

# ╔═╡ 714c62bc-7db3-11eb-1197-85275b02cd68
cases[:,3:5]

# ╔═╡ b7c6be18-7dac-11eb-2742-bb95bb3b9d84
begin
	cases.dailyconfirmed = parse.(Int64, cases[:,2])
	cases.dailydeceased = parse.(Int64, cases[:,3])
	cases.dailyrecovered = parse.(Int64, cases[:,4])
	# cases[!,:dailyconfirmed] = convert.(Int64,cases[!,:dailyconfirmed])
end

# ╔═╡ 820a7a84-7dad-11eb-38b7-b34a0d372808
cases

# ╔═╡ 200c5c38-7dac-11eb-2051-c5eb81f79d16
gdf = groupby(cases, :Year_and_Month)

# ╔═╡ 565a91ce-7dac-11eb-3cd2-fd3f9ba54bd0
combine(gdf, :dailyconfirmed => sum, :dailydeceased => sum, :dailyrecovered => sum)

# ╔═╡ 7c9ff086-7d11-11eb-27cc-3b15f23c0f00
# df = [!, cases[occursin("January", cases[:date])] for _ in 1:12]

# ╔═╡ Cell order:
# ╠═8262fe0c-7d05-11eb-2338-f5527565586c
# ╠═9b1444d8-7d05-11eb-1c7c-a98cd1a0284d
# ╠═f3e3d540-7d05-11eb-2009-f715814d54ea
# ╠═cd994b7e-7d05-11eb-142d-0f06607fdb6c
# ╠═562bc384-7d08-11eb-335d-ebca335405cd
# ╠═2d2b544e-7d09-11eb-073c-2b87729fff1a
# ╠═00f47156-7dab-11eb-2c6f-edbda15d81c0
# ╠═302f082e-7daa-11eb-3f3d-15bb498dc123
# ╠═61208bfa-7dab-11eb-354f-5787b1fab72b
# ╠═714c62bc-7db3-11eb-1197-85275b02cd68
# ╠═b7c6be18-7dac-11eb-2742-bb95bb3b9d84
# ╠═820a7a84-7dad-11eb-38b7-b34a0d372808
# ╠═8720320a-7dac-11eb-2433-2d0e6f5f9981
# ╠═200c5c38-7dac-11eb-2051-c5eb81f79d16
# ╠═565a91ce-7dac-11eb-3cd2-fd3f9ba54bd0
# ╠═7c9ff086-7d11-11eb-27cc-3b15f23c0f00

### A Pluto.jl notebook ###
# v0.12.20

using Markdown
using InteractiveUtils

# ╔═╡ e5fc3634-7dca-11eb-3f70-ab59f340915c
using DataFrames, JSON, HTTP

# ╔═╡ 696c495a-7dcb-11eb-09a2-953941fbd453
using Plots

# ╔═╡ 0e839a48-7dcb-11eb-39d1-2f3952581598
begin
	resp = HTTP.get("https://api.covid19india.org/data.json")
	str = String(resp.body)
	json_source = JSON.Parser.parse(str)
end

# ╔═╡ 20db7292-7dcb-11eb-2af7-0738adbb8255
cases = reduce(vcat, DataFrame.(json_source["cases_time_series"]))

# ╔═╡ 860803e2-7dcb-11eb-3c6d-9f968d667527
begin
	cases.dailyconfirmed = parse.(Int64, cases[:,1])
	cases.dailydeceased = parse.(Int64, cases[:,2])
	cases.dailyrecovered = parse.(Int64, cases[:,3])
	# cases[!,:dailyconfirmed] = convert.(Int64,cases[!,:dailyconfirmed])
end

# ╔═╡ a74fc800-7dcb-11eb-1ec5-616775ace536
cases

# ╔═╡ d838e8c0-7dcb-11eb-1119-dffa70613c92
moving_avg = [[sum([cases[(j-k+1),i] for k in 1:7])/7 for j in 7:400] for i in 1:3]

# ╔═╡ 482c3fe8-7dcb-11eb-0c45-459d4b06a5fc
begin
	scatter([1:400],cases.dailyconfirmed, xlabel="Time period (30th Jan 2020 to 4 Mar 2021)", ylabel="Daily Confirmed Cases", label="Given Data", title="Confirmed COVID Cases over given Time")
	scatter!([1:400],moving_avg[1], xlabel="Time period (30th Jan 2020 to 4 Mar 2021)", ylabel="Daily Confirmed Cases", label="Moving Average", title="Confirmed COVID Cases over given Time")
end

# ╔═╡ bc800f7a-7dcb-11eb-13e1-230dccaadc91
begin
	scatter([1:400],cases.dailydeceased, xlabel="Time period (30th Jan 2020 to 4 Mar 2021)", ylabel="Daily Deceased Cases", label="Given Data", title="Deceased COVID Cases over given Time")
	scatter!([1:400],moving_avg[2], xlabel="Time period (30th Jan 2020 to 4 Mar 2021)", ylabel="Daily Deceased Cases", label="Moving Average", title="Deceased COVID Cases over given Time")
end

# ╔═╡ be0af810-7dcb-11eb-3c20-59b93714a9e2
begin
	scatter([1:400],cases.dailyrecovered, xlabel="Time period (30th Jan 2020 to 4 Mar 2021)", ylabel="Daily Recovered Cases", label="Given Data", title="Recovered COVID Cases over given Time")
	scatter!([1:400],moving_avg[3], xlabel="Time period (30th Jan 2020 to 4 Mar 2021)", ylabel="Daily Recovered Cases", label="Moving Average", title="Recovered COVID Cases over given Time")
end

# ╔═╡ Cell order:
# ╠═e5fc3634-7dca-11eb-3f70-ab59f340915c
# ╠═0e839a48-7dcb-11eb-39d1-2f3952581598
# ╠═20db7292-7dcb-11eb-2af7-0738adbb8255
# ╠═860803e2-7dcb-11eb-3c6d-9f968d667527
# ╠═a74fc800-7dcb-11eb-1ec5-616775ace536
# ╠═d838e8c0-7dcb-11eb-1119-dffa70613c92
# ╠═696c495a-7dcb-11eb-09a2-953941fbd453
# ╠═482c3fe8-7dcb-11eb-0c45-459d4b06a5fc
# ╠═bc800f7a-7dcb-11eb-13e1-230dccaadc91
# ╠═be0af810-7dcb-11eb-3c20-59b93714a9e2

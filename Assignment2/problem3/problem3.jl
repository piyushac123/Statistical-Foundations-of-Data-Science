### A Pluto.jl notebook ###
# v0.12.20

using Markdown
using InteractiveUtils

# ╔═╡ 54a510f6-7b64-11eb-2332-ff9e60891951
using DataFrames

# ╔═╡ 28de96ba-7b71-11eb-1edf-2d31531cb78d
using StatsBase

# ╔═╡ 6d779bee-7b64-11eb-186f-1d1404cfc38a
begin
	artist_arr = vcat(vcat(["2 Pac" for _ in 1:7],["2Ge+her" for _ in 1:3]),["3 Doors Down" for _ in 1:5])
	time_arr = vcat(vcat(["4:22" for _ in 1:7],["3:15" for _ in 1:3]),["3:53" for _ in 1:5])
	track_arr = vcat(vcat(["Baby Don't Cry" for _ in 1:7],["The Hardest Part Of ..." for _ in 1:3]),["Kryptonite" for _ in 1:5])
	date_arr = ["2000-02-26", "2000-03-04","2000-03-11","2000-03-18","2000-03-25","2000-04-01","2000-04-08","2000-09-02","2000-09-09","2000-09-16","2000-04-08","2000-04-15","2000-04-22","2000-04-29","2000-05-06"]
	week_arr = vcat(vcat([i for i in 1:7],[i for i in 1:3]),[i for i in 1:5])
	track_frame = DataFrame(
		year = [2000 for _ in 1:15],
		artist = artist_arr,
		time = time_arr,
		track = track_arr,
		date = date_arr,
		week = week_arr,
		rank = [rand(1:100) for _ in 1:15]
	)
end

# ╔═╡ 6a2e25c0-7b73-11eb-0487-37cd09b4f350
begin
	table1 = DataFrame(
		artist = unique(track_frame.artist),
		track = unique(track_frame.track),
		time = unique(track_frame.time)
	)
	insertcols!(table1, 1, :id => [i for i in 1:size(select(table1, :artist))[1]], makeunique=true)
end

# ╔═╡ 5552096e-7e19-11eb-36af-41701e65f53d
table2 = select(innerjoin(track_frame, table1, on = :artist, makeunique=true), :id, :date, :rank)

# ╔═╡ 6aafb0a2-7b75-11eb-2007-abf89f6a8354
# begin
# 	table2 = select(track_frame, :date, :rank)
# 	select(table2, :date=>(x->x) )
# end

# ╔═╡ Cell order:
# ╠═54a510f6-7b64-11eb-2332-ff9e60891951
# ╠═28de96ba-7b71-11eb-1edf-2d31531cb78d
# ╠═6d779bee-7b64-11eb-186f-1d1404cfc38a
# ╠═6a2e25c0-7b73-11eb-0487-37cd09b4f350
# ╠═5552096e-7e19-11eb-36af-41701e65f53d
# ╠═6aafb0a2-7b75-11eb-2007-abf89f6a8354

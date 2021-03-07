### A Pluto.jl notebook ###
# v0.12.20

using Markdown
using InteractiveUtils

# ╔═╡ ecb7d280-7b40-11eb-2598-fbbfc17f128e
using DataFrames

# ╔═╡ 781ba43e-7b41-11eb-100d-c180d8224414
u_weather = DataFrame(
	id = ["MX17004" for _ in 1:10],
	year = [ 2010 for _ in 1:10],
	month = [i for i in 1:5 for _ in 1:2],
	element = [if(i%2 == true) "tmax" else "tmin" end for i in 1:10]
)

# ╔═╡ de7ba38e-7b56-11eb-0bc4-1b649f0c3ab8
for i in 1:30
	insertcols!(u_weather, (i+4), :i => [missing for _ in 1:10], makeunique=true)
end

# ╔═╡ 3b403b84-7b57-11eb-0ace-f9ec47c68c2f
begin
	col_names = ["d$i" for i in 1:30]
	e_names = ["id", "year", "month", "element"]
	for i in 1:4 insert!(col_names, 1, e_names[5-i]) end
	rename!(u_weather, col_names)
end

# ╔═╡ a59aeaf4-7b5e-11eb-160e-5b253e82cc13
for name in names(u_weather)
        if eltype(u_weather[!,Symbol(name)])==Missing 
        u_weather[!,Symbol(name)]=convert(Vector{Union{Float64,Missing}}, u_weather[!,Symbol(name)])
        end
    end

# ╔═╡ 88433e20-7b59-11eb-178a-bd118b7f732f
begin
	non_missing_ind = [(1,34),(2,34),(3,6),(4,6),(3,7),(4,7),(3,15),(4,15),(3,27),(4,27),(5,9),(6,9),(5,14),(6,14),(5,20),(6,20),(7,31),(8,31),(9,31),(10,31)]
	non_missing = [27.8,14.5,27.3,14.4,24.1,14.4,29.7,13.4,29.9,10.7,32.1,14.2,34.5,16.8,31.1,17.6,36.3,16.7,33.2,18.2]
	for i in 1:20
		u_weather[non_missing_ind[i][1],non_missing_ind[i][2]] = non_missing[i]
	end
end

# ╔═╡ 70f7535e-7b5d-11eb-151d-9dcda39767b1
u_weather

# ╔═╡ f628e502-7b5e-11eb-30ca-ef8c6b5e9bc1
begin
	temp = 1
	t_weather = DataFrame(
	id = ["MX17004" for _ in 1:10],
	date = [if((non_missing_ind[i][1]%2) == true) string(u_weather[1,2],"-",u_weather[non_missing_ind[i][1],3],"-",non_missing_ind[i][2]-4) end for i in 1:2:20],
	tmax = [non_missing[i] for i in 1:2:20],
	tmin = [non_missing[i] for i in 2:2:20]
)
end

# ╔═╡ Cell order:
# ╠═ecb7d280-7b40-11eb-2598-fbbfc17f128e
# ╠═781ba43e-7b41-11eb-100d-c180d8224414
# ╠═de7ba38e-7b56-11eb-0bc4-1b649f0c3ab8
# ╠═3b403b84-7b57-11eb-0ace-f9ec47c68c2f
# ╠═a59aeaf4-7b5e-11eb-160e-5b253e82cc13
# ╠═88433e20-7b59-11eb-178a-bd118b7f732f
# ╠═70f7535e-7b5d-11eb-151d-9dcda39767b1
# ╠═f628e502-7b5e-11eb-30ca-ef8c6b5e9bc1

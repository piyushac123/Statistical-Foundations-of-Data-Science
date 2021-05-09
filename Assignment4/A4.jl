### A Pluto.jl notebook ###
# v0.12.20

using Markdown
using InteractiveUtils

# ╔═╡ 1ce31fc0-96a1-11eb-11d3-a13ad4c37ca4
using Distributions


# ╔═╡ 4aa1f080-96a1-11eb-2d6c-0f261915b244
using Plots

# ╔═╡ e089b3f0-aefa-11eb-3714-9d001678b2fe
using QuadGK

# ╔═╡ 41e14f90-af33-11eb-107b-ff43372f2e9a
md"# Q1:"

# ╔═╡ 22072510-aefb-11eb-2891-1977c4164674
md"### a)Monte Carlo"

# ╔═╡ ff4dfea0-ace2-11eb-09b0-3ba9e48a74f9
begin
	n=1000000
	c=0
	for i in 0:n
		trial=[rand((0,1)) for _ in 1:50]
		if sum(trial)>=30
			c=c+1
		end
	end
	prob=c/n
end

# ╔═╡ 8dfd1820-ace3-11eb-30f5-a30e9ae82175
prob

# ╔═╡ 3de98880-af33-11eb-0e67-19134f53938a
md"### b)Binomial calulation"

# ╔═╡ 61652050-aef5-11eb-1a34-cf4805ccdd77
ans=[binomial(50,i) for i in 30:50]

# ╔═╡ 7f844ed0-aef5-11eb-000f-6bb259ead9fe
sum(ans)/2^50

# ╔═╡ 6df5cbb0-af33-11eb-2b33-49a4ee8f85bf
md"### c)CLT approximation"

# ╔═╡ ebef2ef0-aefa-11eb-330e-6b4c3929c432
quadgk(x->pdf(Normal(25,3.53),x),29.5,100)

# ╔═╡ 41e8a790-aefc-11eb-3fcf-ebaaffaef9af
plot(x->x,x->pdf(Normal(25,3.53),x),[10:.1:40])

# ╔═╡ 819051d0-aefd-11eb-27ca-93decfb3403a
1-cdf(Normal(25,3.53),29.5)

# ╔═╡ d3bf14d0-b0d5-11eb-05b5-f54a81af32d7
md"# Q2:"

# ╔═╡ 555b2300-b0d9-11eb-16b2-4dd7dd586b90
md"## Using CLT approximation"

# ╔═╡ 54bc3900-b0db-11eb-2cbd-9bdf4201fcfa
coin=[0.41,0.59]

# ╔═╡ aecc40c0-b0db-11eb-1893-89c0573d9797
md"##### 0 :tails, 1:heads"

# ╔═╡ 6090a270-b0db-11eb-3291-67cf50c6551f
miu_coin=(0*coin[1]+1*coin[2])

# ╔═╡ bde7bee0-b0db-11eb-3ef9-758ac14fb226
std_coin=sqrt(((0-miu_coin)^2+(1-miu_coin)^2)/2)

# ╔═╡ f27fa4b0-b0db-11eb-2bbe-c115dc9a9e8b
md"##### trials=50 =>n=50"

# ╔═╡ 0e45ef10-b0dc-11eb-01b0-6361c79d29e9
1-cdf(Normal(50*miu_coin,sqrt(50)*std_coin),29.5)

# ╔═╡ f7e425b0-b0dc-11eb-07ab-7bbc545215f5
md"### using monte carlo"

# ╔═╡ dfb473c0-b0d5-11eb-2326-1f7639725c4b
function toss_coin(n)
	total=0
	for i in 1:n
		x=rand()
		if x<0.59
			total=total+1
		end
	end
	return total
end

# ╔═╡ 179092a0-b0d7-11eb-16a2-55b2f2f4ef73
begin
	tot=0
	num=1000000
	for i in 1:num
		x=toss_coin(50)
		if(x>=30)
			tot=tot+1
		end
	end
	pro=tot/num
end

# ╔═╡ 0d00f680-b0dd-11eb-1b02-4f223c1fb23a
md"### using Binomial Distribution"

# ╔═╡ 3f0c61e0-b0d9-11eb-0d5f-0dd24f82d691
bino_dist = sum([binomial(50,r)*(0.59)^(r)*(0.41)^(50-r) for r in 30:50])

# ╔═╡ c9719fe0-b0dd-11eb-3f1a-99e11b27724a
md"# Q3:"

# ╔═╡ 64ca623e-b0e0-11eb-0ea8-1d170ac2ca25
begin
	n1= 100000
	mean1 = 100
	std1 = 30
	x=[]
	for i in 1:n1    
	    if  1-cdf(Normal(i*mean1, sqrt(i)*std1),3000)>=0.95
	        push!(x,i)
	    end
	end
end

# ╔═╡ 335841f0-b0ea-11eb-2237-a7a5e7f807f0
x

# ╔═╡ 89d67062-b0ea-11eb-082b-c1f0e020894a
1-cdf(Normal(3300,sqrt(33)*30),3000)

# ╔═╡ 30bd0920-af33-11eb-31be-7710e8e2e81e
md"# Q4:"

# ╔═╡ 581264a0-af35-11eb-3a3d-3b1413a8d567
md"##### Third moment : skewness"

# ╔═╡ 0d06ed10-af34-11eb-3545-67bee0c322c0
moment_third(d_,x1,x2) = (quadgk(x->(((x-mean(d_))^3)*pdf(d_, x)),x1,x2)[1])/std(d_)^3

# ╔═╡ 89a824a0-af4e-11eb-3f61-a16a851a755b
third_moment_discrt(l,m,s)=sum((l.-m).^3)/(length(l)*s^3)

# ╔═╡ 6a388ab2-af35-11eb-1b68-97ec10df4c5f
md"##### Fourth moment : Kurtosis"

# ╔═╡ f8b517f0-af34-11eb-3a26-33027c9b3028
moment_fourth(d_,x1,x2) = (quadgk(x->(((x-mean(d_))^4)*pdf(d_, x)),x1,x2)[1])/std(d_)^4

# ╔═╡ 63768140-af4f-11eb-367a-a12ed383de6d
fourth_moment_discrt(l,m,s)=sum((l.-m).^4)/(length(l)*s^4)

# ╔═╡ 84c2b4d0-b0a4-11eb-19b2-2371cd913960
md"## General method"

# ╔═╡ 13a82090-b0a5-11eb-0064-3958ab348cfb
n_max=1000

# ╔═╡ b0e011f0-b0a1-11eb-2bbb-41a35d12e6c9
function cal_3rd_4th_moment(d)
	m=mean(d)
	s=std(d)
	third=[]
	fourth=[]
	k=1000
	for n in 1:n_max
		dist=[]
		for _ in 1:k
			ul3=rand(d,n)
			t=s*sqrt(n)
			ul=sum(ul3.-m)
			push!(dist,ul/t)
		end
		push!(third,third_moment_discrt(dist,mean(dist),std(dist)))
		push!(fourth,fourth_moment_discrt(dist,mean(dist),std(dist)))
		
	end
	return third,fourth
end

# ╔═╡ 550e1fb0-afc1-11eb-0516-d568e3a0b256
md"### a)Uniform distribution"

# ╔═╡ d2e75aa0-b0a2-11eb-0dd9-81f5e7612a87
uniform_skewness,uniform_kurtosis=cal_3rd_4th_moment(Uniform(0,1))

# ╔═╡ 5d56cea0-b0a3-11eb-016c-7f867c1d4aac
mean(uniform_skewness)

# ╔═╡ 800151a0-b0a3-11eb-3e7d-f92830177160
mean(uniform_kurtosis)

# ╔═╡ 0f18a550-af50-11eb-2882-ed8cf337b46a
begin
	scatter([1:n_max],uniform_skewness,title="Uniform distribution skewness",label="third moment")
	plot!([1:n_max],[0.05 for _ in 1:n_max],lw=3,label="0.05 line")
	plot!([1:n_max],[-0.05 for _ in 1:n_max],lw=3,label="-0.05 line")
	
end

# ╔═╡ a3e30220-af50-11eb-3134-ed428e2d7daf
begin
	scatter([1:n_max],uniform_kurtosis,title="Uniform distribution kurtosis",label="fourth moment")
	plot!([1:n_max],[3+0.05 for _ in 1:n_max],label="3.05 line",lw=3)
	plot!([1:n_max],[3-0.05 for _ in 1:n_max],label="2.95 line",lw=3)
end

# ╔═╡ a34389a0-af57-11eb-344f-0d0735c09ead
begin
l=[]
for i in 1:n_max
	if(uniform_kurtosis[i]<=3.05 && uniform_kurtosis[i]>=2.95)
		if(uniform_skewness[i]<=0.05 && uniform_skewness[i]>=-0.05)
			push!(l,i)
		end
	end
end
length(l)
end

# ╔═╡ 68085102-b0a5-11eb-2337-bfdb08d96c0d
md"###### Smllest Value of n for uniform distribution"

# ╔═╡ 2f9d3a92-b08e-11eb-17d9-3764d416309e
l[1]

# ╔═╡ c32b30c0-afd3-11eb-02e0-95fada130ad1
md"### b)Binomial distribution p=0.01"

# ╔═╡ e2f6d6c0-afd3-11eb-035a-1329e979bfb7
binomial1_third,binomial1_fourth=cal_3rd_4th_moment(Binomial(100,0.01))

# ╔═╡ cd44ccf0-b0a6-11eb-0635-d95c496e9e3c
mean(binomial1_third)

# ╔═╡ 19016180-b0a7-11eb-2b3d-955347635e5b
mean(binomial1_fourth)

# ╔═╡ b9d15580-afd9-11eb-00ec-1de4bd0e4ea1
begin
	scatter([1:n_max],binomial1_third,title="Binomial p=0.01 skewnwss",label="third moment")
	plot!([1:n_max],[0.05 for _ in 1:n_max],lw=3,label="0.05 line")
	plot!([1:n_max],[-0.05 for _ in 1:n_max],lw=3,label="-0.05 line")
	
end

# ╔═╡ dc8c2c30-afd9-11eb-0cb0-ad0e269838a7
begin
	scatter([1:n_max],binomial1_fourth,title="Binomial p=0.01 kurtosis",label="fourth moment")
	plot!([1:n_max],[3+0.05 for _ in 1:n_max],label="3.05 line",lw=3)
	plot!([1:n_max],[3-0.05 for _ in 1:n_max],label="2.95 line",lw=3)
end

# ╔═╡ f33ff0b0-afd9-11eb-1921-ed43b35edcc4
begin
l1=[]
for i in 1:n_max
	if(binomial1_fourth[i]<=3.05 && binomial1_fourth[i]>=2.95)
		if(binomial1_third[i]<=0.05 && binomial1_third[i]>=-0.05)
			push!(l1,i)
		end
	end
end
length(l1)
end

# ╔═╡ 4a215ea0-b0a7-11eb-1bce-2df290f9ad47
md"###### Smllest Value of n for Binomial distribution p=0.01"

# ╔═╡ 31297680-b0a7-11eb-2f67-0dfa1acb7a4f
l1[1]

# ╔═╡ 85137bae-afda-11eb-13ee-db645b7f8de8
md"### c)binomial distribution p=0.5 "

# ╔═╡ b6fdf4c0-afda-11eb-16a2-ed0535a2f891
binomial2_third,binomial2_fourth=cal_3rd_4th_moment(Binomial(100,0.5))

# ╔═╡ 88b71920-b0a7-11eb-0aef-c74731dc1804
mean(binomial2_third)

# ╔═╡ 8e3977d2-b0a7-11eb-0f6e-bdfecaa5ffe1
mean(binomial2_fourth)

# ╔═╡ f4a7c8a0-afda-11eb-19ed-05e4824ef1b1
begin
	scatter([1:n_max],binomial2_third,title="Binomial p= 0.5 skewnwss",label="third moment")
	plot!([1:n_max],[0.05 for _ in 1:n_max],lw=3,label="0.05 line")
	plot!([1:n_max],[-0.05 for _ in 1:n_max],lw=3,label="-0.05 line")
	
end

# ╔═╡ 0ee724e0-afdb-11eb-3313-b11e49c52ce9
begin
	scatter([1:n_max],binomial2_fourth,title="Binomial p=0.5 kurtosis",label="fourth moment")
	plot!([1:n_max],[3+0.05 for _ in 1:n_max],label="3.05 line",lw=3)
	plot!([1:n_max],[3-0.05 for _ in 1:n_max],label="2.95 line",lw=3)
end

# ╔═╡ 36b2fad0-afdb-11eb-01c1-9be770a8b89f
begin
l2=[]
for i in 1:n_max
	if(binomial2_fourth[i]<=3.05 && binomial2_fourth[i]>=2.95)
		if(binomial2_third[i]<=0.05 && binomial2_third[i]>=-0.05)
			push!(l2,i)
		end
	end
end
length(l2)
end

# ╔═╡ f312ba90-b0a7-11eb-0f73-4796ebb2598d
md"###### Smllest Value of n for Binomial distribution p=0.5"

# ╔═╡ 01f5c390-b0a8-11eb-10c8-efc58b597d79
l2[1]

# ╔═╡ 520eeaa0-afdb-11eb-3fc3-1345ab9b31a0
md"### d)Chi-square distribution with 3 degrees of freedom"

# ╔═╡ 74220fa0-afdb-11eb-1b6f-71bdd50c77a5
chi_third,chi_fourth=cal_3rd_4th_moment(Chi(3))

# ╔═╡ c0e78f10-afe3-11eb-311d-1f33fb0359cb
begin
	scatter([1:n_max],chi_third,title="Chi square skewnwess",label="third moment")
	plot!([1:n_max],[0.05 for _ in 1:n_max],lw=3,label="0.05 line")
	plot!([1:n_max],[-0.05 for _ in 1:n_max],lw=3,label="-0.05 line")
	
end

# ╔═╡ eb38e1f0-afe4-11eb-165a-5b0e796ee524
begin
	scatter([1:n_max],chi_fourth,title="Chi square kurtosis",label="fourth moment")
	plot!([1:n_max],[3+0.05 for _ in 1:n_max],label="3.05 line",lw=3)
	plot!([1:n_max],[3-0.05 for _ in 1:n_max],label="2.95 line",lw=3)
end

# ╔═╡ 1abbd0e0-afe5-11eb-3424-e3bc9ad4ce31
begin
l3=[]
for i in 1:n_max
	if(chi_fourth[i]<=3.05 && chi_fourth[i]>=2.95)
		if(chi_third[i]<=0.05 && chi_third[i]>=-0.05)
			push!(l3,i)
		end
	end
end
length(l3)
end

# ╔═╡ 482f0f10-b0a8-11eb-07c7-85f22ccd0ccc
md"###### Smllest Value of n for Chi distribution k=3"

# ╔═╡ 51cbd7fe-b0a8-11eb-0ede-fd75ab732519
l3[1]

# ╔═╡ 3c9e56d2-b0d3-11eb-1380-fff4904c07ba


# ╔═╡ aafec630-b0a8-11eb-041c-f7e8df0e2f61
md"# Q5"

# ╔═╡ Cell order:
# ╠═1ce31fc0-96a1-11eb-11d3-a13ad4c37ca4
# ╠═4aa1f080-96a1-11eb-2d6c-0f261915b244
# ╟─41e14f90-af33-11eb-107b-ff43372f2e9a
# ╟─22072510-aefb-11eb-2891-1977c4164674
# ╠═ff4dfea0-ace2-11eb-09b0-3ba9e48a74f9
# ╠═8dfd1820-ace3-11eb-30f5-a30e9ae82175
# ╟─3de98880-af33-11eb-0e67-19134f53938a
# ╠═61652050-aef5-11eb-1a34-cf4805ccdd77
# ╠═7f844ed0-aef5-11eb-000f-6bb259ead9fe
# ╟─6df5cbb0-af33-11eb-2b33-49a4ee8f85bf
# ╠═e089b3f0-aefa-11eb-3714-9d001678b2fe
# ╠═ebef2ef0-aefa-11eb-330e-6b4c3929c432
# ╠═41e8a790-aefc-11eb-3fcf-ebaaffaef9af
# ╠═819051d0-aefd-11eb-27ca-93decfb3403a
# ╟─d3bf14d0-b0d5-11eb-05b5-f54a81af32d7
# ╟─555b2300-b0d9-11eb-16b2-4dd7dd586b90
# ╠═54bc3900-b0db-11eb-2cbd-9bdf4201fcfa
# ╟─aecc40c0-b0db-11eb-1893-89c0573d9797
# ╠═6090a270-b0db-11eb-3291-67cf50c6551f
# ╠═bde7bee0-b0db-11eb-3ef9-758ac14fb226
# ╟─f27fa4b0-b0db-11eb-2bbe-c115dc9a9e8b
# ╠═0e45ef10-b0dc-11eb-01b0-6361c79d29e9
# ╟─f7e425b0-b0dc-11eb-07ab-7bbc545215f5
# ╠═dfb473c0-b0d5-11eb-2326-1f7639725c4b
# ╠═179092a0-b0d7-11eb-16a2-55b2f2f4ef73
# ╟─0d00f680-b0dd-11eb-1b02-4f223c1fb23a
# ╠═3f0c61e0-b0d9-11eb-0d5f-0dd24f82d691
# ╟─c9719fe0-b0dd-11eb-3f1a-99e11b27724a
# ╠═64ca623e-b0e0-11eb-0ea8-1d170ac2ca25
# ╠═335841f0-b0ea-11eb-2237-a7a5e7f807f0
# ╠═89d67062-b0ea-11eb-082b-c1f0e020894a
# ╟─30bd0920-af33-11eb-31be-7710e8e2e81e
# ╟─581264a0-af35-11eb-3a3d-3b1413a8d567
# ╠═0d06ed10-af34-11eb-3545-67bee0c322c0
# ╠═89a824a0-af4e-11eb-3f61-a16a851a755b
# ╟─6a388ab2-af35-11eb-1b68-97ec10df4c5f
# ╠═f8b517f0-af34-11eb-3a26-33027c9b3028
# ╠═63768140-af4f-11eb-367a-a12ed383de6d
# ╟─84c2b4d0-b0a4-11eb-19b2-2371cd913960
# ╠═13a82090-b0a5-11eb-0064-3958ab348cfb
# ╠═b0e011f0-b0a1-11eb-2bbb-41a35d12e6c9
# ╟─550e1fb0-afc1-11eb-0516-d568e3a0b256
# ╠═d2e75aa0-b0a2-11eb-0dd9-81f5e7612a87
# ╠═5d56cea0-b0a3-11eb-016c-7f867c1d4aac
# ╠═800151a0-b0a3-11eb-3e7d-f92830177160
# ╠═0f18a550-af50-11eb-2882-ed8cf337b46a
# ╠═a3e30220-af50-11eb-3134-ed428e2d7daf
# ╠═a34389a0-af57-11eb-344f-0d0735c09ead
# ╟─68085102-b0a5-11eb-2337-bfdb08d96c0d
# ╠═2f9d3a92-b08e-11eb-17d9-3764d416309e
# ╟─c32b30c0-afd3-11eb-02e0-95fada130ad1
# ╠═e2f6d6c0-afd3-11eb-035a-1329e979bfb7
# ╠═cd44ccf0-b0a6-11eb-0635-d95c496e9e3c
# ╠═19016180-b0a7-11eb-2b3d-955347635e5b
# ╠═b9d15580-afd9-11eb-00ec-1de4bd0e4ea1
# ╠═dc8c2c30-afd9-11eb-0cb0-ad0e269838a7
# ╠═f33ff0b0-afd9-11eb-1921-ed43b35edcc4
# ╟─4a215ea0-b0a7-11eb-1bce-2df290f9ad47
# ╠═31297680-b0a7-11eb-2f67-0dfa1acb7a4f
# ╟─85137bae-afda-11eb-13ee-db645b7f8de8
# ╠═b6fdf4c0-afda-11eb-16a2-ed0535a2f891
# ╠═88b71920-b0a7-11eb-0aef-c74731dc1804
# ╠═8e3977d2-b0a7-11eb-0f6e-bdfecaa5ffe1
# ╠═f4a7c8a0-afda-11eb-19ed-05e4824ef1b1
# ╠═0ee724e0-afdb-11eb-3313-b11e49c52ce9
# ╠═36b2fad0-afdb-11eb-01c1-9be770a8b89f
# ╟─f312ba90-b0a7-11eb-0f73-4796ebb2598d
# ╠═01f5c390-b0a8-11eb-10c8-efc58b597d79
# ╟─520eeaa0-afdb-11eb-3fc3-1345ab9b31a0
# ╠═74220fa0-afdb-11eb-1b6f-71bdd50c77a5
# ╠═c0e78f10-afe3-11eb-311d-1f33fb0359cb
# ╠═eb38e1f0-afe4-11eb-165a-5b0e796ee524
# ╠═1abbd0e0-afe5-11eb-3424-e3bc9ad4ce31
# ╟─482f0f10-b0a8-11eb-07c7-85f22ccd0ccc
# ╠═51cbd7fe-b0a8-11eb-0ede-fd75ab732519
# ╠═3c9e56d2-b0d3-11eb-1380-fff4904c07ba
# ╟─aafec630-b0a8-11eb-041c-f7e8df0e2f61

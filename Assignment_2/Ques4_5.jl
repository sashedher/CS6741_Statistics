### A Pluto.jl notebook ###
# v0.12.21

using Markdown
using InteractiveUtils

# ╔═╡ 8fdd01b2-7e3e-11eb-390b-c51ffd90adb1
using DataFrames,JSON,HTTP,JSONTables,Dates

# ╔═╡ 61b95e1e-7f0e-11eb-059f-470f6369bcaa
using Statistics

# ╔═╡ 0ae42320-7f1b-11eb-3772-4f90808abc46
using StatsPlots

# ╔═╡ 4ffd7b80-7f22-11eb-29a5-e175775a6900
using Plots

# ╔═╡ 7c4cffa2-7f34-11eb-2142-e1399215917a
md"Question-4"

# ╔═╡ 0b21b550-7e3f-11eb-1062-49d1107670cc
begin
	res = HTTP.get("https://api.covid19india.org/data.json")
	dt = String(res.body)
	jsdt = JSON.Parser.parse(dt)
	#df4=DataFrame(jsdt,names::Union{})
end

# ╔═╡ 6bf18380-7e9c-11eb-1b74-dbff24754cb3
keys(jsdt)

# ╔═╡ d479f620-7e9d-11eb-299c-c3c4735b3c36
typeof(jsdt)

# ╔═╡ c68c49a0-7e9d-11eb-2c70-13d89434ffd3
jsdt["cases_time_series"]

# ╔═╡ 9f46e5ee-7e96-11eb-3247-f7dccee64d75
df =DataFrame.(jsdt["cases_time_series"])

# ╔═╡ 0c926110-7ea7-11eb-36fd-3d06387fea68
df41=deepcopy(df[1])

# ╔═╡ 13e84740-7ea7-11eb-2262-2f42d65c2b86
for i in range(1,length=length(df)-1)
	append!(df41,df[i+1])
end

# ╔═╡ 0e09b010-7ead-11eb-2d01-9d6a0f0652cb
begin
	df41.dailyconfirmed = parse.(Int,df41[!,:dailyconfirmed])
	df41.dailydeceased = parse.(Int,df41[!,:dailydeceased])
	df41.dailyrecovered = parse.(Int,df41[!,:dailyrecovered])
	df41.totalconfirmed = parse.(Int,df41[!,:totalconfirmed])
	df41.totaldeceased = parse.(Int,df41[!,:totaldeceased])
	df41.totalrecovered = parse.(Int,df41[!,:totalrecovered])
end
#md"remove comments and re run this cell errors in notebook will be rectified"

# ╔═╡ f11a8dc0-7f07-11eb-3ef7-33c767a48a1f
df41.dateymd = Date.(df41.dateymd, "yyyy-mm-dd")

# ╔═╡ a8272cf0-7ea7-11eb-377a-4ba0968663fd
df41

# ╔═╡ 9de619d0-7f0c-11eb-3bba-634791a7e0f8
gdf41=groupby(transform(df41, :dateymd => ByRow(x->yearmonth(x))),:dateymd_function)

# ╔═╡ 834ccbd0-7f0e-11eb-0341-dd43f8623d6a
combine(gdf41, :dailyconfirmed=>sum,:dailydeceased=>sum,:dailyrecovered=>sum )

# ╔═╡ 5d1789b0-7f35-11eb-352f-393ad74bb52c

	md" "



# ╔═╡ 5380db40-7f35-11eb-0ffb-bda89bd0f028
md"Question 5"

# ╔═╡ 456e3f70-7f26-11eb-354b-dd5013e8533e
length(df41.dailyconfirmed)

# ╔═╡ e0651510-7f0f-11eb-3ef4-9b8b3ee20c2f
Mv_Avg_Conf=[]

# ╔═╡ 9aaca240-7f23-11eb-0489-8369c29df792
for i in range(7,stop=length(df41.dailyconfirmed))
	push!(Mv_Avg_Conf,/(sum(df41.dailyconfirmed[(i-6):i]),7))
end

# ╔═╡ f7e41a00-7f29-11eb-2ef6-637eaff81fff
Mv_Avg_Conf

# ╔═╡ 22f94e90-7f2a-11eb-22b9-3f009eb309ef
length(df41.dailyconfirmed)

# ╔═╡ 60971480-7f2a-11eb-1f94-d5c3d7d45004
length(Mv_Avg_Conf)

# ╔═╡ 46366d40-7f2d-11eb-18c1-916850eb96fc


# ╔═╡ 768924c0-7f2c-11eb-3b6a-63b8f43efb9d
begin
	reverse!(Mv_Avg_Conf)
	for i in range(1,stop=6)
		push!(Mv_Avg_Conf,missing)
	end
	reverse!(Mv_Avg_Conf)
end

# ╔═╡ bddbda10-7f2d-11eb-0993-0bb6606e2ee5
begin
	
	Plots.plot(df41.dateymd,df41.dailyconfirmed,title="Daily_confirmed Vs Moving 7days Avg",label="Daily confirmed",xlabel="Days",ylabel="No of confirmed")
	Plots.plot!(df41.dateymd,Mv_Avg_Conf,label="Moving Avg")
	
end

# ╔═╡ 2bee5ee0-7eb3-11eb-1372-692707792bad
Mv_Avg_Decas=[]

# ╔═╡ b62e9d60-7f33-11eb-13e9-b9fa4d37a8df
for i in range(7,stop=length(df41.dailydeceased))
	push!(Mv_Avg_Decas,/(sum(df41.dailydeceased[(i-6):i]),7))
end

# ╔═╡ b615700e-7f33-11eb-2230-77df1a3bf64d
begin
	reverse!(Mv_Avg_Decas)
	for i in range(1,stop=6)
		push!(Mv_Avg_Decas,missing)
	end
	reverse!(Mv_Avg_Decas)
end

# ╔═╡ b5e81e80-7f33-11eb-2345-712b12862c54
begin
	
	Plots.plot(df41.dateymd,df41.dailydeceased,title="Daily_Decased Vs Moving 7days Avg",label="Daily Decased",xlabel="Days",ylabel="No of Decased")
	Plots.plot!(df41.dateymd,Mv_Avg_Decas,label="Moving Avg")
	
end

# ╔═╡ f15a78f0-7f33-11eb-23cb-7d0bcaf9a24f


# ╔═╡ b5caf990-7f33-11eb-28f9-ab5754545bf8
Mv_Avg_Recov=[]

# ╔═╡ deacfa6e-7f33-11eb-3fbd-e513b7306129
for i in range(7,stop=length(df41.dailyrecovered))
	push!(Mv_Avg_Recov,/(sum(df41.dailyrecovered[(i-6):i]),7))
end

# ╔═╡ de8c2c00-7f33-11eb-2b10-3fb776224594
begin
	reverse!(Mv_Avg_Recov)
	for i in range(1,stop=6)
		push!(Mv_Avg_Recov,missing)
	end
	reverse!(Mv_Avg_Recov)
end

# ╔═╡ de56c420-7f33-11eb-2856-fbad87a96483
begin
	
	Plots.plot(df41.dateymd,df41.dailyrecovered,title="Daily_Recovered Vs Moving 7days Avg",label="Daily Recovered",xlabel="Days",ylabel="No of Recovered")
	Plots.plot!(df41.dateymd,Mv_Avg_Recov,label="Moving Avg")
	
end

# ╔═╡ Cell order:
# ╠═8fdd01b2-7e3e-11eb-390b-c51ffd90adb1
# ╠═61b95e1e-7f0e-11eb-059f-470f6369bcaa
# ╠═0ae42320-7f1b-11eb-3772-4f90808abc46
# ╠═4ffd7b80-7f22-11eb-29a5-e175775a6900
# ╟─7c4cffa2-7f34-11eb-2142-e1399215917a
# ╠═0b21b550-7e3f-11eb-1062-49d1107670cc
# ╠═6bf18380-7e9c-11eb-1b74-dbff24754cb3
# ╠═d479f620-7e9d-11eb-299c-c3c4735b3c36
# ╠═c68c49a0-7e9d-11eb-2c70-13d89434ffd3
# ╠═9f46e5ee-7e96-11eb-3247-f7dccee64d75
# ╠═0c926110-7ea7-11eb-36fd-3d06387fea68
# ╠═13e84740-7ea7-11eb-2262-2f42d65c2b86
# ╠═0e09b010-7ead-11eb-2d01-9d6a0f0652cb
# ╠═f11a8dc0-7f07-11eb-3ef7-33c767a48a1f
# ╠═a8272cf0-7ea7-11eb-377a-4ba0968663fd
# ╠═9de619d0-7f0c-11eb-3bba-634791a7e0f8
# ╠═834ccbd0-7f0e-11eb-0341-dd43f8623d6a
# ╟─5d1789b0-7f35-11eb-352f-393ad74bb52c
# ╟─5380db40-7f35-11eb-0ffb-bda89bd0f028
# ╠═456e3f70-7f26-11eb-354b-dd5013e8533e
# ╠═e0651510-7f0f-11eb-3ef4-9b8b3ee20c2f
# ╠═9aaca240-7f23-11eb-0489-8369c29df792
# ╠═f7e41a00-7f29-11eb-2ef6-637eaff81fff
# ╠═22f94e90-7f2a-11eb-22b9-3f009eb309ef
# ╠═60971480-7f2a-11eb-1f94-d5c3d7d45004
# ╠═46366d40-7f2d-11eb-18c1-916850eb96fc
# ╠═768924c0-7f2c-11eb-3b6a-63b8f43efb9d
# ╠═bddbda10-7f2d-11eb-0993-0bb6606e2ee5
# ╠═2bee5ee0-7eb3-11eb-1372-692707792bad
# ╠═b62e9d60-7f33-11eb-13e9-b9fa4d37a8df
# ╠═b615700e-7f33-11eb-2230-77df1a3bf64d
# ╠═b5e81e80-7f33-11eb-2345-712b12862c54
# ╠═f15a78f0-7f33-11eb-23cb-7d0bcaf9a24f
# ╠═b5caf990-7f33-11eb-28f9-ab5754545bf8
# ╠═deacfa6e-7f33-11eb-3fbd-e513b7306129
# ╠═de8c2c00-7f33-11eb-2b10-3fb776224594
# ╠═de56c420-7f33-11eb-2856-fbad87a96483

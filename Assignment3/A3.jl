### A Pluto.jl notebook ###
# v0.12.20

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : missing
        el
    end
end

# ╔═╡ 7420c480-910c-11eb-2338-6bbd68005f0a
begin
    using Pkg
    Pkg.add("PlutoUI")
    Pkg.add("FreqTables")
    Pkg.add("RDatasets")
    Pkg.add("StatsBase")
    Pkg.add("StatsPlots")
    Pkg.add("Distributions")
    Pkg.add("Statistics")
    Pkg.add("LaTeXStrings")
	Pkg.add("VegaLite")
end

# ╔═╡ b0f0b9a4-938c-11eb-3929-331bdd555c4c
using DataFrames,JSON,HTTP,JSONTables,Dates,TableIO,CSV,VegaLite

# ╔═╡ 298ff14c-910d-11eb-1088-efa7ab843b4f
using PlutoUI,FreqTables,RDatasets,StatsBase,StatsPlots,Distributions,Statistics,LaTeXStrings,QuadGK

# ╔═╡ 4b759868-9494-11eb-1f4e-3d0ab484ec88


# ╔═╡ 131772d8-917f-11eb-1add-1f94cfb9bf63
begin
	Pkg.add("QuadGK")
	Pkg.add("JSON")
	Pkg.add("HTTP")
	Pkg.add("JSONTables")
	Pkg.add("CSV")
	Pkg.add("TableIO")
end

# ╔═╡ ee48c5f4-93a6-11eb-238f-1ffd8145a1ef


# ╔═╡ 00a18eb0-950b-11eb-2345-8774769664b7
md"Question-1"

# ╔═╡ 633f5438-9530-11eb-0091-4ded1bb596a6


# ╔═╡ 01cea346-9177-11eb-00a3-e3d8875dbc77
Q = Normal(0, 1)

# ╔═╡ 975d87a0-9182-11eb-0147-919853fe6da4
v = @bind v html"<input type=range min=1 max=5 step=1>"

# ╔═╡ 0c5ec226-9183-11eb-000c-c952dd92ade0
v  

# ╔═╡ dd1a76ce-9180-11eb-0ee8-9337eeb7f71a
P=TDist(v)

# ╔═╡ 2f38094c-9181-11eb-20e9-bf788b2093f0
divr(P,Q,x)=pdf(P,x)*log(pdf(P,x)/pdf(Q,x))

# ╔═╡ a1be90a0-9186-11eb-3c36-fff654b98d91
KLDiv(n,t)=quadgk(x->divr(n,t,x),(-37:37)...)[1]

# ╔═╡ 0ba1593a-9187-11eb-255f-478177875ea9
KLDiv(P,Q)

# ╔═╡ 2f609232-91ff-11eb-1e50-8fb6bac96e47


# ╔═╡ 17fbbf2e-950b-11eb-2975-eb0e773a4bfb
md"Question-2"

# ╔═╡ 68db2700-9530-11eb-17d1-6560d914cf03


# ╔═╡ f7ae629a-91fb-11eb-0c2d-f114013f1cf7
U1=Uniform(0,1)

# ╔═╡ f2741aea-91fb-11eb-3e3e-3f1853d4e5a0
samples=rand(U1,10^6)

# ╔═╡ 8b462602-91ff-11eb-13db-27847df88df9
length(samples)

# ╔═╡ cbed5580-91fb-11eb-37f0-494b8d6a253d
begin
	dis=[]
	for i in 2:10
		samples=rand(U1,10^6)
		xd=fit(Uniform,samples)
		push!(dis,xd)
	end
end

# ╔═╡ ebb6b8e6-9511-11eb-03d7-b7083f3801dd
params(dis[9])

# ╔═╡ eef7d312-9209-11eb-29ce-cf9b52413cf3
convs(ux,uy,x) = sum(pdf(ux,x-k)*pdf(uy,k) for k=0.0:0.001:1.0)

# ╔═╡ 33653a62-920a-11eb-3186-1162d17fb9fb
 plot(-1.0:0.01:2.0,convs.(dis[1],dis[2],-1.0:0.01:2.0))

# ╔═╡ cdff0544-91fb-11eb-259b-8772fde759c2
begin
	cns=[]
	x=deepcopy(dis[1])
	for i in 1:8
	    for j in i:9
			x=convs.(dis[i],dis[j],-0:0.01:2)
		end
		push!(cns,x)
	end
		
end

# ╔═╡ da6aa228-9568-11eb-1f8a-394a3317e73a
begin
	klv=[]
	for i in 1:8
		p2=SymTriangularDist(mean(cns[i]),var(cns[i]))
		q2=fit(Normal,cns[i])
		push!(klv,KLDiv(p2,q2))
	end
end

# ╔═╡ e9f4b8ac-956b-11eb-3846-fd4402457273
klv

# ╔═╡ 57522c74-956a-11eb-1bb0-63b7d7f66d4a
plot(1:8,klv)

# ╔═╡ d3f35c72-9569-11eb-2b21-f1e3cefe5af2


# ╔═╡ 49afae20-9533-11eb-1a98-e9e5d53e83d5
params(fit(Normal,cns[1]))

# ╔═╡ 2eb828d6-950b-11eb-1269-4f21a352add0
cns[1]

# ╔═╡ 2e293962-9512-11eb-0811-c5fb0c48eb35
 plot(-0:0.01:2,cns[8])

# ╔═╡ c4403f24-9515-11eb-0f24-871cd41dc169
pdf(fit(Uniform, cns[1]),0.3)

# ╔═╡ fd4228f4-9516-11eb-0638-81a14573fa5b
params(fit(Uniform, cns[1]))

# ╔═╡ 6fd2b282-9513-11eb-376e-3184f86d873a
scatter(1:8,mean.(cns))

# ╔═╡ 34d0c3d4-9530-11eb-3f1d-71b21908559a


# ╔═╡ 29dcc090-9530-11eb-0712-53d344512a93
md"Question-3"

# ╔═╡ 341b11cc-9530-11eb-2074-8b56a2d00c4e


# ╔═╡ 76301d3e-9530-11eb-363e-8bdfce50e084
N3=Normal(1,1)

# ╔═╡ 0f4fb344-9572-11eb-27ec-17bc62a50b01
N31=Normal(5,1)

# ╔═╡ 24eb5c96-9572-11eb-1f4e-4fc8eee5fccc
s3=rand(N3,300)

# ╔═╡ 74541438-9572-11eb-00b3-f181235bab5c
s31=rand(N31,700)

# ╔═╡ 7bfc20ae-9572-11eb-1f33-a14b0c4e64b1
append!(s3,s31)

# ╔═╡ 47c44ece-9572-11eb-0f58-3962cd4126d3
length(s3)

# ╔═╡ 1715b9f6-9573-11eb-25ba-c7bdd68019bc
begin
	histogram(s3)
	plot!([mean(s3), mean(s3)], [250, mean(s3)], label="Mean", line=(8, :dash, :green))
	plot!([median(s3), median(s3)], [250, median(s3)], label="Mode", line=(5, :red))
	plot!([mode(s3), mode(s3)], [250, mode(s3)], label="Median", line=(9, :dot, :orange))
end

# ╔═╡ 241770cc-9573-11eb-3360-fdfe7c993a22
mean(s3),median(s3),mode(s3)

# ╔═╡ 7401498e-9530-11eb-18ec-d54bcd9cc24e


# ╔═╡ a90df21e-9394-11eb-0ff7-37cfc41afa04
md"Question-4"

# ╔═╡ 774c7b48-9530-11eb-194a-c55178f68605


# ╔═╡ a88bdb1c-9394-11eb-1e74-7bd8f5df3bd9
U4=Uniform(0,1)

# ╔═╡ c1b23bec-9394-11eb-1b67-f5c5d9399cce
s=rand(U4,30)

# ╔═╡ f5648448-9394-11eb-16d1-8bee54c6cd04
length(s)

# ╔═╡ fad25ca2-9394-11eb-2619-810171823759
maximum(s)-minimum(s)

# ╔═╡ fcb1f26c-9394-11eb-1460-4bccdabe09bc
median(s)

# ╔═╡ fc92123a-9394-11eb-3a5e-2135605e5e56
begin
	r4=[]
	for i in range(1,10000,step=1)
		rs=rand(U4,30)
		push!(r4,maximum(rs)-minimum(rs))
	end
end

# ╔═╡ 445d3a02-9397-11eb-10ce-41c6e44124b5
length(r4)

# ╔═╡ afbb4068-9395-11eb-36ef-5b96bd9928d8
default(size =(1500, 1000))

# ╔═╡ fc6e3d88-9394-11eb-2099-392f638b5de3
begin
	histogram(r4)
	d_mean = mean(r4)
	d_mode = mode(r4)
	d_median = median(r4)
	plot!([d_mean, d_mean], [600, mean(r4)], label="Mean", line=(8, :dash, :green))
	plot!([d_mode, d_mode], [600, mode(r4)], label="Mode", line=(5, :red))
	plot!([d_median, d_median], [600, median(r4)], label="Median", line=(9, :dot, :orange))
end

# ╔═╡ 794befd2-9398-11eb-1540-c1d46e036644
d_mean,d_median,d_mode

# ╔═╡ 3d4f525a-9530-11eb-2fbf-01d16d9134a9


# ╔═╡ 3c6ea28c-9530-11eb-0a0a-fd97e48763ce
md"Question-5"

# ╔═╡ 7d98ca88-9530-11eb-0c49-41739296b05f


# ╔═╡ 7f7a5d1c-9530-11eb-26a8-07bd5be93377


# ╔═╡ 43579cc2-950b-11eb-0050-117079ceb0c2


# ╔═╡ 81e22c1a-93a7-11eb-3c54-3dc5d37d1a9e
md"Question-6"

# ╔═╡ 8b801a0c-9530-11eb-314d-93629a5577ea


# ╔═╡ 0ab14aa2-93a9-11eb-2d57-eb405217aeca
@bind f PlutoUI.FilePicker() # pick any supported file type

# ╔═╡ 0f5f8730-93a9-11eb-10d5-b99d6c469e22
dfcv1 = DataFrame(read_table(f); copycols=false)

# ╔═╡ c392491e-93df-11eb-3ced-7599ee6ea181
dfcv=select(dfcv1,:Date,:State,:Confirmed)

# ╔═╡ cb23ef50-93c3-11eb-03dc-b5dc6280542f
dfcv

# ╔═╡ 172470b4-9491-11eb-015f-13fba0607408
describe(dfcv)

# ╔═╡ 554caf24-93c3-11eb-28ee-4163180e7649
weekno=Dates.week.(dfcv[:,:Date])

# ╔═╡ f3036fd6-93c4-11eb-3099-e5610582221b
length(weekno)

# ╔═╡ 603ff93e-93c3-11eb-287f-4f3f92831712
insertcols!(dfcv,2,:WeekNo=>weekno)

# ╔═╡ a3402dde-93da-11eb-0780-17fb27689e57
gdat=groupby(dfcv,[:WeekNo,:State])

# ╔═╡ d49bff9c-93db-11eb-1299-6b7f94d8987c
length(gdat)

# ╔═╡ 08be43ac-93dc-11eb-2804-bd8927071733
fdf=combine(gdat,:Confirmed => sum)

# ╔═╡ b9ad8452-93dc-11eb-1011-03bbbc391430
WklyRptd=unstack(fdf, :State,:Confirmed_sum)

# ╔═╡ 26afac3e-9492-11eb-30cc-eb8b0e6157ec
WklyRpt=select!(WklyRptd, Not([Symbol(names(WklyRptd)[38]),:Lakshadweep]))

# ╔═╡ 72c29f72-93df-11eb-3ff2-2bf3ed8ae0be
describe(WklyRpt)

# ╔═╡ 4905a792-955e-11eb-0ea3-eb0bf7f37a7f
function covmat(df)
       nc = ncol(df)
       t = zeros(nc, nc)
       for (i, c1) in enumerate(eachcol(df))
           for (j, c2) in enumerate(eachcol(df))
               sx, sy = skipmissings(c1, c2)
               t[i, j] = cov(collect(sx), collect(sy))
           end
       end
       return t
       end;

# ╔═╡ 59322866-955e-11eb-2816-31d577aa49f5
covmat(select(WklyRpt, Not([:WeekNo])))

# ╔═╡ b06a7732-955e-11eb-0d4b-159538d5cba3
heatmap(covmat(select(WklyRpt, Not([:WeekNo]))))

# ╔═╡ dc0cbeb6-9560-11eb-1522-57632d2c5f45
function cormat(df)
       nc = ncol(df)
       t = zeros(nc, nc)
       for (i, c1) in enumerate(eachcol(df))
           for (j, c2) in enumerate(eachcol(df))
               sx, sy = skipmissings(c1, c2)
               t[i, j] = cor(collect(sx), collect(sy))
           end
       end
       return t
       end;

# ╔═╡ f26ca8a6-9560-11eb-0d84-9dfc3ca7a0a9
heatmap(cormat(select(WklyRpt, Not([:WeekNo]))))

# ╔═╡ 6a1d02a0-9562-11eb-3b6a-219df2741de7
findpos(arr) = [indexin(arr[i], sort(arr))[1] for i in 1:length(arr)]

# ╔═╡ 1cf21c86-9562-11eb-2228-63990d93f97b
cor_s(x, y) = cor(findpos(x), findpos(y))

# ╔═╡ 4346b2b6-9562-11eb-18da-9f0f9068fa3e
function scormat(df)
       nc = ncol(df)
       t = zeros(nc, nc)
       for (i, c1) in enumerate(eachcol(df))
           for (j, c2) in enumerate(eachcol(df))
               sx, sy = skipmissings(c1, c2)
               t[i, j] = cor_s(collect(sx), collect(sy))
           end
       end
       return t
       end;

# ╔═╡ 56b36902-9562-11eb-3e00-3debd1117775
scormat(WklyRpt)

# ╔═╡ 77c4995e-9562-11eb-026b-1d52817bff3f
heatmap(scormat(select(WklyRpt, Not([:WeekNo]))))

# ╔═╡ 5875082c-9530-11eb-3236-713805451b77


# ╔═╡ 07852b36-9530-11eb-12a5-7d0e1f5f1d43
md"Question-7"

# ╔═╡ 5a474a02-9530-11eb-11be-539d985758a9


# ╔═╡ 84a0c788-9530-11eb-0e55-1525d97e02b9
N7=Normal(0,1)

# ╔═╡ fd838fb8-9536-11eb-03b4-5f183bb52852
T7=TDist(10)

# ╔═╡ 0d21d5ea-9537-11eb-02d7-3b5dfe34cf84
cdf(T7,0.05)

# ╔═╡ 71ccee6c-954d-11eb-3e12-67ac09508e82
cdf(N7,0.95)

# ╔═╡ fa5e8a3e-9556-11eb-2848-7f956824029a
oneTailSide(D,x)=cdf(D,(100-x)/100)

# ╔═╡ 2e2180ba-9557-11eb-2939-2fc2b751f1b1
oneTailSide(T7,95)

# ╔═╡ 9ca0dd58-956e-11eb-0f67-d9bee74ecd53
oneTailSide(N7,95)

# ╔═╡ 1c4ef89c-9537-11eb-279c-3b8c1710ad57
begin
	plot(-4:0.01:0.05,[cdf(T7,pt) for pt in -4:0.01:0.05],fill= (0, 0.5, :blue),line=7,label="T")
	plot!(0.05:0.01:4,[cdf(T7,pt) for pt in 0.05:0.01:4],line=7,label="T",layout=2)
	plot!(-4:0.01:0.05,[cdf(N7,pt) for pt in -4:0.01:0.05],fill= (0, 0.7, :Green),line=9,label="N")
	plot!(0.05:0.01:4,[cdf(N7,pt) for pt in 0.05:0.01:4],line=9,layout=2,label="N")
end

# ╔═╡ 6dd0336a-956f-11eb-1a7f-59d30b39cfc3
begin
	plot(-4:0.01:0.05,[cdf(T7,pt) for pt in -4:0.01:0.05],fill= (0, 0.5, :blue),line=7,label="T")
	plot!(0.05:0.01:4,[cdf(T7,pt) for pt in 0.05:0.01:4],line=7,label="T",layout=2)
end

# ╔═╡ 741e1176-956f-11eb-16b9-47735de8f621
begin
	plot(-4:0.01:0.05,[cdf(N7,pt) for pt in -4:0.01:0.05],fill= (0, 0.7, :Green),line=9,label="N")
	plot!(0.05:0.01:4,[cdf(N7,pt) for pt in 0.05:0.01:4],line=9,layout=2,label="N")
end

# ╔═╡ e029a8b4-9552-11eb-051a-f7f1268742c5
begin
	plot(-4:0.01:0.95,[cdf(N7,pt) for pt in -4:0.01:0.95])
	plot!(0.95:0.01:4,[cdf(N7,pt) for pt in 0.95:0.01:4],fill= (0, 0.2, :red),layout=2)
end

# ╔═╡ Cell order:
# ╠═7420c480-910c-11eb-2338-6bbd68005f0a
# ╠═4b759868-9494-11eb-1f4e-3d0ab484ec88
# ╠═131772d8-917f-11eb-1add-1f94cfb9bf63
# ╠═b0f0b9a4-938c-11eb-3929-331bdd555c4c
# ╠═298ff14c-910d-11eb-1088-efa7ab843b4f
# ╟─ee48c5f4-93a6-11eb-238f-1ffd8145a1ef
# ╟─00a18eb0-950b-11eb-2345-8774769664b7
# ╟─633f5438-9530-11eb-0091-4ded1bb596a6
# ╠═01cea346-9177-11eb-00a3-e3d8875dbc77
# ╠═975d87a0-9182-11eb-0147-919853fe6da4
# ╠═0c5ec226-9183-11eb-000c-c952dd92ade0
# ╠═dd1a76ce-9180-11eb-0ee8-9337eeb7f71a
# ╠═2f38094c-9181-11eb-20e9-bf788b2093f0
# ╠═a1be90a0-9186-11eb-3c36-fff654b98d91
# ╠═0ba1593a-9187-11eb-255f-478177875ea9
# ╟─2f609232-91ff-11eb-1e50-8fb6bac96e47
# ╟─17fbbf2e-950b-11eb-2975-eb0e773a4bfb
# ╟─68db2700-9530-11eb-17d1-6560d914cf03
# ╠═f7ae629a-91fb-11eb-0c2d-f114013f1cf7
# ╠═f2741aea-91fb-11eb-3e3e-3f1853d4e5a0
# ╠═8b462602-91ff-11eb-13db-27847df88df9
# ╠═cbed5580-91fb-11eb-37f0-494b8d6a253d
# ╠═ebb6b8e6-9511-11eb-03d7-b7083f3801dd
# ╠═eef7d312-9209-11eb-29ce-cf9b52413cf3
# ╠═33653a62-920a-11eb-3186-1162d17fb9fb
# ╠═cdff0544-91fb-11eb-259b-8772fde759c2
# ╠═da6aa228-9568-11eb-1f8a-394a3317e73a
# ╠═e9f4b8ac-956b-11eb-3846-fd4402457273
# ╠═57522c74-956a-11eb-1bb0-63b7d7f66d4a
# ╠═d3f35c72-9569-11eb-2b21-f1e3cefe5af2
# ╠═49afae20-9533-11eb-1a98-e9e5d53e83d5
# ╠═2eb828d6-950b-11eb-1269-4f21a352add0
# ╠═2e293962-9512-11eb-0811-c5fb0c48eb35
# ╠═c4403f24-9515-11eb-0f24-871cd41dc169
# ╠═fd4228f4-9516-11eb-0638-81a14573fa5b
# ╠═6fd2b282-9513-11eb-376e-3184f86d873a
# ╟─34d0c3d4-9530-11eb-3f1d-71b21908559a
# ╟─29dcc090-9530-11eb-0712-53d344512a93
# ╟─341b11cc-9530-11eb-2074-8b56a2d00c4e
# ╠═76301d3e-9530-11eb-363e-8bdfce50e084
# ╠═0f4fb344-9572-11eb-27ec-17bc62a50b01
# ╠═24eb5c96-9572-11eb-1f4e-4fc8eee5fccc
# ╠═74541438-9572-11eb-00b3-f181235bab5c
# ╠═7bfc20ae-9572-11eb-1f33-a14b0c4e64b1
# ╠═47c44ece-9572-11eb-0f58-3962cd4126d3
# ╠═1715b9f6-9573-11eb-25ba-c7bdd68019bc
# ╠═241770cc-9573-11eb-3360-fdfe7c993a22
# ╟─7401498e-9530-11eb-18ec-d54bcd9cc24e
# ╟─a90df21e-9394-11eb-0ff7-37cfc41afa04
# ╟─774c7b48-9530-11eb-194a-c55178f68605
# ╠═a88bdb1c-9394-11eb-1e74-7bd8f5df3bd9
# ╠═c1b23bec-9394-11eb-1b67-f5c5d9399cce
# ╠═f5648448-9394-11eb-16d1-8bee54c6cd04
# ╠═fad25ca2-9394-11eb-2619-810171823759
# ╠═fcb1f26c-9394-11eb-1460-4bccdabe09bc
# ╠═fc92123a-9394-11eb-3a5e-2135605e5e56
# ╠═445d3a02-9397-11eb-10ce-41c6e44124b5
# ╠═afbb4068-9395-11eb-36ef-5b96bd9928d8
# ╠═fc6e3d88-9394-11eb-2099-392f638b5de3
# ╠═794befd2-9398-11eb-1540-c1d46e036644
# ╟─3d4f525a-9530-11eb-2fbf-01d16d9134a9
# ╟─3c6ea28c-9530-11eb-0a0a-fd97e48763ce
# ╟─7d98ca88-9530-11eb-0c49-41739296b05f
# ╠═7f7a5d1c-9530-11eb-26a8-07bd5be93377
# ╟─43579cc2-950b-11eb-0050-117079ceb0c2
# ╟─81e22c1a-93a7-11eb-3c54-3dc5d37d1a9e
# ╟─8b801a0c-9530-11eb-314d-93629a5577ea
# ╠═0ab14aa2-93a9-11eb-2d57-eb405217aeca
# ╠═0f5f8730-93a9-11eb-10d5-b99d6c469e22
# ╠═c392491e-93df-11eb-3ced-7599ee6ea181
# ╠═cb23ef50-93c3-11eb-03dc-b5dc6280542f
# ╠═172470b4-9491-11eb-015f-13fba0607408
# ╠═554caf24-93c3-11eb-28ee-4163180e7649
# ╠═f3036fd6-93c4-11eb-3099-e5610582221b
# ╠═603ff93e-93c3-11eb-287f-4f3f92831712
# ╠═a3402dde-93da-11eb-0780-17fb27689e57
# ╠═d49bff9c-93db-11eb-1299-6b7f94d8987c
# ╠═08be43ac-93dc-11eb-2804-bd8927071733
# ╠═b9ad8452-93dc-11eb-1011-03bbbc391430
# ╠═26afac3e-9492-11eb-30cc-eb8b0e6157ec
# ╠═72c29f72-93df-11eb-3ff2-2bf3ed8ae0be
# ╠═4905a792-955e-11eb-0ea3-eb0bf7f37a7f
# ╠═59322866-955e-11eb-2816-31d577aa49f5
# ╠═b06a7732-955e-11eb-0d4b-159538d5cba3
# ╠═dc0cbeb6-9560-11eb-1522-57632d2c5f45
# ╠═f26ca8a6-9560-11eb-0d84-9dfc3ca7a0a9
# ╠═6a1d02a0-9562-11eb-3b6a-219df2741de7
# ╠═1cf21c86-9562-11eb-2228-63990d93f97b
# ╠═4346b2b6-9562-11eb-18da-9f0f9068fa3e
# ╠═56b36902-9562-11eb-3e00-3debd1117775
# ╠═77c4995e-9562-11eb-026b-1d52817bff3f
# ╟─5875082c-9530-11eb-3236-713805451b77
# ╟─07852b36-9530-11eb-12a5-7d0e1f5f1d43
# ╟─5a474a02-9530-11eb-11be-539d985758a9
# ╠═84a0c788-9530-11eb-0e55-1525d97e02b9
# ╠═fd838fb8-9536-11eb-03b4-5f183bb52852
# ╠═0d21d5ea-9537-11eb-02d7-3b5dfe34cf84
# ╠═71ccee6c-954d-11eb-3e12-67ac09508e82
# ╠═fa5e8a3e-9556-11eb-2848-7f956824029a
# ╠═2e2180ba-9557-11eb-2939-2fc2b751f1b1
# ╠═9ca0dd58-956e-11eb-0f67-d9bee74ecd53
# ╠═1c4ef89c-9537-11eb-279c-3b8c1710ad57
# ╠═6dd0336a-956f-11eb-1a7f-59d30b39cfc3
# ╠═741e1176-956f-11eb-16b9-47735de8f621
# ╠═e029a8b4-9552-11eb-051a-f7f1268742c5

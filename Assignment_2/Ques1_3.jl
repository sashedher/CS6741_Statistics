### A Pluto.jl notebook ###
# v0.12.21

using Markdown
using InteractiveUtils

# ╔═╡ 555c9480-7d92-11eb-1240-e3cda890e8af
using DataFrames,Dates,Statistics

# ╔═╡ 5af495f0-7f72-11eb-2f59-9f171fb892e6
md"Question-1"

# ╔═╡ 307e2510-7d93-11eb-1479-fb9f6573f6f6
religion=["Agnostic","Atheist","Buddhist","Catholic","Don’t know/refused", "Evangelical Prot","Hindu","Historically Black Prot","Jehovahs Witness","Jewish"]

# ╔═╡ 201f5c10-7d94-11eb-16fb-c5529f609121
begin
	lD10K=[27,12,27,418,15,575,1,228,20,19]
	D10k_D20K=[34,27,21,617,14,869,9,224,27,19]
	D20k_D30K=[60,27,30,732,15,1064,7,236,24,25]
	D30k_D40K=[81,52,34,670,11,982,9,238,24,25]
	D40k_D50K=[76,35,33,638,10,881,11,197,21,30]
	D50k_D75K=[137,70,58,1116,35,1486,34,223,30,95]
	D75k_D100K=[122,27,30,732,15,164,7,236,24,25]
	D100k_D150K=[109,27,21,617,14,982,9,238,24,25]
	GD150K=[84,70,58,16,35,10,7,236,24,25]
end

# ╔═╡ 938c0130-7d94-11eb-14be-91f7c792c630
Df1=DataFrame()

# ╔═╡ ad09ecc0-7d95-11eb-2bb4-f992f6f427c3
begin
	Df1.religion=religion
	Df1."<10K"=lD10K
	Df1."10k_20K"=D10k_D20K
	Df1."20k_30K"=D20k_D30K
	Df1."30k_40K"=D30k_D40K
	Df1."40k_50K"=D40k_D50K
	Df1."50k_75K"=D50k_D75K	
	Df1."75k-100k"=D75k_D100K
	Df1."100k-150k"=D100k_D150K
	Df1.">150"=GD150K
	
end

# ╔═╡ 19aff360-7d96-11eb-3d48-49d6f5a84ae6
Df1

# ╔═╡ 53ff51a0-7d96-11eb-25b5-49b238894ac3
Df1Stack=stack(Df1,1:10,:religion,variable_name=:Income,value_name=:Frequency)

# ╔═╡ 90eb2cb0-7d96-11eb-1782-3dd5711463f6
sort(Df1Stack)

# ╔═╡ 6d814600-7f72-11eb-192b-fd53918f065f


# ╔═╡ 6d66920e-7f72-11eb-31f7-373e69f16fd3


# ╔═╡ 6d4e0102-7f72-11eb-308f-0124ea17bd04


# ╔═╡ 6d25df92-7f72-11eb-3ce4-599a7259d4d2


# ╔═╡ 8aa4e630-7f61-11eb-105f-cb55fcfcaa0b
md"Question2"

# ╔═╡ 8a7068b0-7f61-11eb-0313-9f3a73f736fd


# ╔═╡ 6689d8ae-7f60-11eb-0731-1b2dd3dfeda2
begin
	Id=["MX000017001","MX000017001","MX000017002","MX000017002","MX000017003","MX000017003","MX000017005","MX000017005","MX000017007","MX000017007","MX000017007","MX000017007","MX000017008","MX000017009"]
	
	Year=[2010,2010,2011,2011,2013,2013,2014,2014,2016,2016,2019,2019,2020,2020]
	
	Month=[1,1,2,2,3,3,3,3,7,7,8,8,10,10]
	
	Element=["tmax","tmin","tmax","tmin","tmax","tmin","tmax","tmin","tmax","tmin","tmax","tmin","tmax","tmin"]
	
	d1=[40.8 ,35.2,26.6,20.4,missing,missing,missing,missing,36.3,26.7,23.4,15.6,missing,missing]
	
	d2=[missing,missing,missing,missing,52.5,26.7,missing,missing,missing,missing,23.2,15.6,missing,missing]
	
	d3=[30.7,25.9,missing,missing,missing,missing,missing,missing,23.2,15.0,missing,missing,missing,missing]
	
	d4=[missing,missing,34.6, 29.5,missing,missing,32.5, 31.5,36.3,26.7,23.4,15.6,missing,missing]
	
	d5=[30.7,25.9,missing,missing,56.1,26.3,missing,missing,23.8,15.1,missing,missing,missing,missing]
	
	d6=[32.5, 31.5,missing,missing,56.1,26.3,missing,missing,24.9,15.3,missing,missing,missing,missing]
	
	d7=[27.5 ,20.9,23.4, 22.0,56.1,26.3,missing,missing,20.3,19.8,missing,missing,missing,missing]
	
	d8=[missing,missing,missing,missing, 29.4 ,15.8 ,40.8 ,35.2,missing,missing,23.7,15.1,missing,missing]
	
	d9=[30.7,25.9,missing,missing,56.1,26.3,missing,missing,29.4 ,15.8,missing,missing,missing,missing]
	
	d10=[30.7,25.8,23.4, 22.0,56.1,26.3,missing,missing,40.8 ,35.2,missing,missing,missing,missing]
	
	d11=[30.7,25.9,missing,missing,56.1,26.3,missing,missing,34.7,25.5,missing,missing,missing,missing]
end

# ╔═╡ 5312ddc0-7f62-11eb-289b-d18d16ad8ef1
length(d11)

# ╔═╡ b7ea86e0-7dc2-11eb-3b88-1119620415fe
Dfr2=DataFrame()

# ╔═╡ e250e1d0-7d96-11eb-2973-49050dacb75f
begin
	Dfr2.Id=Id
	Dfr2.Year=Year
	Dfr2.Month=Month
	Dfr2.Element=Element
	Dfr2.d1=d1
	Dfr2.d2=d2
	Dfr2.d3=d3
	Dfr2.d4=d4
	Dfr2.d5=d5
	Dfr2.d6=d6
	Dfr2.d7=d7
	Dfr2.d8=d8
	Dfr2.d9=d9
	Dfr2.d10=d10
	Dfr2.d11=d11
end

# ╔═╡ a80721b0-7dbe-11eb-0241-e346f08eedc1
Dfr2

# ╔═╡ a80525de-7dbe-11eb-108a-69a6a778b3e2
stDfr2=stack(Dfr2, Not([:Id,:Year,:Month,:Element]))

# ╔═╡ a78ee470-7dbe-11eb-3c17-5b2aed9c915e
filter!(row->!ismissing(row.value), stDfr2)

# ╔═╡ aeedcf90-7f64-11eb-0dd6-55b7453e8a98
ustDfr2=unstack(stDfr2,:Element,:value)

# ╔═╡ 6bdf9a5e-7f66-11eb-228d-cf21d80de6c2
ustDfr2.variable .= replace.(ustDfr2.variable, r"^d"=>"")

# ╔═╡ 537eb460-7f61-11eb-1fe8-2db20ecf677b
ustDfr2

# ╔═╡ 92087fa0-7f6f-11eb-3d7e-b98073918da0
date=[]

# ╔═╡ 3add4852-7f6f-11eb-2d96-3928485cc42c
for i in eachrow(ustDfr2)
	push!(date,Date(string(i.Year)*"-"*string(i.Month)*"-"*"0"*string(i.variable),Dates.DateFormat("yyyy-mm-dd")))
	
end

# ╔═╡ b5aa8200-7f6f-11eb-0c12-eb6461fd751a
length(date)

# ╔═╡ 899721e0-7f70-11eb-2f3d-9725ce3a4fda
insertcols!(ustDfr2, 3, :date => date)

# ╔═╡ 784f2e30-7f6d-11eb-2db8-5d26ce1ba757
select!(ustDfr2,Not([:Year,:Month,:variable]))

# ╔═╡ 76e7d600-7f6d-11eb-2302-393d9b148b6d
sort(ustDfr2)

# ╔═╡ 085202c0-7f6c-11eb-2d9f-0d1f35b48c9c


# ╔═╡ 534f18e0-7f61-11eb-0286-dd9bef9f47cb


# ╔═╡ 5335c480-7f61-11eb-3855-ab79e2f66163


# ╔═╡ 53065010-7f61-11eb-10be-07ef0d5a0b56
md"Question3"

# ╔═╡ 52f0cc40-7f61-11eb-0a20-9795c9f8e11f
Df3=DataFrame()

# ╔═╡ 52bf34f0-7f61-11eb-3b48-510796eff75a


# ╔═╡ 52a396a0-7f61-11eb-27a3-4d3298ab9ff1


# ╔═╡ Cell order:
# ╟─5af495f0-7f72-11eb-2f59-9f171fb892e6
# ╠═555c9480-7d92-11eb-1240-e3cda890e8af
# ╠═307e2510-7d93-11eb-1479-fb9f6573f6f6
# ╠═201f5c10-7d94-11eb-16fb-c5529f609121
# ╠═938c0130-7d94-11eb-14be-91f7c792c630
# ╠═ad09ecc0-7d95-11eb-2bb4-f992f6f427c3
# ╠═19aff360-7d96-11eb-3d48-49d6f5a84ae6
# ╠═53ff51a0-7d96-11eb-25b5-49b238894ac3
# ╠═90eb2cb0-7d96-11eb-1782-3dd5711463f6
# ╠═6d814600-7f72-11eb-192b-fd53918f065f
# ╠═6d66920e-7f72-11eb-31f7-373e69f16fd3
# ╠═6d4e0102-7f72-11eb-308f-0124ea17bd04
# ╠═6d25df92-7f72-11eb-3ce4-599a7259d4d2
# ╟─8aa4e630-7f61-11eb-105f-cb55fcfcaa0b
# ╠═8a7068b0-7f61-11eb-0313-9f3a73f736fd
# ╠═6689d8ae-7f60-11eb-0731-1b2dd3dfeda2
# ╠═5312ddc0-7f62-11eb-289b-d18d16ad8ef1
# ╠═b7ea86e0-7dc2-11eb-3b88-1119620415fe
# ╠═e250e1d0-7d96-11eb-2973-49050dacb75f
# ╠═a80721b0-7dbe-11eb-0241-e346f08eedc1
# ╠═a80525de-7dbe-11eb-108a-69a6a778b3e2
# ╠═a78ee470-7dbe-11eb-3c17-5b2aed9c915e
# ╠═aeedcf90-7f64-11eb-0dd6-55b7453e8a98
# ╠═6bdf9a5e-7f66-11eb-228d-cf21d80de6c2
# ╠═537eb460-7f61-11eb-1fe8-2db20ecf677b
# ╠═92087fa0-7f6f-11eb-3d7e-b98073918da0
# ╠═3add4852-7f6f-11eb-2d96-3928485cc42c
# ╠═b5aa8200-7f6f-11eb-0c12-eb6461fd751a
# ╠═899721e0-7f70-11eb-2f3d-9725ce3a4fda
# ╠═784f2e30-7f6d-11eb-2db8-5d26ce1ba757
# ╠═76e7d600-7f6d-11eb-2302-393d9b148b6d
# ╠═085202c0-7f6c-11eb-2d9f-0d1f35b48c9c
# ╠═534f18e0-7f61-11eb-0286-dd9bef9f47cb
# ╠═5335c480-7f61-11eb-3855-ab79e2f66163
# ╟─53065010-7f61-11eb-10be-07ef0d5a0b56
# ╠═52f0cc40-7f61-11eb-0a20-9795c9f8e11f
# ╠═52bf34f0-7f61-11eb-3b48-510796eff75a
# ╠═52a396a0-7f61-11eb-27a3-4d3298ab9ff1

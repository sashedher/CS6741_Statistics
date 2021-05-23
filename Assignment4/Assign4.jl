### A Pluto.jl notebook ###
# v0.12.21

using Markdown
using InteractiveUtils

# ╔═╡ acbb6c00-aaa2-11eb-2d6b-d191767dda77
begin
	using Distributions
	using StatsBase
	using Plots
	using Random
	using StatsPlots
end

# ╔═╡ b5977330-b288-11eb-048c-ffced02befe7
md""" 
.

### Question-1
"""

# ╔═╡ 88720a40-aa9b-11eb-2b96-ddbec77c908e
face=1:2

# ╔═╡ 7e66f9b0-aa9c-11eb-33b5-e9cad8d2d5db
## using Monte Carlo Simulation

begin
	prob=0
	for _ in range(1,length=100000)
		ch=0
		ct=0
		for _ in range(1,length=50)
			if(rand(face)==1)
				ch=ch+1
			else
				ct=ct+1
			end
		end
		if(ch>=30)
			prob=prob+1
		end
	end
prob/100000
end




# ╔═╡ 25e74400-aa9e-11eb-2ef7-916bd753100b


# ╔═╡ 90295100-b093-11eb-1a91-cd3b45e1775b
 0.078649

# ╔═╡ 1952cca0-aaa3-11eb-26ae-8d59ebf10c07
## using Binomial

begin
bn=Binomial(50)	
bprob=0
	for i in range(30,length=51)
		bprob=bprob+pdf(bn,i)
	end
bprob	
end

# ╔═╡ 69cdbe80-aaa1-11eb-2538-e172fc422784
pdf(bn,0)

# ╔═╡ 25fb3230-b025-11eb-0b63-05e1a1a8b132
# mean np=50*0.5=25
#sigma=sqrt(np(1-p))=3.5355
zscre=zscore([30,29.5],25,3.5355)

# ╔═╡ 933919b0-b0ee-11eb-15d2-7b8950167419
## using CLT
1-cdf(Normal(0,1),zscre[2])

# ╔═╡ 9f2c3c70-b0f3-11eb-3ea8-a73e9a8bbe35
md"
.

### Question 2"

# ╔═╡ 406bbd20-b281-11eb-2d3f-f12dbf7a154e
# mean np=50*0.55=27.5
#sigma=sqrt(np(1-p))=3.5178
zscre2=zscore([30,29.5],29.5,3.4777)

# ╔═╡ 6ad40550-b280-11eb-3ea1-67d2d0d37ed8
## using Clt
1-cdf(Normal(0,1),zscre2[2])

# ╔═╡ 6fc3bdc0-b27c-11eb-2c27-2311baf73401
## using Monte Carlo Simulation


begin
	prob2=0
	for _ in range(1,length=1000000)
		smpls=[]
		hds=0
		for _ in range(1,length=50)
			push!(smpls,rand(1:100))
		end		
		for i in smpls
			if(i<=59)
				hds+=1
			end
		end
		# ct		
		if(hds>=30)
			prob2=prob2+1
		end
	end
prob2/1000000
end

# ╔═╡ 9b745280-b27d-11eb-29f0-51a351c5b076
## using Binomial

begin
bn2=Binomial(50,0.59)	
bprob2=0
	for i in range(30,length=50)
		bprob2=bprob2+pdf(bn2,i)
	end
bprob2	
end

# ╔═╡ c28a5ec0-b145-11eb-31f7-af04c6ef45a1
md""".



### Question-3
"""

# ╔═╡ f5c7a780-b14e-11eb-1d91-33b8274d884d


# ╔═╡ f55536a0-b14e-11eb-1f65-41194af9d420
begin
	d=0
	for i in 1:50
		if((1-cdf(Normal(100*i,30*sqrt(i)),3000))>=0.95)
			d=i
			break
		end
	end
	"Minimum number of space suits required are "*string(d)
end

# ╔═╡ f6b06ef0-b150-11eb-1971-43bdf2aa9ffc
md"""Minimum noof space suits you need to pack to last 3000 days with a probability atleast  95%  are 33 """

# ╔═╡ 6bb89f1e-b263-11eb-3faf-33c18b1d0000


# ╔═╡ 5f7aedd0-b1b9-11eb-1bd7-3572b2b08b64
md"""
.


### Question-4

"""

# ╔═╡ 2ac03980-b284-11eb-0804-ad53bc3453cc
function Compare(dist)
	Random.seed!(0)
	for i in 2:200
		smps=[]
		for _ in 1:1000
			x=rand(dist,i)
			y=(x.-mean(x))./std(x)
			push!(smps,mean(y))
		end
		smps=smps*sqrt(i)
		
		mn=abs(mean(smps))-abs(mean(Normal(0,1)))
		std_dev=abs(std(smps))-abs(std(Normal(0,1)))
		skew=abs(skewness(smps))-abs(skewness(Normal(0,1)))
		krt=abs(kurtosis(smps))-abs(kurtosis(Normal(0,1)))
		
		
		if(mn<0.10 && std_dev<0.10 && skew<0.10 && krt<0.10)
			return i
		end
	end
end
		
			

# ╔═╡ 14fae1c0-b286-11eb-24cd-695c0915edfb
"Minimum sample size  for uniform(0,1) derived from CLT to be reasonably close to Normal(0,1) is "*string(Compare(Uniform(0,1)))

# ╔═╡ e30c380e-b287-11eb-2b5b-1d80711d62aa
"Minimum sample size  for BInomial(100,0.01) derived from CLT to be reasonably close to Normal(0,1) is "*string(Compare(Binomial(100,0.01)))

# ╔═╡ f5c0bb70-b287-11eb-3231-1357c48205f6
"Minimum sample size  for Binomial(100,0.5) derived from CLT to be reasonably close to Normal(0,1) is "*string(Compare(Binomial(100,0.5)))

# ╔═╡ 0f90b410-b288-11eb-1fa9-1b8a3d99b32d
"Minimum sample size  for Chisq(3) derived from CLT to be reasonably close to Normal(0,1) is "*string(Compare(Chisq(3)))

# ╔═╡ Cell order:
# ╠═acbb6c00-aaa2-11eb-2d6b-d191767dda77
# ╠═b5977330-b288-11eb-048c-ffced02befe7
# ╠═88720a40-aa9b-11eb-2b96-ddbec77c908e
# ╠═7e66f9b0-aa9c-11eb-33b5-e9cad8d2d5db
# ╠═25e74400-aa9e-11eb-2ef7-916bd753100b
# ╠═69cdbe80-aaa1-11eb-2538-e172fc422784
# ╠═90295100-b093-11eb-1a91-cd3b45e1775b
# ╠═1952cca0-aaa3-11eb-26ae-8d59ebf10c07
# ╠═25fb3230-b025-11eb-0b63-05e1a1a8b132
# ╠═933919b0-b0ee-11eb-15d2-7b8950167419
# ╟─9f2c3c70-b0f3-11eb-3ea8-a73e9a8bbe35
# ╠═406bbd20-b281-11eb-2d3f-f12dbf7a154e
# ╠═6ad40550-b280-11eb-3ea1-67d2d0d37ed8
# ╠═6fc3bdc0-b27c-11eb-2c27-2311baf73401
# ╠═9b745280-b27d-11eb-29f0-51a351c5b076
# ╟─c28a5ec0-b145-11eb-31f7-af04c6ef45a1
# ╠═f5c7a780-b14e-11eb-1d91-33b8274d884d
# ╠═f55536a0-b14e-11eb-1f65-41194af9d420
# ╟─f6b06ef0-b150-11eb-1971-43bdf2aa9ffc
# ╠═6bb89f1e-b263-11eb-3faf-33c18b1d0000
# ╟─5f7aedd0-b1b9-11eb-1bd7-3572b2b08b64
# ╠═2ac03980-b284-11eb-0804-ad53bc3453cc
# ╠═14fae1c0-b286-11eb-24cd-695c0915edfb
# ╠═e30c380e-b287-11eb-2b5b-1d80711d62aa
# ╠═f5c0bb70-b287-11eb-3231-1357c48205f6
# ╠═0f90b410-b288-11eb-1fa9-1b8a3d99b32d

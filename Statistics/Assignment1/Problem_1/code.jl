### A Pluto.jl notebook ###
# v0.12.21

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

# ╔═╡ cb820fe0-7401-11eb-1344-8b6b1228d028
using PlutoUI

# ╔═╡ 3b717520-7402-11eb-0778-43b3be64c40e
begin
	using Plots
	pyplot()
end

# ╔═╡ ac805422-7402-11eb-0803-8b536fb0561c
@bind Run Button("Run")

# ╔═╡ 4488ba60-7402-11eb-2ced-af811992f296
begin
	Run
	using Random
	Random.seed!(0)
	
end

# ╔═╡ 4dfc9e92-7402-11eb-1497-f14b06e56f12
begin
	Run
	samples=[]
	samples_avg=[]
	
end

# ╔═╡ 3d71b1f0-7402-11eb-08d5-278c98905fda
rang=-1000:1000

# ╔═╡ 3d52b840-7402-11eb-1040-85398e2cc0a3
begin
	Run
	length(samples)
	length(samples_avg)
end

# ╔═╡ 3d1f733e-7402-11eb-1ed2-8bdf1ae4bf06
begin
	Run
	for i in range(1,stop=10000)
		push!(samples,rand(rang))
		push!(samples_avg,/(sum(samples),length(samples)))
	end
end

# ╔═╡ 3cee2a10-7402-11eb-0638-4f42c52fc862
begin
	Run
	plot(1:10000,samples_avg,seriestype = :scatter)
end

# ╔═╡ 235ab350-7404-11eb-3615-cd756b298ad1
begin
	Run
	length(samples)
end

# ╔═╡ 3c8ecc00-7402-11eb-0b39-ad893916f0ef
begin
	Run
	length(samples_avg)
end

# ╔═╡ Cell order:
# ╠═cb820fe0-7401-11eb-1344-8b6b1228d028
# ╠═3b717520-7402-11eb-0778-43b3be64c40e
# ╠═ac805422-7402-11eb-0803-8b536fb0561c
# ╠═4488ba60-7402-11eb-2ced-af811992f296
# ╠═4dfc9e92-7402-11eb-1497-f14b06e56f12
# ╠═3d71b1f0-7402-11eb-08d5-278c98905fda
# ╠═3d52b840-7402-11eb-1040-85398e2cc0a3
# ╠═3d1f733e-7402-11eb-1ed2-8bdf1ae4bf06
# ╠═3cee2a10-7402-11eb-0638-4f42c52fc862
# ╠═235ab350-7404-11eb-3615-cd756b298ad1
# ╠═3c8ecc00-7402-11eb-0b39-ad893916f0ef

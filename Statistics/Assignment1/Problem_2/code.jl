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

# ╔═╡ 71cac7c0-7407-11eb-3369-470fde1b6566
using PlutoUI


# ╔═╡ c7ce47f0-7407-11eb-0f5c-b9c3bb299397
begin
	using Plots
	pyplot()
end

# ╔═╡ 940009c0-74c2-11eb-1247-411a855658ad
using Combinatorics


# ╔═╡ 5d7ee560-7521-11eb-3bf4-8707fcba2dd7
begin
	using Random
	Random.seed!(0)
end

# ╔═╡ 220534c0-751d-11eb-3d8e-2d1d28c2c52e
A=[]

# ╔═╡ d8bd74a2-7407-11eb-138b-cdafa80dda09
for i in 1:52
	push!(A,i)
end

# ╔═╡ 78a67430-7520-11eb-20ee-f168b7c294f8
length(A)

# ╔═╡ 0735c620-7520-11eb-3cd5-3ffa314db0e4
@bind n1 html"<input type=range min=1 max=5>"

# ╔═╡ cf4941a0-7520-11eb-0b8f-0d06580d9bfa
n1

# ╔═╡ bf9d5872-7522-11eb-0123-5b30ef82c08c
begin
	Avg=[]
	ar=[]
end

# ╔═╡ 6bd4d550-753c-11eb-06aa-897531aebbfb
md"With Replacement"

# ╔═╡ 426a6960-7522-11eb-1718-85b40df127fd
@bind Run Button("Run")

# ╔═╡ 99064b42-751d-11eb-3462-c91d5d657b02
begin
	Run
	for j in 1:10
		count=0
		for i in 1:1000
			temp=0
			for i in 1:5
				if(rand(A)%13==0) 
					temp+=1
				end
			end
			if(temp==n1) 
				count+=1
			end

		end
		push!(ar,count/1000)
	end
end

# ╔═╡ dec68cd2-7536-11eb-1e0d-fb6ca9f4ccac
length(ar)

# ╔═╡ 9c031f6e-753c-11eb-0dba-2d7260ae1945
md"Theatrical Value for with Replacement"

# ╔═╡ e9db8830-74c5-11eb-1f57-5d9b6ea33cc9
binomial(5,n1)*((1/13)^n1)*(12/13)^(5-n1)

# ╔═╡ 464cc1c0-7524-11eb-2eee-6565ace2286f
begin
	Run
	/(sum(ar),length(ar))
end

# ╔═╡ 2b751290-7523-11eb-32f5-193360835347
begin
	Run
	plot(1:length(ar),ar)
	
end

# ╔═╡ c963aaf0-7539-11eb-32bc-33c44a392bfd
md"Without Replacement"

# ╔═╡ 18fe5d20-74c3-11eb-1f78-b3e70275db4a
@bind n html"<input type=range min=1 max=5>"

# ╔═╡ 9b1b3b70-74c3-11eb-171b-1f7f3752cbe1
n

# ╔═╡ 90dc8990-7539-11eb-2ff3-8f81a9d6c100
@bind Run2 Button("Run2")

# ╔═╡ 7a741e90-753c-11eb-07fc-15bd89f203e6
md"Theatrical Value for without Replacement"

# ╔═╡ 4b7a67d0-74c3-11eb-3e56-3f79f5760a94

pr=(binomial(4,n)*binomial(48,5-n))/binomial(52,5)

# ╔═╡ 20702560-74e7-11eb-31ea-4d2b9130f585
begin
	Run2
	for j in 1:100
		cn=0
		for i in 1:10000
			tem=0
			A1=copy(A)
			for j in 1:5
				tp=rand(A1)
				if(tp%13==0)
					tem+=1
					deleteat!(A1, findall(x->x==tp, A1))
				end
			end
			if(tem==n)
				cn+=1
			end
		end
		push!(Avg,cn/10000)
	end			
end

# ╔═╡ 02d72820-753a-11eb-0209-ff4aef58b8bc
length(Avg)

# ╔═╡ ea2c4e90-7539-11eb-17df-8d1ef2f290c9
/(sum(Avg),length(Avg))

# ╔═╡ 35047030-7532-11eb-0e2b-97eb3eb62e4e
begin
	Run2
	plot(1:length(Avg),Avg)
	
end

# ╔═╡ Cell order:
# ╠═71cac7c0-7407-11eb-3369-470fde1b6566
# ╠═c7ce47f0-7407-11eb-0f5c-b9c3bb299397
# ╠═940009c0-74c2-11eb-1247-411a855658ad
# ╠═220534c0-751d-11eb-3d8e-2d1d28c2c52e
# ╠═d8bd74a2-7407-11eb-138b-cdafa80dda09
# ╠═78a67430-7520-11eb-20ee-f168b7c294f8
# ╠═5d7ee560-7521-11eb-3bf4-8707fcba2dd7
# ╠═0735c620-7520-11eb-3cd5-3ffa314db0e4
# ╠═cf4941a0-7520-11eb-0b8f-0d06580d9bfa
# ╠═bf9d5872-7522-11eb-0123-5b30ef82c08c
# ╠═6bd4d550-753c-11eb-06aa-897531aebbfb
# ╠═426a6960-7522-11eb-1718-85b40df127fd
# ╠═99064b42-751d-11eb-3462-c91d5d657b02
# ╠═dec68cd2-7536-11eb-1e0d-fb6ca9f4ccac
# ╟─9c031f6e-753c-11eb-0dba-2d7260ae1945
# ╠═e9db8830-74c5-11eb-1f57-5d9b6ea33cc9
# ╠═464cc1c0-7524-11eb-2eee-6565ace2286f
# ╠═2b751290-7523-11eb-32f5-193360835347
# ╟─c963aaf0-7539-11eb-32bc-33c44a392bfd
# ╠═18fe5d20-74c3-11eb-1f78-b3e70275db4a
# ╠═9b1b3b70-74c3-11eb-171b-1f7f3752cbe1
# ╠═90dc8990-7539-11eb-2ff3-8f81a9d6c100
# ╟─7a741e90-753c-11eb-07fc-15bd89f203e6
# ╠═4b7a67d0-74c3-11eb-3e56-3f79f5760a94
# ╠═20702560-74e7-11eb-31ea-4d2b9130f585
# ╠═02d72820-753a-11eb-0209-ff4aef58b8bc
# ╠═ea2c4e90-7539-11eb-17df-8d1ef2f290c9
# ╠═35047030-7532-11eb-0e2b-97eb3eb62e4e

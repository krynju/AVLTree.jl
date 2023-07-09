@testset "set.jl" begin
    @testset "basic" begin
        s = AVLSet()
        items = ["anything", "anything2"]
        push!(s, items[1])
        r = collect(s)
        @test length(r) == 1
        @test items[1] in r
        push!(s, items[2])
        r = collect(s)
        @test length(r) == 2
        @test all(items .∈ Ref(s))
        @test all(items .∈ Ref(r))
        delete!(s, items[1])
        delete!(s, items[2])
        @test isempty(s)
    end

    @testset "constructor with AbstractVector input" begin
        items = rand(1_000)
        s = AVLSet(items)
        @test eltype(items) == eltype(s)
        @test all(items .∈ Ref(s))
        @test all(items .∈ Ref(collect(s)))
    end

    @testset "union" begin
        a = rand(1:1000, 800)
        b = rand(1:1000, 800)

        avl_a = AVLSet(a)
        avl_b = AVLSet(b)

        sa = Set(a)
        sb = Set(b)

        @test union(avl_a, avl_b) == union(sa, sb)
        @test union(avl_a, avl_a) == union(sa, sa)
        @test union(avl_a, avl_b, avl_b) == union(sa, sb)
        @test union(avl_a, sb, avl_b, avl_a, sb) == union(sa, sb)
        @test union!(avl_a, avl_b) == union(sa, sb)
        @test union!(avl_b, avl_a) == union(sa, sb)
    end

    @testset "setdiff" begin
        a = rand(1:1000, 800)
        b = rand(1:1000, 800)

        avl_a = AVLSet(a)
        avl_b = AVLSet(b)

        sa = Set(a)
        sb = Set(b)

        @test setdiff(avl_a, avl_b, avl_b) == setdiff(sa, sb)
        @test setdiff(avl_a, avl_a) == setdiff(sa, sa)
        @test setdiff(avl_a, sb) == setdiff(sa, sb)
    end

    @testset "intersect" begin
        a = rand(1:1000, 800)
        b = rand(1:1000, 800)

        avl_a = AVLSet(a)
        avl_b = AVLSet(b)

        sa = Set(a)
        sb = Set(b)

        @test intersect(avl_a, avl_b) == intersect(sa, sb)
        @test intersect(avl_a, avl_a) == intersect(sa, sa)
    end
end

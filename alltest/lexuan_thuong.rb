require 'minitest/autorun'
require './cs253Array.rb'
require './cs253Range.rb'
require './triple.rb'
require 'prime'
require './cs253Foo.rb'
include CS253Enumerable

class CS253EnumTests < Minitest::Test

    def test_cs253all?
		a = CS253Array.new(%w[rolling waves result])
		b = Triple.new([4,5,6],[1], [0,2])
		assert_equal a.all?{ |word| word.length >= 2 }, a.cs253all? { |word| word.length >= 2 }
		assert_equal a.all? { |word| word.length <= 4 }, a.cs253all? { |word| word.length <= 4 }
		assert_equal false, b.cs253all? {|e| e.size >2 }
    end

    def test_cs253any?
	    a = CS253Array.new(["string", "anotherString", "lastString"])
	    b = Triple.new("rock", 13, 'c')
	    assert_equal a.any?{ |word| word.length >= 5 }, a.cs253any? { |word| word.length >= 5 }
	    assert_equal true, b.cs253any? {|e| e.class == String}
	    assert_equal true, b.cs253any? {|e| e%13 == 0}
	end

	def test_cs253chunk
		a = CS253Array.new([3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5])
		assert_equal a.chunk { |n| n.even?}.to_a,  a.cs253chunk { |n| n.even?}
		assert_equal a.chunk { |n| Prime.prime? (n)}.to_a, a.cs253chunk { |n| Prime.prime? (n)}
		assert_equal [[true, [3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5]]], a.cs253chunk { |n| n.class == Integer}
	end 

	def test_cs253chunk_while
		a = CS253Array.new([0,11,12,15,1,2,4,4,20,21])
		assert_equal a.chunk_while{|i, j| i == j }.to_a, a.cs253chunk_while {|i, j| i == j }
		assert_equal a.chunk_while{|i, j| i <= j }.to_a, a.cs253chunk_while {|i, j| i <= j }
		assert_equal a.chunk_while {|i, j| i.floor == j.floor }.to_a, a.cs253chunk_while {|i, j| i.floor == j.floor }
	end

	def test_cs253collect
		a = Triple.new("doctor", "save", "")
		b = CS253Range.new(2,10)
		assert_equal ["", "", ""], a.cs253collect{|e| ""}
		assert_equal b.collect {|i| i*i }, b.cs253collect {|i| i*i }
		assert_equal b.collect {|i| i.even?}, b.cs253collect {|i| i.even?}
	end

	def test_cs253count
		a = CS253Array.new([1,5,4,1])
		assert_equal a.count, a.cs253count
		assert_equal a.count(1), a.cs253count(1)
		assert_equal a.count{|x| x%5==0}, a.cs253count{|x| x%5==0}
	end

	# collect_concat

	def test_cs253cycle
		a = Triple.new("doctor", 256, true)
		assert_nil a.cs253cycle(3) {|x| x}
		b = CS253Range.new(-5,3)
		assert_equal b.cycle(1) {|x| x}, b.cs253cycle(1) {|x| x}
		# assert_equal b.cycle {|x| puts x}, b.cs253cycle {|x| puts x} - runs forever
	end

	def test_cs253detect
		a = CS253Array.new([0,11,12,15,1,2,4,4,20,21])
		assert_equal a.detect{ |i| i%3 == 0}, a.cs253detect{ |i| i%3 == 0}
		assert_equal a.detect{ |i| i%2 == 0}, a.cs253detect{ |i| i%2 == 0}
		assert_equal a.detect{ |i| Prime.prime? (i)}, a.cs253detect{ |i| Prime.prime? (i)}
	end


	def test_cs253drop
		a = CS253Array.new([0,11,12,15,1,2,4,4,20,21])
		assert_equal a.drop(3), a.cs253drop(3)
		assert_equal a.drop(a.size()), a.cs253drop(a.size())
		b = Triple.new("doctor", 256, true)
		assert_equal [], b.cs253drop(3)
	end

	def test_cs253dropwhile
		a = CS253Array.new([0,11,12,15,1,2,4,4,20,21])
		assert_equal a.drop_while {|i| i%2 == 0}, a.cs253drop_while {|i| i%2 == 0}
		assert_equal a.drop_while {|i| i > 20}, a.cs253drop_while {|i| i > 20}
		b = Triple.new([4,5,6],[1], [0,2])
		assert_equal [], b.cs253drop_while {|i| i.length() >= 0}
	end

	# TODO
	def test_cs253each_cons

	end

	def test_cs253each_entry
		assert_equal Foo.new.each_entry {|i| i}.to_a, Foo.new.cs253each_entry {|i| i}
		assert_equal Foo1.new.each_entry {|i| i}.to_a, Foo1.new.cs253each_entry {|i| i}
		assert_equal Foo2.new.each_entry {|i| i}.to_a, Foo2.new.cs253each_entry {|i| i}
	end

	def test_cs253select
		assert_equal ["man", "magnolia"] ,["", "man", "magnolia", "room", "Mars"].cs253select {|e| e.start_with? "m"}	
		assert_equal [2,4,5].select { |num|  num.even?  } ,[2,4,5].cs253select { |num|  num.even?  }
		assert_equal [1,2,3,4,5].select { |num|  num.even?  },[1,2,3,4,5].cs253select { |num|  num.even?  }
	end

	def test_cs253find_all
		assert_equal ["", "man", "magnolia", "room", "Mars"].cs253find_all{|e| e.start_with? "m"}	 ,["", "man", "magnolia", "room", "Mars"].cs253find_all {|e| e.start_with? "m"}	
		assert_equal [2,4,5].find_all { |num|  num.even?  },[2,4,5].cs253find_all { |num|  num.even?  }
		assert_equal [1,2,3,4,5].select { |num|  num.even?  },[1,2,3,4,5].cs253find_all { |num|  num.even?  }
	end

	# TODO
	def test_cs253each_slice 
	end

	def test_cs253max_by
		a = CS253Range.new(1,100)
		assert_equal ["3456"], "12 3456 789".scan(/\d+/).cs253max_by(&:length)
		assert_equal [12, 25, 38, 51, 64], a.cs253max_by(5) {|e| e % 13}
		assert_equal [-4096], [0x100, 1, -2**12].cs253max_by(1) {|e| e.bit_length}
	end

	def test_cs253_max
		assert_equal [6,1,2], (1..1000).cs253max(3){|a, b| a.gcd(6) <=> b.lcm(6)}
		assert_equal ["pelican", "rob", "horse"].max(2) {|a, b| a.length <=> b.length }, ["pelican", "rob", "horse"].cs253max(2) {|a, b| a.length <=> b.length }
		assert_equal [5, 1, 3, 4, 2].max(3){|a, b| a <=> b}, [5, 1, 3, 4, 2].cs253max(3){|a, b| a <=> b}
	end

	def test_cs253inject
		a = CS253Array.new([5,6,7,8,9,10])
		assert_equal a.inject { |sum, n| sum + n }, a.cs253inject { |sum, n| sum + n }
		assert_equal  "sheep", 
			(%w{ cat sheep bear }.cs253inject do |memo, word|
		    	memo.length > word.length ? memo : word
			end)
		assert_equal a.inject(2) { |product, n| product * n }	, a.cs253inject(2) { |product, n| product * n }	
	end

	def test_cs253entries
		a = CS253Array.new([0,11,12,15,1,2,4,4,20,21])
		b = CS253Range.new(-5,3)
		assert_equal a.entries, a.cs253entries
		assert_equal b.entries, b.cs253entries
		assert_equal (Prime.first 5).entries, (Prime.first 5).cs253entries
	end

	def test_cs253to_a
		a = CS253Array.new([0,11,12,15,1,2,4,4,20,21])
		b = CS253Range.new(-5,3)
		c = Triple.new([4,5,6],[1], [0,2])
		assert_equal a.to_a, a.cs253to_a
		assert_equal b.to_a, b.cs253to_a
		assert_equal [[4,5,6],[1], [0,2]], c.cs253to_a
	end

	def test_cs253first
		a = CS253Array.new([0,11,12,15,1,2,4,4,20,21])
		assert_equal a.first, a.cs253first
		assert_equal a.first(8), a.cs253first(8)
		b = Triple.new("doctor", 256, true)
		assert_equal "doctor", b.cs253first 
	end

	def test_cs253take
		a = CS253Array.new([0,11,12,15,1,2,4,4,20,21])
		assert_equal a.take(2), a.cs253take(2)
		assert_equal a.take(0), a.cs253take(0)
		b = Triple.new("doctor", 256, true)
		assert_equal ["doctor",256], b.cs253take(2) 
	end

	def test_cs253slice_when
		a = CS253Array.new([0,11,12,15,1,2,4,4,20,21])
		assert_equal a.slice_when {|i, j| i+1 != j }.to_a, a.cs253slice_when {|i, j| i+1 != j }
		assert_equal a.slice_when {|i, j| i <= j }.to_a, a.cs253slice_when {|i, j| i <= j }
		assert_equal a.slice_when {|i, j| i.even? == j.even? }.to_a, a.cs253slice_when {|i, j| i.even? == j.even?}
	end

	def test_cs253take_while
		a = CS253Array.new([0,11,12,15,1,2,4,4,20,21])
		assert_equal a.take_while {|i| Prime.prime? (i)}, a.cs253take_while {|i| Prime.prime? (i)  }
		assert_equal a.take_while {|i| i <= 10 }, a.cs253take_while {|i| i <= 10 }
		assert_equal a.take_while {|i, j| i.even? }, a.cs253take_while {|i, j| i.even?}

	end

	def test_cs253none?
		a = ["ror", "lasso", "tupic"]
		assert_equal a.none? { |word| word.length == 5 }, a.cs253none? { |word| word.length == 5 }
		assert_equal a.none? { |word| word.length > 10 }, a.cs253none? { |word| word.length > 10 }
		assert_equal [nil, false, true].cs253none?, [nil, false, true].none?
	end

	def test_cs253reduce
		a = CS253Array.new([5,6,7,8,9,10])
		assert_equal a.reduce { |sum, n| sum + n }, a.cs253reduce { |sum, n| sum + n }
		assert_equal  "sheep", 
			(%w{ cat sheep bear }.cs253reduce do |memo, word|
		    	memo.length > word.length ? memo : word
			end)
		assert_equal a.reduce(2) { |product, n| product * n }, a.cs253reduce(2) { |product, n| product * n }	
	end
end


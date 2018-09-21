require 'minitest/autorun'
require './triple.rb'
require './cs253Array.rb'


class CS253EnumTests < Minitest::Test

	def setup  #setup some arrays for all methods
        @int_triple = Triple.new(rand(999),rand(999),rand(999))

        @str_triple = Triple.new([*'a'..'z'].sample(rand(15)).join,[*'a'..'z'].sample(rand(15)).join,[*'a'..'z'].sample(rand(15)).join)

        @float_triple = Triple.new(rand,rand,rand)

        @bool_triple = Triple.new(nil, true, 99)
        @empty_triple = Triple.new()

    end

    def test_collect
        assert_equal @int_triple.cs253collect{|i| i.to_s}.to_a,@int_triple.collect{|i| i.to_s}.to_a
        assert_equal @str_triple.cs253collect{|i| i.length},@str_triple.collect{|i| i.length}
        assert_equal @float_triple.cs253collect{|i| i*100},@float_triple.collect{|i| i*100}
    end
    
    def test_all
    	assert_equal @int_triple.cs253all?{|i| i%2 == 0}, @int_triple.all?{|i| i%2 == 0}
        assert_equal @str_triple.cs253all?{|i| i.length>5},@str_triple.all?{|i| i.length>5}
        assert_equal @float_triple.cs253all?{|i| i.class == Float},@float_triple.all?{|i| i.class == Float}
        assert_equal @bool_triple.cs253all?, @bool_triple.all?
        assert_equal @empty_triple.cs253all?, @empty_triple.all? 
    end

    def test_any
        assert_equal @int_triple.cs253any?{|i| i%2 == 0}, @int_triple.any?{|i| i%2 == 0}
        assert_equal @str_triple.cs253any?{|i| i.length>5},@str_triple.any?{|i| i.length>5}
        assert_equal @float_triple.cs253any?{|i| i.class == Float},@float_triple.any?{|i| i.class == Float}
        assert_equal @bool_triple.cs253any?, @bool_triple.any?
        assert_equal @empty_triple.cs253any?, @empty_triple.any? 
    end

    def test_chunk
    	assert_equal @int_triple.cs253chunk{|i| i%2 == 0}, @int_triple.chunk{|i| i%2 == 0}.to_a
        assert_equal @str_triple.cs253chunk{|i| i.length>5},@str_triple.chunk{|i| i.length>5}.to_a
        assert_equal @float_triple.cs253chunk{|i| i.class == Float},@float_triple.chunk{|i| i.class == Float}.to_a
    end

    def test_chunk_while
    	assert_equal @int_triple.cs253chunk_while{|i| i%2 == 0}, @int_triple.chunk_while{|i| i%2 == 0}.to_a
        assert_equal @str_triple.cs253chunk_while{|i| i.length>5},@str_triple.chunk_while{|i| i.length>5}.to_a
        assert_equal @float_triple.cs253chunk_while{|i| i.class == Float},@float_triple.chunk_while{|i| i.class == Float}.to_a
    end

    def test_collect_concat
    	assert_equal @int_triple.cs253collect_concat{|i| i + 100}, @int_triple.collect_concat{|i| i+100}.to_a
        assert_equal @str_triple.cs253chunk{|i| i.length>5},@str_triple.chunk{|i| i.length>5}.to_a
        assert_equal @float_triple.cs253chunk{|i| i.class == Float},@float_triple.chunk{|i| i.class == Float}.to_a
        assert_equal [[1, 2], [3, 4]].cs253collect_concat{ |e| e + [100] }, [[1, 2], [3, 4]].collect_concat{ |e| e + [100] }   
    end

    def test_count
    	assert_equal @int_triple.cs253count{|i| i%2 == 0}, @int_triple.count{|i| i%2 == 0}
        assert_equal @str_triple.cs253count{|i| i.length>5},@str_triple.count{|i| i.length>5}
        assert_equal @float_triple.cs253count{|i| i.class == Float},@float_triple.count{|i| i.class == Float}
    end

    def test_cycle
    	cs253a = []
    	a = []
    	@int_triple.cs253cycle(5){|e| cs253a << e}
    	@int_triple.cycle(5){|e| a << e}
    	assert_equal cs253a,a
    	cs253b = []
    	b = []
        @str_triple.cs253cycle(5){|e| cs253b << e.length}
        @str_triple.cycle(5){|e| b << e.length}
        assert_equal cs253b,b
        cs253c = []
        c = []
        @float_triple.cs253cycle(5){|e| cs253c << e*100}
        @float_triple.cycle(5){|e| c << e*100}
        assert_equal cs253c,c
    end

    def test_detect
    	assert_equal @int_triple.cs253detect{|i| i%2 == 0}, @int_triple.detect{|i| i%2 == 0}
        assert_equal @str_triple.cs253detect{|i| i.length>3},@str_triple.detect{|i| i.length>3}
        assert_equal @float_triple.cs253detect{|i| i.class == Float},@float_triple.detect{|i| i.class == Float}
    end

    def test_drop
    	n = rand(10)
    	assert_equal @int_triple.cs253drop(n), @int_triple.drop(n)
        assert_equal @str_triple.cs253drop(n),@str_triple.drop(n)
        assert_equal @float_triple.cs253drop(n),@float_triple.drop(n)
    end

    def test_drop_while
    	assert_equal @int_triple.cs253drop_while{|i| i%2 == 0}, @int_triple.drop_while{|i| i%2 == 0}
        assert_equal @str_triple.cs253drop_while{|i| i.length>5},@str_triple.drop_while{|i| i.length>5}
        assert_equal @float_triple.cs253drop_while{|i| i.class == Float},@float_triple.drop_while{|i| i.class == Float}
    end

    def test_each_cons 
        cs253a = []
        a = [] 
    	@int_triple.cs253each_cons(2){|e| cs253a << e}
    	@int_triple.each_cons(2){|e| a << e}
    	assert_equal cs253a,a
    	cs253b = []
    	b = []
        @str_triple.cs253each_cons(2){|e| cs253b << e}
        @str_triple.each_cons(2){|e| b << e}
        assert_equal cs253b,b
        cs253c = []
        c = []
        @float_triple.cs253each_cons(2){|e| cs253c << e} #mode?
        @float_triple.each_cons(2){|e| c << e}
        assert_equal cs253c,c
    end

    def test_each_entry
        assert_equal Foo.new.cs253each_entry{ |o| o }, Foo.new.each_entry{ |o| o}.to_a
        assert_equal @int_triple.cs253each_entry {|o| o}, @int_triple.each_entry {|o| o}.to_a
        cs253r = []
        r = []
        @str_triple.cs253each_entry {|o| cs253r << o}
        @str_triple.each_entry {|o| r << o}
        assert_equal cs253r, r
        
    end

    def test_each_slice 
    	cs253a = []
        a = [] 
    	@int_triple.cs253each_slice(2){|e| cs253a << e}
    	@int_triple.each_slice(2){|e| a << e}
    	assert_equal cs253a,a
    	cs253b = []
    	b = []
        @str_triple.cs253each_slice(2){|e| cs253b << e}
        @str_triple.each_slice(2){|e| b << e}
        assert_equal cs253b,b
        cs253c = []
        c = []
        @float_triple.cs253each_slice(2){|e| cs253c << e} #mode?
        @float_triple.each_slice(2){|e| c << e}
        assert_equal cs253c,c
    end

    def test_each_with_index
    	cs253r = []
    	r = []
    	@int_triple.cs253each_with_index{|i,e| cs253r <<[i.to_s,e]}
    	@int_triple.each_with_index{|i,e| r <<[i.to_s,e]}
    	@str_triple.cs253each_with_index{|i,e| cs253r <<[i.length,e]}
    	@str_triple.each_with_index{|i,e| r <<[i.length,e]}
    	@float_triple.cs253each_with_index{|i,e| cs253r<<[i*100,e]}
    	@float_triple.each_with_index{|i,e| r << [i*100,e]}
    	assert_equal cs253r,r
    end

    def test_each_with_object
    	assert_equal @int_triple.cs253each_with_object([]) { |i, a| a << i*2 }, @int_triple.each_with_object([]) { |i, a| a << i*2 }
    	assert_equal @str_triple.cs253each_with_object([]) { |i, a| a << i.length }, @str_triple.each_with_object([]) { |i, a| a << i.length }
        assert_equal @float_triple.cs253each_with_object([]) { |i, a| a << i*100%1}, @float_triple.each_with_object([]) { |i, a| a << i*100%1}
    end

    def test_entries
    	assert_equal @int_triple.cs253entries{|i| i.to_s}.to_a,@int_triple.entries{|i| i.to_s}.to_a
        assert_equal @str_triple.cs253entries{|i| i.length},@str_triple.entries{|i| i.length}
        assert_equal @float_triple.cs253entries{|i| i*100},@float_triple.entries{|i| i*100}
    end

    def test_find
    	assert_equal @int_triple.cs253find{|i| i%2 != 0}, @int_triple.find{|i| i%2 != 0}
        assert_equal @str_triple.cs253find{|i| i.length>3},@str_triple.find{|i| i.length>3}
        assert_equal @float_triple.cs253find{|i| i.class == Float},@float_triple.find{|i| i.class == Float}
    end

    def test_find_all
    	assert_equal @int_triple.cs253find_all{|i| i%2 == 0 and i >10}, @int_triple.find_all{|i| i%2 == 0 and i>10}
        assert_equal @str_triple.cs253find_all{|i| i.length>5},@str_triple.find_all{|i| i.length>5}
        assert_equal @float_triple.cs253find_all{|i| i.class == Float},@float_triple.find_all{|i| i.class == Float}
    end

    def test_find_index
    	assert_equal [2,3,6,12].cs253find_index{|i| i%2 == 0}, [2,3,6,12].find_index{|i| i%2 == 0}
        assert_equal ["wert","asdfg","zxcvbn"].cs253find_index{|i| i.length>5},["wert","asdfg","zxcvbn"].find_index{|i| i.length>5}
        assert_equal @float_triple.cs253find_index{|i| i.class == Float},@float_triple.find_index{|i| i.class == Float}
    end

    def test_first
    	n = rand(10)
    	assert_equal @int_triple.cs253first(n), @int_triple.first(n)
        assert_equal @str_triple.cs253first(n),@str_triple.first(n)
        assert_equal @float_triple.cs253first(n),@float_triple.first(n)
    end

    def test_flat_map
    	assert_equal @int_triple.cs253flat_map{|i| i + 100}, @int_triple.flat_map{|i| i+100}.to_a
        assert_equal @str_triple.cs253flat_map{|i| i.length>5},@str_triple.flat_map{|i| i.length>5}.to_a
        assert_equal @float_triple.cs253flat_map{|i| i.class == Float},@float_triple.flat_map{|i| i.class == Float}.to_a
        assert_equal [[1, 2], [3, 4]].cs253flat_map{ |e| e + [100] }, [[1, 2], [3, 4]].flat_map{ |e| e + [100] }   
    end

    def test_grep
    	c = IO.constants
    	assert_equal c.cs253grep(/SEEK/),c.grep(/SEEK/)
    	assert_equal @int_triple.cs253grep(1..100),@int_triple.grep(1..100)
    	assert_equal c.cs253grep(/SEEK/) {|e| e.length},c.grep(/SEEK/) {|e| e.length}
    end

    def test_grep_v
    	c = IO.constants
    	assert_equal c.cs253grep_v(/SEEK/),c.grep_v(/SEEK/)
    	assert_equal @int_triple.cs253grep_v(1..100),@int_triple.grep_v(1..100)
    	assert_equal c.cs253grep_v(/SEEK/) {|e| e.length},c.grep_v(/SEEK/) {|e| e.length}
    end

    def test_group_by
    	assert_equal @int_triple.cs253group_by{|i| i%2},@int_triple.group_by{|i| i%2}
        assert_equal @str_triple.cs253group_by{|i| i.length},@str_triple.group_by{|i| i.length}
        assert_equal @float_triple.cs253group_by{|i| i-i*100%1},@float_triple.group_by{|i| i-i*100%1}
    end

    def test_include
    	assert_equal [2,3,6,12].cs253include?(6), [2,3,6,12].include?(6)
        assert_equal ["wert","asdfg","zxcvbn"].cs253include?("wert"),["wert","asdfg","zxcvbn"].include?("wert")
        assert_equal @float_triple.cs253include?(0.0),@float_triple.include?(0.0)
    end

    def test_inject
    	assert_equal @int_triple.cs253inject(1) {|i, e| i*e}, @int_triple.inject(1) {|i,e| i*e}
		assert_equal @str_triple.cs253inject('') {|i, e| i+e}, @str_triple.inject('') {|i,e| i+e}
		assert_equal @float_triple.cs253inject(0) {|i,e| i<=>e}, @float_triple.inject(0) {|i,e| i<=>e}
	end

	def test_map
		assert_equal @int_triple.cs253map{|i| i.to_s}.to_a,@int_triple.map{|i| i.to_s}.to_a
        assert_equal @str_triple.cs253map{|i| i.length},@str_triple.map{|i| i.length}
        assert_equal @float_triple.cs253map{|i| i*100},@float_triple.map{|i| i*100}
    end

    def test_max
    	s_array = Array.new(['Algorithm', 'horse', 'zodiac', 'bad'])

		assert_equal @int_triple.cs253max {|i,e| i<=>e}, @int_triple.max {|i,e| i<=>e}
		assert_equal s_array.cs253max {|i,e| i.length<=>e.length}, s_array.max { |a, b| a.length<=>b.length }
		assert_equal @float_triple.cs253max {|i,e| (i*100).round<=>(e*100).round}, @float_triple.max { |a, b| (a*100).round<=>(b*100).round }
	end

	def test_max_by
		s_array = Array.new(['Algorithm', 'horse', 'zodiac', 'bad'])

		assert_equal @int_triple.cs253max_by {|i| i}, @int_triple.max_by {|i| i}
		assert_equal s_array.cs253max_by {|i| i.length}, s_array.max_by { |a| a.length}
		assert_equal @float_triple.cs253max_by {|i| (i*100).round}, @float_triple.max_by { |a| (a*100).round}
	end

	def test_member
		assert_equal [2,3,6,12].cs253member?(6), [2,3,6,12].member?(6)
        assert_equal ["wert","asdfg","zxcvbn"].cs253member?("wert"),["wert","asdfg","zxcvbn"].member?("wert")
        assert_equal @float_triple.cs253member?(0.0),@float_triple.member?(0.0)
    end

    def test_min
    	s_array = Array.new(['Algorithm', 'horse', 'zodiac', 'bad'])

		assert_equal @int_triple.cs253max {|i,e| i<=>e}, @int_triple.max {|i,e| i<=>e}
		assert_equal s_array.cs253max {|i,e| i.length<=>e.length}, s_array.max { |a, b| a.length<=>b.length }
		assert_equal @float_triple.cs253max {|i,e| (i*100).round<=>(e*100).round}, @float_triple.max { |a, b| a*100.round<=>b*100.round }
    end

    def test_min_by
		s_array = Array.new(['Algorithm', 'horse', 'zodiac', 'bad'])

		assert_equal @int_triple.cs253min_by {|i| i}, @int_triple.min_by {|i| i}
		assert_equal s_array.cs253min_by {|i| i.length}, s_array.min_by { |a| a.length}
		assert_equal @float_triple.cs253min_by {|i| (i*100).round}, @float_triple.min_by { |a| (a*100).round}
	end

	def test_minmax
		s_array = Array.new(['Algorithm', 'horse', 'zodiac', 'bad'])

		assert_equal @int_triple.cs253minmax {|i,e| i<=>e}, @int_triple.minmax {|i,e| i<=>e}
		assert_equal s_array.cs253minmax {|i,e| i.length<=>e.length}, s_array.minmax { |a, b| a.length<=>b.length }
		assert_equal @float_triple.cs253minmax {|i,e| (i*100).round<=>(e*100).round}, @float_triple.minmax { |a, b| a*100.round<=>b*100.round }
	end

	def test_minmax_by
		s_array = Array.new(['Algorithm', 'horse', 'zodiac', 'bad'])

		assert_equal @int_triple.cs253minmax_by {|i| i}, @int_triple.minmax_by {|i| i}
		assert_equal s_array.cs253minmax_by {|i| i.length}, s_array.minmax_by { |a| a.length}
		assert_equal @float_triple.cs253minmax_by {|i| (i*100).round}, @float_triple.minmax_by { |a| (a*100).round}
	end

	def test_none
		assert_equal @int_triple.cs253none?{|i| i%2 == 0}, @int_triple.none?{|i| i%2 == 0}
        assert_equal @str_triple.cs253none?{|i| i.length>5},@str_triple.none?{|i| i.length>5}
        assert_equal @float_triple.cs253none?{|i| i.class == Float},@float_triple.none?{|i| i.class == Float}
        assert_equal @bool_triple.cs253none?, @bool_triple.none?
        assert_equal @empty_triple.cs253none?, @empty_triple.none? 
    end

    def test_one
    	assert_equal @int_triple.cs253one?{|i| i%2 == 0}, @int_triple.one?{|i| i%2 == 0}
        assert_equal @str_triple.cs253one?{|i| i.length>5},@str_triple.one?{|i| i.length>5}
        assert_equal @float_triple.cs253one?{|i| i.class == Float},@float_triple.one?{|i| i.class == Float}
        assert_equal @bool_triple.cs253one?, @bool_triple.one?
        assert_equal @empty_triple.cs253one?, @empty_triple.one? 
    end

    def test_partition
    	assert_equal @int_triple.cs253partition{|i| i%2 == 0}, @int_triple.partition{|i| i%2 == 0}
        assert_equal @str_triple.cs253partition{|i| i.length>5},@str_triple.partition{|i| i.length>5}
        assert_equal @float_triple.cs253partition{|i| i.class == Float},@float_triple.partition{|i| i.class == Float}
    end

    def test_reduce
    	assert_equal @int_triple.cs253reduce(1) {|i, e| i*e}, @int_triple.reduce(1) {|i,e| i*e}
		assert_equal @str_triple.cs253reduce('') {|i, e| i+e}, @str_triple.reduce('') {|i,e| i+e}
		assert_equal @float_triple.cs253reduce(0) {|i,e| i<=>e}, @float_triple.reduce(0) {|i,e| i<=>e}
	end

	def test_reject
		assert_equal @int_triple.cs253reject {|i| i.even? }, @int_triple.reject {|i| i.even?}
		assert_equal @str_triple.cs253reject {|i| i.length>5}, @str_triple.reject {|i| i.length>5}
		assert_equal @float_triple.cs253reject {|i| i*i}, @float_triple.reject {|i| i*i}
	end

	def test_reverse_each
		assert_equal @int_triple.cs253reverse_each{|i| i.to_s},@int_triple.reverse_each{|i| i.to_s}.to_a
        assert_equal @str_triple.cs253reverse_each{|i| i.length},@str_triple.reverse_each{|i| i.length}.to_a
        assert_equal @float_triple.cs253reverse_each{|i| i*100},@float_triple.reverse_each{|i| i*100}.to_a
    end

    def test_select
    	assert_equal @int_triple.cs253select {|i| i.even? }, @int_triple.select {|i| i.even?}
		assert_equal @str_triple.cs253select {|i| i.length>5}, @str_triple.select {|i| i.length>5}
		assert_equal @float_triple.cs253select {|i| (i*100).round>10}, @float_triple.select {|i| (i*100).round>10}
	end

	def test_slice_after
		assert_equal @int_triple.cs253slice_after {|i| i.even? }, @int_triple.slice_after {|i| i.even?}.to_a
		assert_equal @str_triple.cs253slice_after {|i| i.length>5}, @str_triple.slice_after {|i| i.length>5}.to_a
		assert_equal @float_triple.cs253slice_after {|i| (i*100).round>10}, @float_triple.slice_after {|i| (i*100).round>10}.to_a
	end

	def test_slice_before
        assert_equal @int_triple.cs253slice_before {|i| i.even? }, @int_triple.slice_before {|i| i.even?}.to_a
		assert_equal @str_triple.cs253slice_before {|i| i.length>5}, @str_triple.slice_before {|i| i.length>5}.to_a
		assert_equal @float_triple.cs253slice_before {|i| (i*100).round>10}, @float_triple.slice_before {|i| (i*100).round>10}.to_a
	end

	def test_slice_when
		assert_equal @int_triple.cs253slice_when {|i| i.even? }, @int_triple.slice_when {|i| i.even?}.to_a
		assert_equal @str_triple.cs253slice_when {|i| i.length>5}, @str_triple.slice_when {|i| i.length>5}.to_a
		assert_equal @float_triple.cs253slice_when {|i| (i*100).round>10}, @float_triple.slice_when {|i| (i*100).round>10}.to_a
	end

	def test_sort
		assert_equal @int_triple.cs253sort{|i,e| i.to_s<=>e.to_s},@int_triple.sort{|i,e| i.to_s<=>e.to_s}.to_a
        assert_equal @str_triple.cs253sort{|i,e| i.length<=>e.length},@str_triple.sort{|i,e| i.length<=>e.length}
        assert_equal @float_triple.cs253sort{|i,e| i*i<=>e*e},@float_triple.sort{|i,e| i*i<=>e*e}
    end

    def test_sort_by
    	assert_equal @int_triple.cs253sort_by{|i| i.to_s},@int_triple.sort_by{|i| i.to_s}.to_a
        assert_equal @str_triple.cs253sort_by{|i| i.length},@str_triple.sort_by{|i| i.length}
        assert_equal @float_triple.cs253sort_by{|i| i*i},@float_triple.sort_by{|i| i*i}
    end

    def test_sum
    	assert_equal @int_triple.cs253sum{|i| i},@int_triple.sum{|i| i}
        assert_equal @str_triple.cs253sum{|i| i.length},@str_triple.sum{|i| i.length}
        assert_equal @float_triple.cs253sum{|i| (i*100).round},@float_triple.sum{|i| (i*100).round}
    end

    def test_take
    	n = rand(10)
    	assert_equal @int_triple.cs253take(n), @int_triple.take(n)
        assert_equal @str_triple.cs253take(n),@str_triple.take(n)
        assert_equal @float_triple.cs253take(n),@float_triple.take(n)
    end

    def test_take_while
    	assert_equal @int_triple.cs253take_while{|i| i%2 == 0}, @int_triple.take_while{|i| i%2 == 0}
        assert_equal @str_triple.cs253take_while{|i| i.length>5},@str_triple.take_while{|i| i.length>5}
        assert_equal @float_triple.cs253take_while{|i| i.class == Float},@float_triple.take_while{|i| i.class == Float}
    end

    def test_to_a
    	assert_equal @int_triple.cs253to_a, @int_triple.to_a
    	assert_equal (1..9).cs253to_a, (1..9).to_a
    	assert_equal @str_triple.cs253to_a, @str_triple.to_a
    end

    def test_to_h
    	assert_equal Triple.new([0,1],[1,2],[2,3]).cs253to_h, Triple.new([0,1],[1,2],[2,3]).to_h
    	assert_equal Triple.new(['0','1'],['1','2'],['2','3']).cs253to_h, Triple.new(['0','1'],['1','2'],['2','3']).to_h
    	assert_equal Triple.new(['0',['1',3,4,'5']],['1',['2',3.45]],[2,['3','45',6]]).cs253to_h, Triple.new(['0',['1',3,4,'5']],['1',['2',3.45]],[2,['3','45',6]]).to_h
    end

    def test_uniq
    	assert_equal Triple.new(0,1,1).cs253uniq, Triple.new(0,1,1).uniq
    	assert_equal Triple.new('0','1','1').cs253uniq, Triple.new('0','1','1').uniq
    	assert_equal Triple.new([0,1],[0,1],['0','1']).cs253uniq, Triple.new([0,1],[0,1],['0','1']).uniq
    end

    def test_zip
    	assert_equal @int_triple.cs253zip(@str_triple),@int_triple.zip(@str_triple)
    	assert_equal @int_triple.cs253zip([1,2],[1]),@int_triple.zip([1,2],[1])
 
    	c = []
    	c253 = []
    	@int_triple.cs253zip(@float_triple) {|x,y| c253 << ((x+y)*100).round}
    	@int_triple.zip(@float_triple) {|x,y| c << ((x+y)*100).round}
    	assert_equal c253, c

    end

    def test_length
    	assert_equal @int_triple.cs253length, 3
        assert_equal @str_triple.cs253length, 3
        assert_equal @float_triple.cs253length, 3
    end

end






require 'minitest/autorun'
require './cs253Array.rb'

class CS253EnumTests < Minitest::Test
    def test_collect
        int_triple = CS253Array.new([1, 2, 3])
        str_triple = CS253Array.new(["string", "anotherString", "lastString"])

        assert_equal int_triple.cs253collect{|i| i.to_s},["1","2","3"]
		assert_equal int_triple.cs253collect{|i| 3322},[3322,3322,3322]
        assert_equal str_triple.cs253collect{|i| i.length}.to_a,[6,13,10]
    end
    # more tests!
	
	def test_all?
		int_triple = CS253Array.new([1,2,3])
		str_triple = CS253Array.new(["string", "anotherString", "lastString"])
		assert_equal int_triple.cs253all?{|i| i > 2}, false
		assert_equal int_triple.cs253all?{|i| i > 0}, true
		assert_equal str_triple.cs253all?{|i| i != nil}, true
	end
	
	def test_any?
		int_triple = CS253Array.new([1,2,3])
		str_triple = CS253Array.new(["string", "anotherString", "lastString"])
		assert_equal int_triple.cs253any?{|i| i > 4}, false
		assert_equal int_triple.cs253any?{|i| i > 2}, true
		assert_equal str_triple.cs253any?{|i| i != nil}, true
	end
	
	def test_chunk
		int_triple = CS253Array.new([1,2,3])
		str_triple = CS253Array.new(["string", "anotherString", "lastString"])
		assert_equal int_triple.cs253chunk{|i| i.even?}, [[false, [1]], [true, [2]], [false, [3]]]
		assert_equal int_triple.cs253chunk{|i| i > 4},  [[false, [1, 2, 3]]]
		assert_equal str_triple.cs253chunk{|i| i != "string"}, [[false, ["string"]], [true, ["anotherString", "lastString"]]]
	end
	
	def test_chunk_while
		int_triple = CS253Array.new([1,2,3])
		str_triple = CS253Array.new(["string", "anotherString", "lastString"])
		assert_equal int_triple.cs253chunk_while{|i,j| i.even?}, [[1],[2, 3]]
		assert_equal int_triple.cs253chunk_while{|i,j| i + j < 4},  [[1, 2], [3]]
		assert_equal str_triple.cs253chunk_while{|i,j| j > i}, [["string"], ["anotherString", "lastString"]]
	end
	
	def test_collect_concat
        int_triple = CS253Array.new([1, 2, 3])
        str_triple = CS253Array.new(["string", "anotherString", "lastString"])

        assert_equal int_triple.cs253collect_concat{|i| [i, i+1]},[1, 2, 2, 3, 3, 4]
		assert_equal int_triple.cs253collect_concat{|i| 3322},[3322,3322,3322]
        assert_equal str_triple.cs253collect_concat{|i| i + "Think"},["stringThink", "anotherStringThink", "lastStringThink"]
    end
	
	def test_count
        int_triple = CS253Array.new([1, 2, 3])
		nil_triple = CS253Array.new([nil,nil,nil])
        str_triple = CS253Array.new(["string", "anotherString", "lastString"])

        assert_equal int_triple.cs253count{|i| i != 0},3
		assert_equal nil_triple.cs253count,3
        assert_equal str_triple.cs253count("string"),1
    end
	
	def test_cycle
        int_triple = CS253Array.new([1, 2, 3])
		nil_triple = CS253Array.new([nil,nil,nil])
        str_triple = CS253Array.new(["string", "anotherString", "lastString"])

        assert_nil int_triple.cs253cycle(2){|x| p x}
		assert_nil nil_triple.cs253cycle(2){|x| p x}
		assert_nil str_triple.cs253cycle(2){|x| p x}
    end
	
	def test_detect
        int_triple = CS253Array.new([1, 2, 8])
        str_triple = CS253Array.new(["string", "anotherString", "lastString"])

        assert_equal int_triple.cs253detect{|i| i % 2 == 0 and i % 4 == 0}, 8
		assert_equal int_triple.cs253detect{|i| i % 1 == 0 and i % 2 == 0}, 2
		assert_equal str_triple.cs253detect{|x| x == "string"}, "string"
    end
	
	def test_drop
        int_triple = CS253Array.new([1, 2, 8])
        str_triple = CS253Array.new(["string", "anotherString", "lastString"])

        assert_equal int_triple.cs253drop(1), [2,8]
		assert_equal int_triple.cs253drop(0), [1,2,8]
		assert_equal str_triple.cs253drop(1), ["anotherString", "lastString"]
    end
	
	def test_drop_while
        int_triple = CS253Array.new([1, 2, 8])
        str_triple = CS253Array.new(["string", "anotherString", "lastString"])

        assert_equal int_triple.cs253drop_while{|i| i < 3}, [8]
		assert_equal int_triple.cs253drop_while{|i| i < 1}, [1,2,8]
		assert_equal str_triple.cs253drop_while{|x| x <= "string"}, []
    end
	
	def test_each_cons
        int_triple = CS253Array.new([1, 2, 3])
        str_triple = CS253Array.new(["string", "anotherString", "lastString"])

        assert_nil int_triple.cs253each_cons(2){|x| p x}
		assert_nil int_triple.cs253each_cons(1){|x| p x}
		assert_nil str_triple.cs253each_cons(2){|x| p x}
    end
	
	def test_each_entry
        int_triple = CS253Array.new([1, 2, 8])
        str_triple = CS253Array.new(["string", "anotherString", "lastString"])

        assert_equal int_triple.cs253each_entry{|i| p i}, [1,2,8]
		assert_equal int_triple.cs253each_entry{|i| i}, [1,2,8]
		assert_equal str_triple.cs253each_entry{|x| p x}, ["string", "anotherString", "lastString"]
    end
	
	def test_each_slice
        int_triple = CS253Array.new([1, 2, 3])
        str_triple = CS253Array.new(["string", "anotherString", "lastString"])

        assert_nil int_triple.cs253each_slice(2){|x| p x+x}
		assert_nil int_triple.cs253each_slice(1){|x| p x+x}
		assert_nil str_triple.cs253each_slice(2){|x| p x}
    end
	
	def test_each_with_index
        int_triple = CS253Array.new([1, 2, 8])
        str_triple = CS253Array.new(["string", "anotherString", "lastString"])

        assert_equal int_triple.cs253each_with_index{|x,i| p x+i}, [1,2,8]
		assert_equal int_triple.cs253each_with_index{|x,i| i}, [1,2,8]
		assert_equal str_triple.cs253each_with_index{|x,i| p x}, ["string", "anotherString", "lastString"]
    end
	
	def test_each_with_object
        int_triple = CS253Array.new([1, 2, 3])
        str_triple = CS253Array.new(["string", "anotherString", "lastString"])

        assert_equal int_triple.cs253each_with_object([231]){|x,a| a << x + a[0]}, [231, 232, 233, 234]
		assert_equal int_triple.cs253each_with_object([231]){|x,a| a << a[0]}, [231,231,231,231]
		assert_equal str_triple.cs253each_with_object(["omg"]){|x,a| a << x}, ["omg","string", "anotherString", "lastString"]
    end
	
	def test_entries
        int_triple = CS253Array.new([1, 2, 8])
		nil_triple = CS253Array.new([nil, nil, nil])
        str_triple = CS253Array.new(["string", "anotherString", "lastString"])

        assert_equal int_triple.cs253entries, [1,2,8]
		assert_equal nil_triple.cs253entries, [nil,nil,nil]
		assert_equal str_triple.cs253entries, ["string", "anotherString", "lastString"]
    end
	
	def test_find
		# find is the same as detect
        int_triple = CS253Array.new([1, 2, 8])
        str_triple = CS253Array.new(["string", "anotherString", "lastString"])

        assert_equal int_triple.cs253find{|i| i % 2 == 0 and i % 4 == 0}, 8
		assert_equal int_triple.cs253find{|i| i % 1 == 0 and i % 2 == 0}, 2
		assert_equal str_triple.cs253find{|x| x == "string"}, "string"
    end
	
	def test_select
		int_triple = CS253Array.new([1, 2, 8])
		nil_triple = CS253Array.new([nil, nil, nil])
        str_triple = CS253Array.new(["string", "anotherString", "lastString"])
		assert_equal int_triple.cs253select{|x| x.even?}, [2,8]
		assert_equal nil_triple.cs253select{|x| x}, []
		assert_equal str_triple.cs253select{|x| x.include? "h"}, ["anotherString"] 
	end
	
	def test_find_all
		# find_all is the same as select
		int_triple = CS253Array.new([1, 2, 8])
		nil_triple = CS253Array.new([nil, nil, nil])
        str_triple = CS253Array.new(["string", "anotherString", "lastString"])
		assert_equal int_triple.cs253find_all{|x| x.even?}, [2,8]
		assert_equal nil_triple.cs253find_all{|x| x}, []
		assert_equal str_triple.cs253find_all{|x| x.include? "h"}, ["anotherString"] 
	end
	
	def test_find_index
        int_triple = CS253Array.new([1, 2, 8])
        str_triple = CS253Array.new(["string", "anotherString", "lastString"])

        assert_equal int_triple.cs253find_index{|i| i % 2 == 0 and i % 4 == 0}, 2
		assert_equal int_triple.cs253find_index{|i| i % 1 == 0 and i % 2 == 0}, 1
		assert_equal str_triple.cs253find_index{|x| x == "string"}, 0
    end
	
	def test_first
        int_triple = CS253Array.new([1, 2, 8])
        str_triple = CS253Array.new(["string", "anotherString", "lastString"])

        assert_equal int_triple.cs253first(1), [1]
		assert_equal int_triple.cs253first, 1
		assert_equal str_triple.cs253first(1), ["string"]
    end
	
	def test_flat_map
		# flat_map is the same as collect_concat
        int_triple = CS253Array.new([1, 2, 3])
        str_triple = CS253Array.new(["string", "anotherString", "lastString"])

        assert_equal int_triple.cs253flat_map{|i| [i, i+1]},[1, 2, 2, 3, 3, 4]
		assert_equal int_triple.cs253flat_map{|i| 3322},[3322,3322,3322]
        assert_equal str_triple.cs253flat_map{|i| i + "Think"},["stringThink", "anotherStringThink", "lastStringThink"]
    end
	
	def test_grep
        int_triple = CS253Array.new([1, 2, 3])
        str_triple = CS253Array.new(["string", "anotherString", "lastString"])

        assert_equal int_triple.cs253grep([2]),[]
		assert_equal int_triple.cs253grep(2),[2]
        assert_equal str_triple.cs253grep("string"),["string"]
    end
	
	def test_grep_v
        int_triple = CS253Array.new([1, 2, 3])
        str_triple = CS253Array.new(["string", "anotherString", "lastString"])

        assert_equal int_triple.cs253grep_v([2]),[1,2,3]
		assert_equal int_triple.cs253grep_v(2),[1,3]
        assert_equal str_triple.cs253grep_v("string"),["anotherString", "lastString"]
    end
	
	def test_group_by
		int_triple = CS253Array.new([1, 2, 8])
		nil_triple = CS253Array.new([nil, nil, nil])
        str_triple = CS253Array.new(["string", "anotherString", "lastString"])
		assert_equal int_triple.cs253group_by{|x| x.even?}, {false=>[1], true=>[2,8]}
		assert_equal nil_triple.cs253group_by{|x| x == nil}, {true=>[nil, nil, nil]}
		assert_equal str_triple.cs253group_by{|x| x.include? "h"}, {false=>["string", "lastString"], true=>["anotherString"]}
	end
	
	def test_include?
		int_triple = CS253Array.new([1, 2, 8])
        str_triple = CS253Array.new(["string", "anotherString", "lastString"])
		assert_equal int_triple.cs253include?(2), true
		assert_equal int_triple.cs253include?(4), false
		assert_equal str_triple.cs253include?("string"), true
	end
	
	def test_inject
		int_triple = CS253Array.new([1, 2, 3])
        str_triple = CS253Array.new(["string", "anotherString", "lastString"])

        assert_equal int_triple.cs253inject(2){|product, x| product * x},12
		assert_equal int_triple.cs253inject{|result, x| x},3
        assert_equal str_triple.cs253inject{|result, x| result + x},"stringanotherStringlastString"
	end
	
	def test_map
		# map is the same as collect
        int_triple = CS253Array.new([1, 2, 3])
        str_triple = CS253Array.new(["string", "anotherString", "lastString"])

        assert_equal int_triple.cs253map{|i| i.to_s},["1","2","3"]
		assert_equal int_triple.cs253map{|i| 3322},[3322,3322,3322]
        assert_equal str_triple.cs253map{|i| i.length}.to_a,[6,13,10]
    end
	
	def test_max
		int_triple = CS253Array.new([1, 2, 3])
        str_triple = CS253Array.new(["string", "anotherString", "lastString"])

		assert_equal int_triple.cs253max{|x,y| x <=> y},3
        assert_equal int_triple.cs253max(2){|x,y| x <=> y},[3,2]
		assert_equal str_triple.cs253max(2){|x,y| x.length <=> y.length},["anotherString", "lastString"]
	end
	
	def test_max_by
		int_triple = CS253Array.new([1, 2, 3])
        str_triple = CS253Array.new(["string", "anotherString", "lastString"])

		assert_equal int_triple.cs253max_by{|x| x},3
        assert_equal int_triple.cs253max_by(2){|x|x},[3,2]
		assert_equal str_triple.cs253max_by(2){|x| x.length},["anotherString", "lastString"]
	end
	
	def test_member?
		# member is the same as include
		int_triple = CS253Array.new([1, 2, 8])
        str_triple = CS253Array.new(["string", "anotherString", "lastString"])
		assert_equal int_triple.cs253member?(2), true
		assert_equal int_triple.cs253member?(4), false
		assert_equal str_triple.cs253member?("string"), true
	end
	
	def test_min
		int_triple = CS253Array.new([1, 2, 3])
        str_triple = CS253Array.new(["string", "anotherString", "lastString"])

		assert_equal int_triple.cs253min{|x,y| x <=> y},1
        assert_equal int_triple.cs253min(2){|x,y| x <=> y},[1,2]
		assert_equal str_triple.cs253min(2){|x,y| x.length <=> y.length},["string", "lastString"]
	end
	
	def test_min_by
		int_triple = CS253Array.new([1, 2, 3])
        str_triple = CS253Array.new(["string", "anotherString", "lastString"])

		assert_equal int_triple.cs253min_by{|x| x},1
        assert_equal int_triple.cs253min_by(2){|x|x},[1,2]
		assert_equal str_triple.cs253min_by(2){|x| x.length},["string", "lastString"]
	end
	
	def test_minmax
		int_triple = CS253Array.new([1, 2, 3])
		nil_triple = CS253Array.new([nil, nil, nil])
        str_triple = CS253Array.new(["string", "anotherString", "lastString"])

		assert_equal int_triple.cs253minmax{|x,y| x <=> y},[1,3]
        assert_equal nil_triple.cs253minmax{|x,y| x <=> y},[nil, nil]
		assert_equal str_triple.cs253minmax{|x,y| x.length <=> y.length},["string", "anotherString"]
	end
	
	def test_minmax_by
		int_triple = CS253Array.new([1, 2, 3])
		nil_triple = CS253Array.new([nil, nil, nil])
        str_triple = CS253Array.new(["string", "anotherString", "lastString"])

		assert_equal int_triple.cs253minmax_by{|x,y| x},[1,3]
        assert_equal nil_triple.cs253minmax_by{|x,y| x},[nil, nil]
		assert_equal str_triple.cs253minmax_by{|x,y| x.length},["string", "anotherString"]
	end
	
	def test_none?
		int_triple = CS253Array.new([1, 2, 3])
        str_triple = CS253Array.new(["string", "anotherString", "lastString"])

		assert_equal int_triple.cs253none?{|x| x > 4},true
        assert_equal int_triple.cs253none?{|x| x < 2},false
		assert_equal str_triple.cs253none?{|x| x == "string"},false
	end
	
	def test_one?
		int_triple = CS253Array.new([1, 1, 3])
        str_triple = CS253Array.new(["string", "anotherString", "lastString"])

		assert_equal int_triple.cs253one?{|x| x == 3},true
        assert_equal int_triple.cs253one?{|x| x < 2},false
		assert_equal str_triple.cs253one?{|x| x == "string"},true
	end
	
	def test_partition
		int_triple = CS253Array.new([1, 2, 3])
        str_triple = CS253Array.new(["string", "anotherString", "lastString"])

		assert_equal int_triple.cs253partition{|x| x.even?},[[2],[1,3]]
        assert_equal int_triple.cs253partition{|x| x > 4},[[], [1,2,3]]
		assert_equal str_triple.cs253partition{|x| x == "string"},[["string"], ["anotherString", "lastString"]]
	end
	
	def test_reduce
		# reduce is the same as inject
		int_triple = CS253Array.new([1, 2, 3])
        str_triple = CS253Array.new(["string", "anotherString", "lastString"])

        assert_equal int_triple.cs253reduce(2){|product, x| product * x},12
		assert_equal int_triple.cs253reduce{|result, x| x},3
        assert_equal str_triple.cs253reduce{|result, x| result + x},"stringanotherStringlastString"
	end
	
	def test_reject
		int_triple = CS253Array.new([1, 2, 3])
        str_triple = CS253Array.new(["string", "anotherString", "lastString"])

		assert_equal int_triple.cs253reject{|x| x.even?},[1,3]
        assert_equal int_triple.cs253reject{|x| x > 4},[1,2,3]
		assert_equal str_triple.cs253reject{|x| x == "string"},["anotherString", "lastString"]
	end
	
	def test_reverse_each
		int_triple = CS253Array.new([1, 2, 3])
		nil_triple = CS253Array.new([nil, nil, nil])
        str_triple = CS253Array.new(["string", "anotherString", "lastString"])

		assert_equal int_triple.cs253reverse_each{|x| p x},[1,2,3]
        assert_equal nil_triple.cs253reverse_each{|x| p x},[nil, nil, nil]
		assert_equal str_triple.cs253reverse_each{|x| p x},["string", "anotherString", "lastString"]
	end
	
	def test_slice_after
		int_triple = CS253Array.new([1, 2, 3])
        str_triple = CS253Array.new(["string", "anotherString", "lastString"])

		assert_equal int_triple.cs253slice_after{|x| x.even?},[[1,2], [3]]
        assert_equal int_triple.cs253slice_after(2),[[1,2], [3]]
		assert_equal str_triple.cs253slice_after{|x| x == "string"},[["string"],["anotherString", "lastString"]]
	end
	
	def test_slice_before
		int_triple = CS253Array.new([1, 2, 3])
        str_triple = CS253Array.new(["string", "anotherString", "lastString"])

		assert_equal int_triple.cs253slice_before{|x| x.even?},[[1], [2,3]]
        assert_equal int_triple.cs253slice_before(2),[[1], [2,3]]
		assert_equal str_triple.cs253slice_before{|x| x == "string"},[["string", "anotherString", "lastString"]]
	end
	
	def test_slice_when
		int_triple = CS253Array.new([1, 2, 3])
        str_triple = CS253Array.new(["string", "anotherString", "lastString"])

		assert_equal int_triple.cs253slice_when{|x,y| x > y},[[1,2,3]]
        assert_equal int_triple.cs253slice_when{|x,y| x < y},[[1],[2],[3]]
		assert_equal str_triple.cs253slice_when{|x,y| x.length > y.length},[["string", "anotherString"], ["lastString"]]
	end
	
	def test_sort
		int_triple = CS253Array.new([1, 3, 2])
        str_triple = CS253Array.new(["string", "anotherString", "lastString"])

		assert_equal int_triple.cs253sort{|x,y| x <=> y},[1,2,3]
        assert_equal int_triple.cs253sort{|x,y| y <=> x},[3,2,1]
		assert_equal str_triple.cs253sort{|x,y| x.length <=> y.length},["string", "lastString", "anotherString"]
	end
	
	def test_sort
		int_triple = CS253Array.new([1, 3, 2])
		nil_triple = CS253Array.new([nil, nil, nil])
        str_triple = CS253Array.new(["string", "anotherString", "lastString"])

		assert_equal int_triple.cs253sort_by{|x| x},[1,2,3]
        assert_equal nil_triple.cs253sort_by{|x| x},[nil, nil, nil]
		assert_equal str_triple.cs253sort_by{|x| x.length},["string", "lastString", "anotherString"]
	end
	
	def test_sum
		int_triple = CS253Array.new([1, 3, 2])

		assert_equal int_triple.cs253sum, 6
        assert_equal int_triple.cs253sum{|x| x * 2},12
		assert_equal int_triple.cs253sum(1){|x| x * 2},13
	end
	
	def test_take
		# take is essentially the same with first with argument
        int_triple = CS253Array.new([1, 2, 8])
        str_triple = CS253Array.new(["string", "anotherString", "lastString"])

        assert_equal int_triple.cs253take(3), [1,2,8]
		assert_equal int_triple.cs253take(8), [1,2,8]
		assert_equal str_triple.cs253take(1), ["string"]
    end
	
	def test_take_while
        int_triple = CS253Array.new([1, 2, 8])
        str_triple = CS253Array.new(["string", "anotherString", "lastString"])

        assert_equal int_triple.cs253take_while{|x| x < 3}, [1,2]
		assert_equal int_triple.cs253take_while{|x| x < 21}, [1,2,8]
		assert_equal str_triple.cs253take_while{|x| x != "anotherString"}, ["string"]
    end
	
	def test_to_a
        int_triple = CS253Array.new([1, 2, 8])
		nil_triple = CS253Array.new([nil, nil, nil])
        str_triple = CS253Array.new(["string", "anotherString", "lastString"])

        assert_equal int_triple.cs253to_a, [1,2,8]
		assert_equal nil_triple.cs253to_a, [nil, nil, nil]
		assert_equal str_triple.cs253to_a, ["string", "anotherString", "lastString"]
    end
	
	def test_uniq
        int_triple = CS253Array.new([1, 1, 8])
		nil_triple = CS253Array.new([nil, nil, nil])
        str_triple = CS253Array.new([["string", "group1"], ["lastString", "group1"], ["lastString", "group2"]])

        assert_equal int_triple.cs253uniq, [1,8]
		assert_equal nil_triple.cs253uniq, [nil]
		assert_equal str_triple.cs253uniq{|x| x[1]}, [["string", "group1"], ["lastString", "group2"]]
    end
	
	def test_zip
        int_triple = CS253Array.new([1, 1, 8])
		int_triple_a = CS253Array.new([8, 8, 8])
		int_triple_b = CS253Array.new([1, 6, 0])
		int_triple_veri = CS253Array.new([])
        str_triple = CS253Array.new(["string", "anotherString", "lastString"])
		str_triple_a = CS253Array.new(["word", "anotherWord", "lastWord"])
		str_triple_b = CS253Array.new(["character", "anotherCharacter", "lastCharacter"])

        assert_equal int_triple.cs253zip(int_triple_a, int_triple_b), [[1, 8, 1], [1, 8, 6], [8, 8, 0]]
		assert_equal int_triple.cs253zip(int_triple_a, int_triple_b){|x,y,z| int_triple_veri << (x + y + z)}, nil
		assert_equal int_triple_veri, [10, 15, 16]
		assert_equal str_triple.cs253zip(str_triple_a, str_triple_b), [["string", "word", "character"], ["anotherString", "anotherWord", "anotherCharacter"], ["lastString", "lastWord", "lastCharacter"]]
    end
	
	def test_length
		int_triple = CS253Array.new([1, 1, 8])
		nil_triple = CS253Array.new([nil, nil, nil])
        str_triple = CS253Array.new([["string", "group1"], ["lastString", "group1"], ["lastString", "group2"]])
		
		assert_equal int_triple.cs253length, 3
		assert_equal nil_triple.cs253length, 3
		assert_equal str_triple.cs253length, 3
	end
end




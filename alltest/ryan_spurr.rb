require 'minitest/autorun'
require './cs253_enum/cs253Enum.rb'

class Array
    include CS253Enumerable
end

class Range
    include CS253Enumerable
end

class CS253EnumTests < Minitest::Test
    def test_cs253collect
        int_triple = Array.new([1, 2, 3])
        str_triple = Array.new(["string", "anotherString", "lastString"])

        assert_equal int_triple.cs253collect{|i| i.to_s}.to_a,["1","2","3"]
        assert_equal str_triple.cs253collect{|i| i.length}.to_a,[6,13,10]
    end

    def test_cs253all?
        assert %w[ant bear cat].cs253all? { |word| word.length >= 3 } == true
        assert %w[ant bear cat].cs253all? { |word| word.length >= 4 } == false
        assert [nil, true, 99].cs253all?                              == false
        assert [].cs253all?
    end

    def test_cs253any?
        assert %w[ant bear cat].any? { |word| word.length >= 3 }
        assert %w[ant bear cat].any? { |word| word.length >= 4 }
        assert [nil, true, 99].any?
        assert ![].any?
    end



    # more tests!
end




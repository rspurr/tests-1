require 'minitest/autorun'
require_relative 'Array'
require_relative 'Range'
require_relative 'Triple'
require_relative 'cs253_array'

# Unit tests for CS253Enumerable
class CS253EnumTests < Minitest::Test
  def test_cs253all?
    empty_array = []
    str_array = %w[apple banana cherry]

    assert_equal true, (empty_array.cs253all? { |e| e == 5 })
    assert_equal true, (str_array.cs253all? { |e| e.length >= 5 })
    assert_equal false, (str_array.cs253all? { |e| e.length > 5 })
    assert_equal true, [1, true, ''].cs253all?
    assert_equal false, [nil, true].cs253all?
    assert_equal false, [false, true].cs253all?
  end

  def test_cs253any?
    empty_array = []
    str_array = %w[apple banana cherry]

    assert_equal false, (empty_array.cs253any? { |e| e == 5 })
    assert_equal false, (str_array.cs253any? { |e| e.length > 6 })
    assert_equal true, (str_array.cs253any? { |e| e.length > 5 })
    assert_equal true, [1, true, ''].cs253any?
    assert_equal true, [nil, true].cs253any?
    assert_equal true, [false, 1].cs253any?
  end

  def test_csc253chunk
    assert_equal [], [].cs253chunk(&:even?).to_a
    assert_equal [[true, [2]]], [2].cs253chunk(&:even?).to_a
    assert_equal [[false, [1]]], [1].cs253chunk(&:even?).to_a
    assert_equal [[false, [1, 3, 5]], [true, [2, 4]], [false, [7, 9]]],
                 [1, 3, 5, 2, 4, 7, 9].cs253chunk(&:even?).to_a
  end

  def test_cs253chunk_while
    assert_equal [], [].cs253chunk_while { |pre, cur| pre < cur }.to_a
    assert_equal [[1]], [1].cs253chunk_while { |pre, cur| pre < cur }.to_a
    assert_equal [[1, 3, 5], [2, 4, 7, 9]],
                 ([1, 3, 5, 2, 4, 7, 9].cs253chunk_while { |pre, cur| pre < cur }).to_a
    assert_equal [[4, 5, 6], [1, 2, 3], [7, 8, 9]],
                 ([4, 5, 6, 1, 2, 3, 7, 8, 9].cs253chunk_while { |pre, cur| pre + 1 == cur }).to_a
  end

  def test_cs253collect
    int_array = [7, 8, 9]
    empty_array = []
    str_array = %w[apple banana cherry]
    one_to_four = (1..4)

    assert_equal [5, 6, 6], str_array.cs253collect(&:length)
    assert_equal [], (empty_array.cs253collect { |e| e**2 })
    assert_equal %w[7 8 9], int_array.cs253collect(&:to_s)
    assert_equal %i[foo foo foo foo], (one_to_four.cs253collect { :foo })
  end

  def test_cs253map
    int_array = [7, 8, 9]
    empty_array = []
    str_array = %w[apple banana cherry]
    one_to_four = (1..4)

    assert_equal [5, 6, 6], str_array.cs253map(&:length)
    assert_equal [], (empty_array.cs253map { |e| e**2 })
    assert_equal %w[7 8 9], int_array.cs253map(&:to_s)
    assert_equal %i[foo foo foo foo], (one_to_four.cs253map { :foo })
  end

  def test_cs253collect_concat
    assert_equal ['apple', 5, 'banana', 6, 'cherry', 6],
                 (%w[apple banana cherry].cs253collect_concat { |e| [e, e.length] })
    assert_equal [], ([].cs253collect_concat { |e| e**2 })
    assert_equal [7, '7', 8, '8', 9, '9'], ([7, 8, 9].cs253collect_concat { |e| [e, e.to_s] })
    assert_equal [1, :foo, 2, :foo, 3, :foo, 4, :foo], ((1..4).cs253collect_concat { |e| [e, :foo] })
    assert_equal [1, 2, 100, 3, 4, 100], ([[1, 2], [3, 4]].cs253collect_concat { |e| e + [100] })
  end

  def test_cs253flat_map
    assert_equal ['apple', 5, 'banana', 6, 'cherry', 6],
                 (%w[apple banana cherry].cs253flat_map { |e| [e, e.length] })
    assert_equal [], ([].cs253flat_map { |e| e**2 })
    assert_equal [7, '7', 8, '8', 9, '9'], ([7, 8, 9].cs253flat_map { |e| [e, e.to_s] })
    assert_equal [1, :foo, 2, :foo, 3, :foo, 4, :foo], ((1..4).cs253flat_map { |e| [e, :foo] })
    assert_equal [1, 2, 100, 3, 4, 100], ([[1, 2], [3, 4]].cs253flat_map { |e| e + [100] })
  end

  def test_cs253count
    assert_equal 0, [].cs253count
    assert_equal 1, [:a].cs253count
    assert_equal 0, [:a].cs253count(nil)
    assert_equal 2, [1, 1, 2, 3, 3].cs253count(3)
    assert_equal 3, ([1, 1, 2, 3, 3].cs253count { |e| e > 1 })
    assert_equal 0, ([1, 1, 2, 3, 3].cs253count { |e| e > 3 })
  end

  def test_cs253cycle
    arr = []
    assert_equal nil, [1, 2, 3].cs253cycle(-1) { |e| arr << e }
    assert_equal [], arr
    [1, 2, 3].cs253cycle(0) { |e| arr << e }
    assert_equal [], arr
    [1, 2, 3].cs253cycle(1) { |e| arr << e }
    assert_equal [1, 2, 3], arr
    [1, 2, 3].cs253cycle(2) { |e| arr << e }
    assert_equal [1, 2, 3, 1, 2, 3, 1, 2, 3], arr
  end

  def test_cs253detect
    assert_equal 'none', ([1, 2, 3].cs253detect(-> { 'none' }) { |e| e == 4 })
    assert_equal nil, ([1, 2, 3].cs253detect { |e| e == 4 })
    assert_equal 2, ([1, 2, 3].cs253detect { |e| e == 2 })
  end

  def test_cs253drop
    assert_equal [1, 2, 3], [1, 2, 3].cs253drop(0)
    assert_equal [], [1, 2, 3].cs253drop(3)
    assert_equal [], [1, 2, 3].cs253drop(4)
    assert_equal [3], [1, 2, 3].cs253drop(2)
  end

  def test_cs253drop_while
    assert_equal [], [].cs253drop_while(&:odd?)
    assert_equal [], [1, 3].cs253drop_while(&:odd?)
    assert_equal [4], [1, 3, 4].cs253drop_while(&:odd?)
    assert_equal [2, 3, 4, 5], [1, 2, 3, 4, 5].cs253drop_while(&:odd?)
  end

  def test_cs253each_cons
    result = []
    assert_equal nil, (1..10).cs253each_cons(3) {}
    (1..10).cs253each_cons(3) { |e| result << e }
    assert_equal [[1, 2, 3], [2, 3, 4], [3, 4, 5],
                  [4, 5, 6], [5, 6, 7], [6, 7, 8],
                  [7, 8, 9], [8, 9, 10]], result
    result.clear
    (1..10).cs253each_cons(10) { |e| result << e }
    assert_equal [[1, 2, 3, 4, 5, 6, 7, 8, 9, 10]], result
    result.clear
    (1..10).cs253each_cons(11) { |e| result << e }
    assert_equal [], result
  end

  # class for test_cs253each_entry
  class Foo
    include Enumerable
    include CS253Enumerable
    def each
      yield 1
      yield 1, 2
      yield []
      yield
      yield nil
      yield 1..2
    end
  end
  def test_cs253each_entry
    ans = []
    assert_equal Foo, (Foo.new.cs253each_entry { |e| ans << e }).class
    assert_equal [1, [1, 2], [], nil, nil, 1..2], ans
  end

  def test_cs253each_slice
    result = []
    assert_equal nil, (1..10).cs253each_slice(3) { |e| result << e }
    assert_equal [[1, 2, 3], [4, 5, 6], [7, 8, 9], [10]], result
    result.clear
    (1..3).cs253each_slice(1) { |e| result << e }
    assert_equal [[1], [2], [3]], result
    result.clear
    (1..3).cs253each_slice(3) { |e| result << e }
    assert_equal [[1, 2, 3]], result
    result.clear
    (1..3).cs253each_slice(4) { |e| result << e }
    assert_equal [[1, 2, 3]], result
  end

  def test_cs253each_with_index
    assert_equal %w[], (%w[].cs253each_with_index { |e, idx| e << idx.to_s })
    assert_equal %w[a0], (%w[a].cs253each_with_index { |e, idx| e << idx.to_s })
    assert_equal %w[a0 b1 c2], (%w[a b c].cs253each_with_index { |e, idx| e << idx.to_s })
  end

  def test_cs253each_with_object
    assert_equal nil, [1, 2, 3].cs253each_with_object(nil) {}
    assert_equal [], [].cs253each_with_object([]) { |e, obj| obj << e**2 }
    assert_equal [1, 4, 9], [1, 2, 3].cs253each_with_object([]) { |e, obj| obj << e**2 }
  end

  def test_cs253entries
    assert_equal [], [].cs253entries
    assert_equal [1], [1].cs253entries
    assert_equal [1, 2, 3, 4, 5], (1..5).cs253entries
    assert_equal [1, 2, 3, 4, 5], CS253Array.new([1, 2, 3, 4, 5]).cs253entries
  end

  def test_cs253find
    assert_equal 'none', ([1, 2, 3].cs253find(-> { 'none' }) { |e| e == 4 })
    assert_equal nil, ([1, 2, 3].cs253find { |e| e == 4 })
    assert_equal 2, ([1, 2, 3].cs253find { |e| e == 2 })
  end

  def test_cs253find_all
    assert_equal [8, 9], ([7, 8, 9].cs253find_all { |e| e > 7 })
    assert_equal [7, 8, 9], ([7, 8, 9].cs253find_all { |e| e > 0 })
    assert_equal [], ([7, 8, 9].cs253find_all { |e| e > 9 })
    assert_equal [], ([].cs253find_all { |e| e })
    assert_equal ['apple'], (%w[apple banana cherry].cs253find_all { |e| e.length < 6 })
    assert_equal [8, 9], ((1..9).cs253find_all { |e| e > 7 })
  end

  def test_cs253find_index
    assert_equal nil, [1, 2].cs253find_index(nil)
    assert_equal nil, [1, 2].cs253find_index(3)
    assert_equal 0, [1, 2].cs253find_index(1)
    assert_equal 0, [1, 2].cs253find_index(&:odd?)
    assert_equal 1, [1, 2].cs253find_index(&:even?)
    assert_equal 1, CS253Array.new([1, 2]).cs253find_index(&:even?)
  end

  def test_cs253first
    assert_equal nil, [].cs253first
    assert_equal 1, (1..10).cs253first
    assert_equal [1], (1..10).cs253first(1)
    assert_equal [1, 2, 3], (1..10).cs253first(3)
    assert_equal [1, 2, 3], (1..3).cs253first(10)
  end

  def test_cs253grep
    assert_equal %w[], %w[apple banana cherry].cs253grep(/abc/)
    assert_equal %w[apple banana], %w[apple banana cherry].cs253grep(/a/)
    assert_equal [5, 6, 7, 8, 9], ((1..10).cs253grep 5..9)
    assert_equal [10, 12, 14, 16, 18], ((1..10).cs253grep(5..9) { |e| e * 2 })
    assert_equal [10, 12, 14, 16, 18], CS253Array.new((1..10).to_a).cs253grep(5..9) { |e| e * 2 }
  end

  def test_cs253grep_v
    assert_equal %w[apple banana cherry], %w[apple banana cherry].cs253grep_v(/abc/)
    assert_equal %w[cherry], %w[apple banana cherry].cs253grep_v(/a/)
    assert_equal [1, 2, 3, 4, 10], ((1..10).cs253grep_v 5..9)
    assert_equal [2, 4, 6, 8, 20], ((1..10).cs253grep_v(5..9) { |e| e * 2 })
  end

  def test_cs253group_by
    assert_equal ({ nil => [1, 2, 3, 4, 5, 6] }),
                 ((1..6).cs253group_by {})
    assert_equal ({ 1 => [1], 2 => [2], 3 => [3], 4 => [4], 5 => [5], 6 => [6] }),
                 ((1..6).cs253group_by { |i| i })
    assert_equal ({ 0 => [3, 6], 1 => [1, 4], 2 => [2, 5] }),
                 ((1..6).cs253group_by { |i| i % 3 })
  end

  def test_cs253include?
    assert_equal false, [].cs253include?(nil)
    assert_equal false, [].cs253include?([])
    assert_equal true, %w[hello].cs253include?('hello')
    assert_equal true, [1, 2, [3]].cs253include?([3])
  end

  def test_cs253member?
    assert_equal false, [].cs253member?(nil)
    assert_equal false, [].cs253member?([])
    assert_equal true, %w[hello].cs253member?('hello')
    assert_equal true, [1, 2, [3]].cs253member?([3])
  end

  def test_cs253inject
    int_array = [5, 6, 7, 8, 9, 10]
    empty_array = []
    single_element_array = [9]
    str_array = %w[apple banana cherry]
    five_to_ten = (5..10)

    # handle Array
    assert_equal 45, (int_array.cs253inject { |sum, n| sum + n })
    assert_equal 151_200, int_array.cs253inject(1) { |product, n| product * n }
    assert_equal 45, int_array.cs253inject(:+)
    assert_equal 151_200, int_array.cs253inject(1, :*)

    # handle empty array
    assert_equal nil, (empty_array.cs253inject { |sum, n| sum + n })
    assert_equal 1, empty_array.cs253inject(1) { |product, n| product * n }
    assert_equal nil, empty_array.cs253inject(:+)
    assert_equal 1, empty_array.cs253inject(1, :*)

    # handle single element array
    assert_equal 9, (single_element_array.cs253inject { |sum, n| sum + n })
    assert_equal 18, single_element_array.cs253inject(2) { |product, n| product * n }
    assert_equal 9, single_element_array.cs253inject(:+)
    assert_equal 18, single_element_array.cs253inject(2, :*)

    # handle string array
    assert_equal 'apple, banana, cherry',
                 (str_array.cs253inject { |acc, s| "#{acc}, #{s}" })
    assert_equal 'fruits, apple, banana, cherry',
                 (str_array.cs253inject('fruits') { |acc, s| "#{acc}, #{s}" })
    assert_equal 'applebananacherry', str_array.cs253inject(:+)
    assert_equal 'Iloveapplebananacherry', str_array.cs253inject('Ilove', :+)

    # handle Range
    assert_equal 45, (five_to_ten.cs253inject { |sum, n| sum + n })
    assert_equal 151_200, five_to_ten.cs253inject(1) { |product, n| product * n }
    assert_equal 45, five_to_ten.cs253inject(:+)
    assert_equal 151_200, five_to_ten.cs253inject(1, :*)
  end

  def test_cs253reduce
    int_array = [5, 6, 7, 8, 9, 10]
    empty_array = []
    single_element_array = [9]
    str_array = %w[apple banana cherry]
    five_to_ten = (5..10)

    # handle Array
    assert_equal 45, (int_array.cs253reduce { |sum, n| sum + n })
    assert_equal 151_200, int_array.cs253reduce(1) { |product, n| product * n }
    assert_equal 45, int_array.cs253reduce(:+)
    assert_equal 151_200, int_array.cs253reduce(1, :*)

    # handle empty array
    assert_equal nil, (empty_array.cs253reduce { |sum, n| sum + n })
    assert_equal 1, empty_array.cs253reduce(1) { |product, n| product * n }
    assert_equal nil, empty_array.cs253reduce(:+)
    assert_equal 1, empty_array.cs253reduce(1, :*)

    # handle single element array
    assert_equal 9, (single_element_array.cs253reduce { |sum, n| sum + n })
    assert_equal 18, single_element_array.cs253reduce(2) { |product, n| product * n }
    assert_equal 9, single_element_array.cs253reduce(:+)
    assert_equal 18, single_element_array.cs253reduce(2, :*)

    # handle string array
    assert_equal 'apple, banana, cherry',
                 (str_array.cs253reduce { |acc, s| "#{acc}, #{s}" })
    assert_equal 'fruits, apple, banana, cherry',
                 (str_array.cs253reduce('fruits') { |acc, s| "#{acc}, #{s}" })
    assert_equal 'applebananacherry', str_array.cs253reduce(:+)
    assert_equal 'Iloveapplebananacherry', str_array.cs253reduce('Ilove', :+)

    # handle Range
    assert_equal 45, (five_to_ten.cs253reduce { |sum, n| sum + n })
    assert_equal 151_200, five_to_ten.cs253reduce(1) { |product, n| product * n }
    assert_equal 45, five_to_ten.cs253reduce(:+)
    assert_equal 151_200, five_to_ten.cs253reduce(1, :*)
  end

  def test_cs253max
    int_array = [9, 8, 7]
    empty_array = []
    single_element_array = [9]
    str_array = %w[apple blueberry cherry]
    multi_max_array = %w[apple blueberry cherry pineapple]

    assert_equal 9, int_array.cs253max
    assert_equal nil, empty_array.cs253max
    assert_equal 9, single_element_array.cs253max
    assert_equal 'blueberry', (str_array.cs253max { |a, b| a.length <=> b.length })

    # array with multiple maximums (returns the first maximum)
    assert_equal 'blueberry', (multi_max_array.cs253max { |a, b| a.length <=> b.length })
    assert_equal %w[pineapple blueberry],
                 (multi_max_array.cs253max(2) { |a, b| a.length <=> b.length })
    assert_equal %w[pineapple blueberry cherry apple],
                 (multi_max_array.cs253max(4) { |a, b| a.length <=> b.length })
    assert_equal %w[pineapple blueberry cherry apple],
                 (multi_max_array.cs253max(5) { |a, b| a.length <=> b.length })
  end

  def test_cs253max_by
    float_array = [9.0, 8.0, 7.0]
    str_array = %w[apple blueberry cherry]
    multi_max_array = %w[apple blueberry cherry pineapple]

    assert_equal 7, (float_array.cs253max_by { |e| 1 / e })
    assert_equal 'blueberry', str_array.cs253max_by(&:length)

    # array with multiple maximums (returns the first maximum)
    assert_equal 'blueberry', multi_max_array.cs253max_by(&:length)
    assert_equal %w[pineapple blueberry], multi_max_array.cs253max_by(2, &:length)
    assert_equal %w[pineapple blueberry cherry apple], multi_max_array.cs253max_by(4, &:length)
    assert_equal %w[pineapple blueberry cherry apple], multi_max_array.cs253max_by(5, &:length)
  end

  def test_cs253min
    int_array = [9, 8, 7]
    empty_array = []
    single_element_array = [9]
    str_array = %w[apple blueberry cherry]
    multi_min_array = %w[pineapple apple bread cherry]

    assert_equal 7, int_array.cs253min
    assert_equal nil, empty_array.cs253min
    assert_equal 9, single_element_array.cs253min
    assert_equal 'apple', (str_array.cs253min { |a, b| a.length <=> b.length })

    # array with multiple maximums (returns the first maximum)
    assert_equal 'apple', (multi_min_array.cs253min { |a, b| a.length <=> b.length })
    assert_equal %w[apple bread],
                 (multi_min_array.cs253min(2) { |a, b| a.length <=> b.length })
    assert_equal %w[apple bread cherry pineapple],
                 (multi_min_array.cs253min(4) { |a, b| a.length <=> b.length })
    assert_equal %w[apple bread cherry pineapple],
                 (multi_min_array.cs253min(5) { |a, b| a.length <=> b.length })
  end

  def test_cs253min_by
    float_array = [9.0, 8.0, 7.0]
    str_array = %w[apple blueberry cherry]
    multi_min_array = %w[pineapple apple bread cherry]

    assert_equal 9, (float_array.cs253min_by { |e| 1 / e })
    assert_equal 'apple', str_array.cs253min_by(&:length)

    # array with multiple maximums (returns the first maximum)
    assert_equal 'apple', multi_min_array.cs253min_by(&:length)
    assert_equal %w[apple bread], multi_min_array.cs253min_by(2, &:length)
    assert_equal %w[apple bread cherry pineapple], multi_min_array.cs253min_by(4, &:length)
    assert_equal %w[apple bread cherry pineapple], multi_min_array.cs253min_by(5, &:length)
  end

  def test_cs253minmax
    assert_equal [1, 1], [1].cs253minmax
    assert_equal [-10, 9], (-10..9).cs253minmax
    assert_equal %w[a abc], (%w[a ab abc].cs253minmax { |a, b| a.length <=> b.length })
    assert_equal [-10, 9], CS253Array.new((-10..9).to_a).cs253minmax
  end

  def test_cs253minmax_by
    assert_equal [nil, nil], ([].cs253minmax_by {})
    assert_equal [1, 1], ([1].cs253minmax_by { |e| 1 / e })
    assert_equal [5, 2], ([2, 3, 4, 5].cs253minmax_by { |e| (1.0 / e) })
  end

  def test_cs253none?
    assert_equal true, [].cs253none?
    assert_equal true, [false].cs253none?
    assert_equal true, [nil].cs253none?
    assert_equal false, [true].cs253none?
    assert_equal false, [1].cs253none?
    assert_equal true, ([1, 2, 3].cs253none? { |e| e > 3 })
    assert_equal false, ([1, 2, 3].cs253none? { |e| e > 2 })
  end

  def test_cs253one?
    assert_equal false, [].cs253one?
    assert_equal false, [false].cs253one?
    assert_equal false, [nil].cs253one?
    assert_equal false, [true, 1].cs253one?
    assert_equal true, [nil, true].cs253one?
    assert_equal false, ([1, 2, 3].cs253one? { |e| e > 3 })
    assert_equal true, ([1, 2, 3].cs253one? { |e| e > 2 })
  end

  def test_cs253partition
    assert_equal [[], []], [].cs253partition(&:odd?)
    assert_equal [[1, 3, 5], []], [1, 3, 5].cs253partition(&:odd?)
    assert_equal [[], [1, 3, 5]], [1, 3, 5].cs253partition(&:even?)
    assert_equal [[1, 3, 5], [2, 4]], [1, 2, 3, 4, 5].cs253partition(&:odd?)
  end

  def test_cs253reject
    assert_equal [7], ([7, 8, 9].cs253reject { |e| e > 7 })
    assert_equal [], ([7, 8, 9].cs253reject { |e| e > 0 })
    assert_equal [7, 8, 9], ([7, 8, 9].cs253reject { |e| e > 9 })
    assert_equal [], ([].reject { |e| e })
    assert_equal %w[banana cherry], (%w[apple banana cherry].cs253reject { |e| e.length < 6 })
    assert_equal [1, 2, 3, 4, 5, 6, 7], ((1..9).cs253reject { |e| e > 7 })
  end

  def test_cs253reverse_each
    result = []
    assert_equal [1, 2, 3], ([1, 2, 3].cs253reverse_each { |e| result << e })
    assert_equal [3, 2, 1], result
    result.clear
    assert_equal [], ([].cs253reverse_each { |e| result << e })
    assert_equal [], result
    result.clear
    Triple.new(1, 2, 3).cs253reverse_each { |e| result << e }
    assert_equal [3, 2, 1], result
  end

  def test_cs253select
    assert_equal [8, 9], ([7, 8, 9].cs253select { |e| e > 7 })
    assert_equal [7, 8, 9], ([7, 8, 9].cs253select { |e| e > 0 })
    assert_equal [], ([7, 8, 9].cs253select { |e| e > 9 })
    assert_equal [], ([].cs253select { |e| e })
    assert_equal ['apple'], (%w[apple banana cherry].cs253select { |e| e.length < 6 })
    assert_equal [8, 9], ((1..9).cs253select { |e| e > 7 })
  end

  def test_cs253slice_after
    assert_equal [], ([].cs253slice_after { |e| e > 3 }).to_a
    assert_equal [[1]], ([1].cs253slice_after { |e| e > 3 }).to_a
    assert_equal [[1]], ([1].cs253slice_after { |e| e < 3 }).to_a
    assert_equal [[1, 2]], ([1, 2].cs253slice_after { |e| e == 2 }).to_a
    assert_equal [[1, 2, 3, 4], [5]], ([1, 2, 3, 4, 5].cs253slice_after { |e| e > 3 }).to_a
    assert_equal [%w[this is a sentence.], %w[this is another.]],
                 %w[this is a sentence. this is another.].cs253slice_after(/\./).to_a
  end

  def test_cs253slice_before
    assert_equal [], ([].cs253slice_before { |e| e > 3 }).to_a
    assert_equal [[1]], ([1].cs253slice_before { |e| e > 3 }).to_a
    assert_equal [[1]], ([1].cs253slice_before { |e| e < 3 }).to_a
    assert_equal [[1], [2]], ([1, 2].cs253slice_before { |e| e == 2 }).to_a
    assert_equal [[1, 2, 3], [4], [5]], ([1, 2, 3, 4, 5].cs253slice_before { |e| e > 3 }).to_a
    assert_equal [%W[foo\n bar\\\n], ["baz\n"], ["\n"],
                  ["qux\n"]], %W[foo\n bar\\\n baz\n \n qux\n].cs253slice_before(/(?<!\\)\n\z/).to_a
    assert_equal [%w[this is a], %w[sentence. this is], ['another.']],
                 %w[this is a sentence. this is another.].cs253slice_before(/\./).to_a
  end

  def test_cs253slice_when
    assert_equal [], ([].cs253slice_when { |a, b| a > b }).to_a
    assert_equal [[1, 2, 3, 4], [2, 3, 4], [3, 4]],
                 ([1, 2, 3, 4, 2, 3, 4, 3, 4].cs253slice_when { |a, b| a > b }).to_a
    assert_equal [[1]], ([1].cs253slice_when { |a, b| a > b }).to_a
    assert_equal [[2], [1]], ([2, 1].cs253slice_when { |a, b| a > b }).to_a
  end

  def test_cs253sort
    assert_equal [], [].cs253sort
    assert_equal [1, 2, 3, 4, 5], [5, 4, 3, 2, 1].cs253sort
    assert_equal [5, 4, 3, 2, 1], ([5, 4, 3, 2, 1].cs253sort { |a, b| 1 / a <=> 1 / b })
    assert_equal %w[a b c d e], %w[e d c b a].cs253sort
    assert_equal %w[abc bc c], %w[c bc abc].cs253sort
    assert_equal %w[abc bc c], (%w[c bc abc].cs253sort { |a, b| a <=> b })
    assert_equal %w[c bc abc], (%w[c bc abc].cs253sort { |a, b| a.length <=> b.length })
    assert_equal %w[c abc bcde], (%w[abc bcde c].cs253sort { |a, b| a.length <=> b.length })
    assert_equal %w[apple cherry blueberry],
                 (%w[apple blueberry cherry].cs253sort { |a, b| a.length <=> b.length })
  end

  def test_cs253sort_by
    assert_equal [5, 4, 3, 2, 1], ([5, 4, 3, 2, 1].cs253sort_by { |e| 1 / e })
    assert_equal [[0], [1, 2], [1], [2, 3]], ([[2, 3], [1, 2], [1], [0]].cs253sort_by { |e| e[0] })
    assert_equal %w[abc ab a], (%w[abc ab a].cs253sort_by { |e| -e.length })
    assert_equal %w[a ab abc], %w[abc ab a].cs253sort_by(&:length)
  end

  # TODO: :sum not supported in ruby 2.3.7? NoMethodError?
  def test_cs253sum
    assert_equal 6, [1, 2, 3].cs253sum
    assert_equal 55, (1..10).cs253sum
    assert_equal 110, ((1..10).cs253sum { |v| v * 2 })
    # assert_equal TypeError, Triple.new([1, 2, 3]).cs253sum.class
  end

  def test_cs253take
    assert_equal nil, [].cs253take
    assert_equal 1, (1..10).cs253take
    assert_equal [1], (1..10).cs253take(1)
    assert_equal [1, 2, 3], (1..10).cs253take(3)
    assert_equal [1, 2, 3], (1..3).cs253take(10)
  end

  def test_cs253take_while
    assert_equal [], [].cs253take_while(&:odd?)
    assert_equal [1, 3], [1, 3].cs253take_while(&:odd?)
    assert_equal [1, 3], [1, 3, 4].cs253take_while(&:odd?)
    assert_equal [1, 3], [1, 3, 4, 5].cs253take_while(&:odd?)
    assert_equal [1], [1, 2, 3, 4, 5].cs253take_while(&:odd?)
  end

  def test_cs253to_a
    assert_equal [], [].cs253to_a
    assert_equal [1], [1].cs253to_a
    assert_equal [1, 2, 3, 4, 5], (1..5).cs253to_a
    assert_equal [1, 2, 3], Triple.new(1, 2, 3).cs253to_a
  end

  # TODO: :to_h not supported in ruby 2.3.7? NoMethodError?
  def test_cs253to_h
    # assert_equal ({ 'a' => 0, 'b' => 1, 'c' => 2 }), %w[a b c].each_with_index.to_h
    assert_equal ({ 'a' => 0, 'b' => 1, 'c' => 2 }), %w[a b c].cs253to_h
    assert_equal ({ 1 => 0, 2 => 1, 3 => 2 }), Triple.new(1, 2, 3).cs253to_h
  end

  def test_cs253uniq
    assert_equal [1, 2, 3], [1, 2, 3, 3, 2].cs253uniq
    assert_equal [1, 2, 3], [1, 2, 3, 3, 2].uniq
    assert_equal [1, 2, 3], [1, 2, 3].uniq
    assert_equal [1, 2, 3], [1, 2, 3].cs253uniq
    assert_equal [[1, 2], [3, 2]], ([[1, 2], [1, 3], [3, 2], [1, 2]].cs253uniq { |e| e[0] })
    assert_equal [1, 2], Triple.new(1, 2, 1).cs253uniq
  end

  def test_cs253zip
    assert_equal [[1, 3], [2, 4]], [1, 2].cs253zip([3, 4])
    assert_equal [[1, 3, 5], [2, 4, 6]], [1, 2].cs253zip([3, 4], [5, 6])
    assert_equal [[1, 3, 5], [2, 4, nil]], [1, 2].cs253zip([3, 4], [5, nil])
    assert_equal [[1, 3, nil], [2, 4, nil]], [1, 2].cs253zip([3, 4], [nil, nil])
    c = []
    assert_equal nil, [1, 2, 3].cs253zip([4, 5, 6]) { |a, b| c << a + b }
    assert_equal [5, 7, 9], c
    c.clear
    assert_equal nil, [1, 2, 3].cs253zip([4, 5, 6], [7, 8, 9]) { |x, y, z| c << x + y + z }
    assert_equal [12, 15, 18], c
  end

  def test_cs253length
    assert_equal 0, [].cs253length
    assert_equal 1, [1].cs253length
    assert_equal 10, (1..10).cs253length
    assert_equal 3, %w[a b c].cs253length
    assert_equal 3, Triple.new(1, 2, 3).cs253length
  end
end
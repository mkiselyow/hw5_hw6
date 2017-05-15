require "spec_helper"
require './lib/array.rb'

RSpec.describe Array do
  describe '.top' do
    let!(:array_1) { [1, 2, 3, 4, 5, 6, 7, 7] }

    it 'adds a method that sorts array elements by /n
     frequency and and outputs the array.top(n) most frequent elements' do
      expect(array_1.top).to eq(7)
    end
  end

  describe '.top(three_elements)' do
    subject { arr = [8, 8, 8, 3, 3, 2]
      (arr << (1..10).to_a).flatten!}

    it 'should return top 3 elements of %w( 8 8 8 3 3 2) << 1..10 - 8,3,2' do
      expect(subject.top(3)).to eq([8,3,2])
    end
  end

  describe '.top(negative_argument)' do
    subject { arr = [8, 8, 8, 3, 3, 2]
      (arr << (1..10).to_a).flatten!}
    
    it 'should return 1 result if argument is negative_argument' do
      expect(subject.top(-10)).to eq(8)
    end
  end
end
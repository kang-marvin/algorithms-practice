<<-DOC

  https://leetcode.com/explore/challenge/card/30-day-leetcoding-challenge/528/week-1/3283/

  Given a non-empty array of integers, every element
  appears twice except for one. Find that single one.

  Note:

  Your algorithm should have a linear runtime complexity.
  Could you implement it without using extra memory?

  Input: [2,2,1]
  Output: 1

  Input: [4,1,2,1,2]
  Output: 4
DOC

class SingleNumber
  def initialize(data)
    @testData = data[:testData]
  end

  def call
    @testData.each do |arrayItems|
      puts "#{ single_number(arrayItems)} in #{arrayItems.inspect}"
    end
  end

  private

  def single_number(nums)
    sortedArray = nums.sort
    sortedArray.each_slice(2).with_index do |item, index|
      next if item.count == 2 && item.first === item.last
      return item.first
    end
  end
end

inputData = {
  testData: [
    [2,2,1],
    [2,1,2,3,1],
    [4,1,2,1,2],
  ]
}

SingleNumber.new(inputData).call
<<-DOC

https://leetcode.com/explore/challenge/card/30-day-leetcoding-challenge/528/week-1/3284/

Write an algorithm to determine if a number n is "happy".

A happy number is a number defined by the following process:
Starting with any positive integer, replace the number by
the sum of the squares of its digits, and repeat the process
until the number equals 1 (where it will stay),
or it loops endlessly in a cycle which does not include 1.
Those numbers for which this process ends in 1 are happy numbers.

Return True if n is a happy number, and False if not.

  Input: 19
  Output: true
  Explanation:
  12 + 92 = 82
  82 + 22 = 68
  62 + 82 = 100
  12 + 02 + 02 = 1

  Personal Note: The question says return boolean but in the website,
  when the provided value (n) causes a time limit exceeded error,
  a string is returned. I will write my code with minor changes to return value .
DOC

class Ishappy
  def initialize(data)
    @testData = data[:testData]
  end

  def call
    textConvertor = { 'true': 'IS', 'false': 'IS NOT' }

    @testData.each do |number|
      puts "#{number} #{textConvertor[is_happy(number).to_sym]} a `Happy number`"
    rescue SystemStackError
      puts 'Time Limit Exceeded'
    end
  end

  private

  def is_happy(number)
    newValue =
    number
      .to_s
      .split('')
      .map { |item| item.to_i ** 2 }
      .sum

    is_happy(newValue) unless [0,1].include?(newValue)
    return newValue === 0 ? 'false' : 'true'
  end
end

inputData = {
  testData: (0...100).to_a
}

Ishappy.new(inputData).call
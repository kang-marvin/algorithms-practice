<<-DOC
  Google Kick Start 2020: Round A (Allocation)
  https://codingcompetitions.withgoogle.com/kickstart/round/000000000019ffc7/00000000001d3f56

  In this challenge, I wrote the solution using both looping and recursion solutions and
  compare the time and memory consumption of both.
DOC

require 'benchmark'
require 'benchmark/memory'

class Allocation
  def initialize(data)
    @totalBudget = data[:totalBudget]
    @requiredHousesToBuy = data[:housesToBuy]
    @listOfCostOfHouses = sort_cost_of_houses_to_buy(data[:costOfHouses])
  end

  def call
    housesAffordableToBuy = 0
    @listOfCostOfHouses.each do |houseCost|
      break if (@totalBudget - houseCost) < 0
      @totalBudget -= houseCost
      housesAffordableToBuy += 1
    end
    return housesAffordableToBuy
  end

  def recursion_call
    return @listOfCostOfHouses.length if @listOfCostOfHouses.sum <= @totalBudget
    recursion(@listOfCostOfHouses, @totalBudget, 0)
  end

  private

  def recursion(costOfHouses, remainingBalance, housesBought)

    return housesBought unless costOfHouses.count > 0

    middlePoint = costOfHouses.count / 2
    lowerHalfOfHousesCost =
      costOfHouses[0...middlePoint]

    upperHalfOfHousesCost =
      costOfHouses[(middlePoint)...]

    costOfLowerPart = lowerHalfOfHousesCost.sum

    if costOfHouses.count === 1
      housesBought+=1 if remainingBalance >= costOfHouses[0]
      return housesBought
    elsif (costOfLowerPart > remainingBalance)
      recursion(
        lowerHalfOfHousesCost,
        remainingBalance,
        housesBought
      )
    elsif (remainingBalance - costOfLowerPart) > -1
      recursion(
        upperHalfOfHousesCost,
        (remainingBalance - costOfLowerPart),
        (lowerHalfOfHousesCost.count + housesBought)
      )
    else
      return housesBought
    end

  end

  def sort_cost_of_houses_to_buy(costOfHouses)
    costOfHouses.sort[0...@requiredHousesToBuy]
  rescue
    Array.new(@requiredHousesToBuy){ 0 }
  end

end

inputData = {
  testData: [
    { totalBudget: 100, housesToBuy: 3, costOfHouses: [] },
    { totalBudget: 100, housesToBuy: 3, costOfHouses: [20 ,90, 40, 90] },
    { totalBudget: 50,  housesToBuy: 4, costOfHouses: [30, 30, 10, 10] },
    { totalBudget: 300, housesToBuy: 3, costOfHouses: [999, 999, 999] },
    { totalBudget: 99, housesToBuy: 10, costOfHouses: [6,12,28,15,7,2,6,30,18] },
    { totalBudget: 100000, housesToBuy: 10000, costOfHouses: Array.new(1000) { [*1..250].sample } },
  ]
}

# Print the challenge results

puts "#{'-'*20} Expected Results #{'-'*20}"
inputData[:testData].each_with_index do |result, index|
  puts "(For Loop ) Case #{index+1}: #{Allocation.new(result).call}"
  puts "(Recursion) Case #{index+1}: #{Allocation.new(result).recursion_call}"
  puts ""
end

puts "#{'-'*20} Time spent #{'-'*20}"
Benchmark.bm do |bench|
  inputData[:testData].each_with_index do |result, index|
    bench.report {
      puts "(For Loop ) Case #{index+1}: #{Allocation.new(result).call}"
    }
    bench.report {
      puts "(Recursion) Case #{index+1}: #{Allocation.new(result).recursion_call}"
    }
    puts ""
  end
end

puts "#{'-'*20} Memory usage #{'-'*20}"
Benchmark.memory do |bench|
  inputData[:testData].each_with_index do |result, index|
    bench.report {
      puts "(For Loop ) Case #{index+1}: #{Allocation.new(result).call}"
    }
    bench.report {
      puts "(Recursion) Case #{index+1}: #{Allocation.new(result).recursion_call}"
    }
    puts ""
  end
end




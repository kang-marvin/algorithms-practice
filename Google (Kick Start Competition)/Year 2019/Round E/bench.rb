require 'benchmark'
require 'benchmark/memory'
require_relative 'StreetChecker'

inputData = {
  testData: [
    { startValue: 5, endValue: 30 },
  ]
}

puts "#{'-'*20} Time spent #{'-'*20}"
Benchmark.bm do |bench|
  inputData[:testData].each_with_index do |result, index|
    bench.report {
      puts "Case #{index+1}: #{ StreetChecker.new().call(result) }"
    }
    puts ""
  end
end

puts "#{'-'*20} Memory usage #{'-'*20}"
Benchmark.memory do |bench|
  inputData[:testData].each_with_index do |result, index|
    bench.report {
      puts "Case #{index+1}: #{ StreetChecker.new().call(result) }"
    }
    puts ""
  end
end




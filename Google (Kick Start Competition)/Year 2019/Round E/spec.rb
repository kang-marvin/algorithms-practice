require 'minitest/autorun'
require_relative 'StreetChecker'

describe "Street Checkers" do

  before do
    @stretChecker = StreetChecker.new
  end

  it 'returns 5 when start is 5 and end is 10' do
    rangeParams = {startValue: 5, endValue: 10 }
    expect(@stretChecker.call(rangeParams)).must_equal(5)
  end

  it 'returns 1 when both start and end is 102' do
    rangeParams = {startValue: 102, endValue: 102 }
    expect(@stretChecker.call(rangeParams)).must_equal(1)
  end

  it 'returns 0 when both start and end is 0' do
    rangeParams = {startValue: 0, endValue: 0 }
    expect(@stretChecker.call(rangeParams)).must_equal(1)
  end

  it 'returns 4 when start is 2 and end is 5' do
    rangeParams = {startValue: 2, endValue: 5 }
    expect(@stretChecker.call(rangeParams)).must_equal(4)
  end

  it 'returns 1 when start and end are not provided' do
    expect(@stretChecker.call({})).must_equal(0)
  end

  after do
    @stretChecker = nil
  end
end
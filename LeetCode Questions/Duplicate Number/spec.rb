require 'minitest/autorun'
require_relative 'DuplicateNumber'

describe "Duplicate Number In Array" do

  before do
    @duplicateNumber = DuplicateNumber.new
  end

  it 'returns 2 in [1,3,4,2,2]' do
    arr = [1,3,4,2,2]
    expect(@duplicateNumber.call(arr)).must_equal(2)
  end

  it 'returns 3 in [3,1,3,4,2]' do
    arr = [3,1,3,4,2]
    expect(@duplicateNumber.call(arr)).must_equal(3)
  end

  it 'returns 7 in [2,5,7,1,8,7,9,3,4,7,6]' do
    arr = [2,5,7,1,8,9,3,4,7,6]
    expect(@duplicateNumber.call(arr)).must_equal(7)
  end

  after do
    @duplicateNumber = nil
  end
end
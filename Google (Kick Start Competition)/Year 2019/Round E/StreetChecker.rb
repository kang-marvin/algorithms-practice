<<-DOC
  Google Kick Start 2019: Round E (Streer Checker)
  https://codingcompetitions.withgoogle.com/kickstart/round/0000000000050edb/00000000001707b9

DOC

class StreetChecker

  ABSOLUTE_DIFFERENCE = 2

  def initialize
    @jumpingTileRange     = [0,0]
    @tilesAliceWillPaint  = []
    @tilesBobWillPaint    = []

    @countOfGamesThatAreInteresting = 0
  end

  def call(startValue: 0, endValue: 0)
    @jumpingTileRange = (startValue..endValue).to_a

    @jumpingTileRange.each do |tileToJump|

      @tilesBobWillPaint =
        getEvenValuesInRangeDivisibleBy(tileToJump)

      @tilesAliceWillPaint =
          getOddValuesInRangeDivisibleBy(tileToJump)

      checkIfGameIsInteresting
      resetPaintedTiles
    end

    return @countOfGamesThatAreInteresting
  end

  private

  def getEvenValuesInRangeDivisibleBy(value=1)
    return [] if value.zero?
    (1..value)
      .to_a
      .select{ |c| (value % c).zero? && c.even? }
  end

  def getOddValuesInRangeDivisibleBy(value=1)
    return [] if value.zero?
    (1..value)
      .to_a
      .select{ |c| (value % c).zero? && c.odd? }
  end

  def checkIfGameIsInteresting
    alicePaintedTiles =
      @tilesAliceWillPaint.count

    bobPaintedTiles =
      @tilesBobWillPaint.count

    if (alicePaintedTiles - bobPaintedTiles).abs <= ABSOLUTE_DIFFERENCE
      @countOfGamesThatAreInteresting += 1
    end
  end

  def resetPaintedTiles
    @tilesAliceWillPaint  = []
    @tilesBobWillPaint    = []
  end
end

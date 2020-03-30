require 'active_support/inflector' # In order to use `Array.include?(value)`

class ChessBoardKnightTraversal
  def initialize(data)
    @possiblePaths      = 0
    @currentStep        = 1
    @boardDimensions    = data.slice(:row, :col)
    @validKnightMoves   = data[:validKnightMoves]
    @initialChessBoard  = chess_board(@boardDimensions)
  end

  def call
    moveKnightToNextStep(
      step: (@currentStep+1),
      currentKnightPosition: [0, 0],
      currentBoard: @initialChessBoard,
    )
    puts "#{@possiblePaths} #{"path".pluralize(@possiblePaths)} possible"
  end

  private

  def chess_board(data)
    "
      Create chessboard based on row and col values provided.
      Also set the first step to [0, 0]
    "
    multiDimensionalArray =
      Array.new(data[:row]) { Array.new(data[:col], 0) }
    multiDimensionalArray[0][0] = @currentStep
    return multiDimensionalArray
  rescue
    puts "Failed to create [#{data[:row]} by #{data[:col]}] chess board."
    puts "Fix this issue before continuing..."
    exit
  end

  def print_knight_moves(multiArray)
    multiArray.each do |rowArray|
      puts rowArray.map { |columnValue| columnValue.to_s.rjust(2, "0") }.join(" ")
    end
    puts "\n"
  end

  def moveKnightToNextStep(
      currentBoard: @initialChessBoard,
      currentKnightPosition: [0, 0],
      step: (@currentStep+1)
    )

    @validKnightMoves.each_with_index do |knightMove, index|
      if isValidKnightMove(currentBoard, knightMove, currentKnightPosition)

        nextRowPosition = [currentKnightPosition.first, knightMove.first].sum
        nextColPosition = [currentKnightPosition.last, knightMove.last].sum

        currentBoard[nextRowPosition][nextColPosition] = step

        moveKnightToNextStep(
          currentBoard: currentBoard,
          currentKnightPosition: [nextRowPosition, nextColPosition],
          step: (step+1),
        )

        "
          Reset the step of next position so that
          new Knight move permutations can be calculated
        "
        currentBoard[nextRowPosition][nextColPosition] = 0

        if (
            knightMove === @validKnightMoves.last &&
            step < (@boardDimensions[:row] * @boardDimensions[:col])
          )
            return false
        end
      end
    end

    "
      Print out the chessboard where all
      chessboard tiles have been visited only once
    "
    if step > (@boardDimensions[:row] * @boardDimensions[:col])
      print_knight_moves(currentBoard)
      @possiblePaths +=1
    end
    return true
  end

  def isValidKnightMove(currentBoard, knightMove, knightPosition)
    "
      A Knight move is valid if it fulfills the following :-
        a). The next move does not go outside the board.
        b). The new position hasn't been occured by the knight before.
    "

    rowPosition = [knightPosition.first, knightMove.first].sum
    colPosition = [knightPosition.last, knightMove.last].sum

    return false unless (0...@boardDimensions[:row]).to_a.include?(rowPosition)
    return false unless (0...@boardDimensions[:col]).to_a.include?(colPosition)

    return false if currentBoard[rowPosition][colPosition] > 0
    true
  end

end


validKnightMoves = [
  [-1,2], [-1,-2], [-2,-1], [-2,1],
  [1,2], [1,-2], [2,-1], [2,1]
]

testingData = [
  {row: 5, col: 4 },
  {row: 1, col: 1 },
  {row: 2, col: 2 },
  {row: 3, col: 4 },
  {row: 3, col: 3 },
]

"
  If you don't have activesupport installed.
  Run the code before executing the code

  `sudo gem install activesupport`
"

puts "\n"
testingData.each do |data|
  puts "Knight moves for chess board: [#{data[:row]} by #{data[:col]}]"
  puts "\n"

  data.merge!({ validKnightMoves: validKnightMoves})
  ChessBoardKnightTraversal.new(data).call

  puts "#{'-' * 40}"
  puts "\n"
end


class DuplicateNumber

  def initialize
    @arr = []
  end

  def call(arr = [])
    @arr = arr

    junction = move()
    meetingPoint = step(firstTurtle: 0, secondTurtle: junction)

    return meetingPoint
  end

  private

  def move(hare: 0, tortoise: 0)
    hare = doubleStep(hare)
    tortoise = singleStep(tortoise)

    if hare != tortoise
      return move(hare: hare, tortoise: tortoise)
    end

    hare
  end

  def step(firstTurtle: 0, secondTurtle: 0)
    firstTurtle = singleStep(firstTurtle)
    secondTurtle = singleStep(secondTurtle)

    if firstTurtle != secondTurtle
      return step(firstTurtle: firstTurtle, secondTurtle: secondTurtle)
    end

    return firstTurtle
  end

  def singleStep(pointer = 0)
    @arr[pointer]
  end

  def doubleStep(pointer = 0)
    @arr[@arr[pointer]]
  end

end
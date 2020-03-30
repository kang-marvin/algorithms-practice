require 'active_support/core_ext/array'
require 'benchmark'
require 'benchmark/memory'


<<-DOC
  Google Kick Start 2019: Round A (Training)
  https://codingcompetitions.withgoogle.com/kickstart/round/0000000000050e01/00000000000698d6

DOC

class TrainingCoach
  def initialize(data)
    @allCandidateSkillLevels =
      data[:candidatesSkillLevels].sort
    @requiredTeamCount = data[:teamMembers]
    @requiredTrainingHoursPerSkill = 1
    @caseNumber = data[:case_number]
  end

  def call
    allCandidateSkillLevelDifference =
      calculate_difference_in_candidate_skill_levels

    startingIndexPoint =
      calculate_selected_team_index_point(
        diffArray: allCandidateSkillLevelDifference,
        requiredTeamCount: (@requiredTeamCount - 2)
      )

    selectedTeam =
      calculate_selected_team(
        startingIndexPoint: startingIndexPoint
      )

    remainingSkillCount =
      required_skills_count_for_fair_team(selectedTeam)

    trainingHoursRequired =
      remainingSkillCount * @requiredTrainingHoursPerSkill

    trainingHoursRequired
  end

  private

  def required_skills_count_for_fair_team(selectedTeam)
    totalCollectiveRequiredTeamSkills = selectedTeam.last * selectedTeam.count
    currentCollectiveTeamSkills = selectedTeam.sum

    remainingSkillsRequired = (totalCollectiveRequiredTeamSkills - currentCollectiveTeamSkills).abs
  end

  def calculate_selected_team(startingIndexPoint: 0)
    if startingIndexPoint === 0
      return @allCandidateSkillLevels[0...(@requiredTeamCount)]
    end
    @allCandidateSkillLevels[startingIndexPoint..(startingIndexPoint+@requiredTeamCount)]
  rescue
    @allCandidateSkillLevels[startingIndexPoint..]
  end

  def calculate_difference_in_candidate_skill_levels
    differenceInSkillLevel = []
    diffCounter = nil

    @allCandidateSkillLevels.each do |skill|
      differenceInSkillLevel << (diffCounter.nil? ? nil : (skill - diffCounter))
      diffCounter = skill
    end

    differenceInSkillLevel.compact
  end

  def calculate_selected_team_index_point(diffArray: [], requiredTeamCount: 0 )
    sumOfRequiredTeam = nil
    startingIndexPoint = 0

    diffArray.each_with_index do |skillDiff, index|
      next if (index + requiredTeamCount) >= diffArray.count

      sumOfNextSkills = diffArray[index..(index+requiredTeamCount)].sum

      if sumOfRequiredTeam.nil?
        sumOfRequiredTeam = sumOfNextSkills
        startingIndexPoint = index
        next
      end

      if sumOfNextSkills < sumOfRequiredTeam
        sumOfRequiredTeam = sumOfNextSkills
        startingIndexPoint = index
      end

    end

    return startingIndexPoint
  end

end

inputData = {
  testData: [
    { totalStudents: 4, teamMembers: 3, candidatesSkillLevels: [3, 1, 9, 100] },
    { totalStudents: 6, teamMembers: 2, candidatesSkillLevels: [5, 5, 1, 2, 3, 4] },
    { totalStudents: 5, teamMembers: 5, candidatesSkillLevels: [7, 7, 1, 7, 7] },
    { totalStudents: 1000000, teamMembers: 999999, candidatesSkillLevels: Array.new(1000000) { [*1..1000].sample } },
  ],
  testCases: 4,
}


puts "#{'-'*20} Expected Results #{'-'*20}"
inputData[:testData].each_with_index do |result, index|
  trainingCoachObject = TrainingCoach.new(result.merge({ case_number: (index+1) }))
  puts "Case #{index+1}: #{trainingCoachObject.call}\n"
end


puts "#{'-'*20} Time spent #{'-'*20}"
Benchmark.bm do |bench|

  inputData[:testData].each_with_index do |result, index|
    trainingCoachObject = TrainingCoach.new(result.merge({ case_number: (index+1) }))

    bench.report {
      trainingHours = trainingCoachObject.call
      puts "Case #{index+1}: #{trainingHours}\n"
    }
  end

end

puts "#{'-'*20} Memory usage #{'-'*20}"

Benchmark.memory do |bench|
  inputData[:testData].each_with_index do |result, index|
    trainingCoachObject = TrainingCoach.new(result.merge({ case_number: (index+1) }))

    bench.report {
      trainingHours = trainingCoachObject.call
      puts "Case #{index+1}: #{trainingHours}\n"
    }
  end
end
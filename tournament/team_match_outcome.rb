class TeamMatchOutcome
  attr_reader :outcome, :points

  def initialize(outcome: :foo, points: 0)
    @outcome = outcome
    @points = points
  end

  def draw?
    outcome == :draw
  end

  def loss?
    outcome == :loss
  end

  def win?
    outcome == :win
  end
end

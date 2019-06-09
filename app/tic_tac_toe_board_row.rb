class TicTacToeBoardRow
  def initialize(positions)
    @positions = positions
  end

  def to_s
    @positions.map do |value|
      value == nil ? ' ' : value
    end.map(&:upcase).join(' | ')
  end
end

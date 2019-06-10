require_relative './tic_tac_toe_board_row'

class TicTacToeBoard
  attr_accessor :positions, :rows

  WINNING_CONFIGURATIONS = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6],
  ]

  def initialize(positions)
    @positions = positions
  end

  def mark(player, index)
    @positions[index] = player
  end

  def rows
    @positions.each_slice(3).to_a.map do |p|
      TicTacToeBoardRow.new(p)
    end
  end

  def to_s
    rows.map(&:to_s).join("\n")
  end

  def draw?
    WINNING_CONFIGURATIONS.map do |indices|
      both_x_and_o_present?(indices)
    end.uniq == [true]
  end

  def winner
    %w(X O).each do |mark|
      return mark if has_winning_configuration?(mark)
    end

    nil
  end

  private

  def has_winning_configuration?(mark)
    WINNING_CONFIGURATIONS.each do |indices|
      return true if all_indices_match?(mark, indices)
    end

    false
  end

  def all_indices_match?(mark, indices)
    indices.each do |index|
      return false unless @positions[index] == mark.downcase
    end

    true
  end

  def both_x_and_o_present?(indices)
    marks = indices.map { |i| @positions[i] }
    marks.include?('x') && marks.include?('o')
  end
end

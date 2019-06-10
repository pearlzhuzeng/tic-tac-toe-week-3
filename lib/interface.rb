require_relative '../app/tic_tac_toe_board'

class Interface
  attr_reader :player, :position
  attr_accessor :positions

  def initialize
    @positions = Array.new(9)
  end

  def run(commands)
    @player = commands[0].each_key.first[-1]
    @position = commands[0][commands[0].each_key.first].to_i
  end

  def next_message
    @positions[@position] = @player
    TicTacToeBoard.new(@positions).to_s
  end
end

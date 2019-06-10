require_relative '../app/tic_tac_toe_board'

class Interface
  attr_reader :board
  attr_accessor :positions

  def initialize
    @positions = Array.new(9)
    @board = TicTacToeBoard.new(@positions)
  end

  def run(commands)
    commands.each_with_index do |command, i|
      player = i % 2 == 0 ? 'x' : 'o'
      position = command.values.first.to_i
      @board.mark(player, position)
    end   
  end

  def next_message
    if @board.winner
      "#{@board.winner} wins"
    else
      @board.to_s
    end
  end
end

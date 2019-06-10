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
    return 'MEOW MEOW, MOTHERFUCKER!' if @board.draw?
    return "#{@board.winner} wins" if @board.winner
    
    @board.to_s
  end
end

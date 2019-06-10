require_relative '../app/tic_tac_toe_board'

class Interface
  VALID_INPUT = ['0', '1', '2', '3', '4', '5', '6', '7', '8']

  attr_reader :board
  attr_accessor :positions

  def initialize
    @positions = Array.new(9)
    @board = TicTacToeBoard.new(@positions)
  end

  def run(commands)
    commands.each_with_index do |command, i|
      player = i % 2 == 0 ? 'x' : 'o'
      position = command.values.first

      if VALID_INPUT.include?(position)
        @board.mark(player, position.to_i)
      else
        @positions[0] = "INVALID"
      end
    end   
  end

  def next_message
    return "That's not how we do things around here" if @positions.include?("INVALID")
    return 'MEOW MEOW, MOTHERFUCKER!' if @board.draw?
    return "#{@board.winner} wins" if @board.winner
    
    @board.to_s
  end
end

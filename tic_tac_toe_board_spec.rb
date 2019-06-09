require 'pry'

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

class TicTacToeBoard
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

    @rows = positions.each_slice(3).to_a.map do |p|
      TicTacToeBoardRow.new(p)
    end
  end

  def to_s
    @rows.map(&:to_s).join("\n")
  end

  def winner
    %w(X O).each do |mark|
      return mark if has_winning_configuration?(mark)
    end
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
end

RSpec.describe TicTacToeBoard do
  describe '#to_s' do
    it 'formats the board' do
      positions = [
        'x', nil, 'o',
        nil, 'x', nil,
        'o', 'o', 'x'
      ]

      board = TicTacToeBoard.new(positions)
      expect(board.to_s).to eq("X |   | O\n  | X |  \nO | O | X")
    end
  end

  describe '#winner' do
    context 'winning column (column 0)' do
      it 'returns X' do
        positions = [
          'x', nil, nil,
          'x', nil, nil,
          'x', nil, nil
        ]

        board = TicTacToeBoard.new(positions)
        expect(board.winner).to eq('X')
      end
    end

    context 'winning column (column 1)' do
      it 'returns X' do
        positions = [
          nil, 'x', nil,
          nil, 'x', nil,
          nil, 'x', nil
        ]

        board = TicTacToeBoard.new(positions)
        expect(board.winner).to eq('X')
      end
    end

    context 'winning column (column 2)' do
      it 'returns X' do
        positions = [
          nil, nil, 'x',
          nil, nil, 'x',
          nil, nil, 'x'
        ]

        board = TicTacToeBoard.new(positions)
        expect(board.winner).to eq('X')
      end
    end

    context 'winning row (row 0)' do
      it 'returns X' do
        positions = [
          'x', 'x', 'x',
          nil, nil, nil,
          nil, nil, nil,
        ]

        board = TicTacToeBoard.new(positions)
        expect(board.winner).to eq('X')
      end
    end

    context 'winning row (row 1)' do
      it 'returns X' do
        positions = [
          nil, nil, nil,
          'x', 'x', 'x',
          nil, nil, nil,
        ]

        board = TicTacToeBoard.new(positions)
        expect(board.winner).to eq('X')
      end
    end

    context 'winning row (row 2)' do
      it 'returns X' do
        positions = [
          nil, nil, nil,
          nil, nil, nil,
          'x', 'x', 'x',
        ]

        board = TicTacToeBoard.new(positions)
        expect(board.winner).to eq('X')
      end
    end

    context 'winning row (diagonal from top left to bottom right)' do
      it 'returns X' do
        positions = [
          'x', nil, nil,
          nil, 'x', nil,
          nil, nil, 'x',
        ]

        board = TicTacToeBoard.new(positions)
        expect(board.winner).to eq('X')
      end
    end

    context 'winning row (diagonal from bottom left to top right)' do
      it 'returns X' do
        positions = [
          nil, nil, 'x',
          nil, 'x', nil,
          'x', nil, nil,
        ]

        board = TicTacToeBoard.new(positions)
        expect(board.winner).to eq('X')
      end
    end

    context 'winner is O' do
      it 'returns O' do
        positions = [
          nil, nil, nil,
          nil, nil, nil,
          'o', 'o', 'o',
        ]

        board = TicTacToeBoard.new(positions)
        expect(board.winner).to eq('O')
      end
    end
  end
end

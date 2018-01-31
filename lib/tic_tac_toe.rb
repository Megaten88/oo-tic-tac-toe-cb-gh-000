class TicTacToe
  def initialize(board=nil)
    @board = board || Array.new(9," ")
  end

  def display_board
  puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
  puts "-----------"
  puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
  puts "-----------"
  puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def position_taken?(index)
    if @board[index]!=" "
      return true
    end
    return false
  end

  def valid_move?(index)
    if index.between?(0,8) && position_taken?(index) == false
      return true
    end
    return false
  end

  def input_to_index(input)
    input.to_i-1
  end

  def move(index, current_player)
    @board[index] = current_player
  end

  WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [6,4,2]
  ]

  def won?
    WIN_COMBINATIONS.each do |win_combination|
      winx = win_combination.all? do |cell|
        @board[cell]=="X"
      end
      wino = win_combination.all? do |cell|
        @board[cell]=="O"
      end
      if winx || wino
        return win_combination
      end
    end
    return false
  end

  def full?
     @board.all? do |cell|
       cell!=" "
     end
  end

  def draw?
    if won?
      return false
    else
      if full?
        return true
      else
        return false
      end
    end
  end

  def over?
    won?||full?||draw?
  end

  def winner
    win = won?
    if win
      winner = @board[win[0]]
    else
      return nil
    end
    winner
  end

  def turn
    puts "Please enter 1-9:"
    input = gets.chomp
    index = input_to_index(input)
    if valid_move?(index)
      player = current_player
      move(index,player)
      display_board
    else
      turn
    end
  end

  def turn_count
    count=0
    for value in @board do
      value!=" " ? count+=1: count = count
    end
    return count
  end

  def current_player
    turn_count.even? ? "X":"O"
  end

  def play
    until over?
      turn
      over?
    end
    if won?
      puts "Congratulations #{winner}!"
    elsif draw?
      puts "Cat\'s Game!"
    end
  end
end

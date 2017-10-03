class Array
  def all_same?
    won = false
    self.each do |x| 
      if x.uniq.length == 1 && !x.include?("-")
      won = true
      end
    end
    won
  end
end


module Tictactoe
  
  class Game
    attr_accessor :grid, :players, :current_player, :turn, :winner, :draw
    def initialize
      @grid = Board.new
      @turn = 0
      @winner = false
      @draw = false
      @players = {}
      @current_player = "" 
    end
    
    def play
      welcome_message
      initialize_players
      game
    end
    
    def welcome_message
      puts "---------------------------------"
      puts "------Welcome to TicTacToe!------"
      puts "---------------------------------"
      puts ""
    end
      
    def initialize_players
      puts "Please choose first player's name:"
      @players[0] = Player.new
      @players[0].sym = "X"
      puts "Please choose second player's name:"
      @players[1] = Player.new
      @players[1].sym = "O"
      puts ""
    end
    
    def game
      until @winner == true || @draw == true do
        @turn += 1
        puts "Turn #{@turn}"
        grid.print_grid
        take_turns
        game_over?
      end
    end
    
    def take_turns
      if @turn.odd?
        @current_player = @players[0]
        else 
        @current_player = @players[1]
      end
        puts "#{@current_player.name}, please make your move. Select 1-9"
        make_move
    end
    
    def make_move
      move = gets.chomp
      sym = @current_player.sym
      if move.to_i > 0 && move.to_i < 10
        case move
          when "1" 
            @grid.get_cell(0,0) == "-" ? @grid.set_cell(0, 0, sym) : invalid_move
          when "2"
            @grid.get_cell(0,1) == "-" ? @grid.set_cell(0, 1, sym) : invalid_move
          when "3"
            @grid.get_cell(0,2) == "-" ? @grid.set_cell(0, 2, sym) : invalid_move
          when "4"
            @grid.get_cell(1,0) == "-" ? @grid.set_cell(1, 0, sym) : invalid_move
          when "5"
            @grid.get_cell(1,1) == "-" ? @grid.set_cell(1, 1, sym) : invalid_move
          when "6"
            @grid.get_cell(1,2) == "-" ? @grid.set_cell(1, 2, sym) : invalid_move
          when "7"
            @grid.get_cell(2,0) == "-" ? @grid.set_cell(2, 0, sym) : invalid_move
          when "8"
            @grid.get_cell(2,1) == "-" ? @grid.set_cell(2, 1, sym) : invalid_move
          when "9"
            @grid.get_cell(2,2) == "-" ? @grid.set_cell(2, 2, sym) : invalid_move
          end
        else 
          invalid_move
      end
    end
    
    def invalid_move
      puts "Incorrect move. Please try again"
      make_move
    end
    
    def game_over?
      win?
      draw?
    end
    
    def win?
      if @grid.all_same? == true 
        @winner = true
        @grid.print_grid
        puts "#{@current_player.name} has won!"
      end
    end
    
    def draw?
      if @turn == 9
        @draw = true
        @grid.print_grid
        puts "Game ended in DRAW!"
      end
    end
      
  end

  class Board
    attr_accessor :grid
    
    def initialize
      @grid = Array.new(3) {Array.new(3) {Cell.new("-").value}}
    end
    
    def print_grid
      @grid.each_slice(1) {|x| puts x.join(" | ")}
    end
    
    def get_cell(x, y)
      grid[x][y]
    end
    
    def set_cell(x, y, value)
      grid[x][y] = value
    end
    
    def all_same?
      grid.all_same? || grid.transpose.all_same?
    end
    
  end
  
  class Player
    attr_accessor :name, :sym
    
    def initialize(name = gets.chomp)
      @name = name
      @sym = sym
    end
  end
  
  class Cell
    attr_accessor :value
    
    def initialize(value = "")
      @value = value
    end
  end

end

include Tictactoe

myGame = Game.new
myGame.play

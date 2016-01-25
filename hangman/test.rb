class Game
  def initialize
    @guess = ""
    @hang_board = Array.new
    @turn = 0
  end

 def random_word
    @hang_word = "boogers".split('')
  end

  def user_input
    @guess = gets.chomp
    if @guess.length >= 2
      puts "Sorry, you can only input one letter."
      puts "Try again: "
      @guess = gets.chomp
    end
  end

  def hangman_board
    @hang_word.each do |c|
      @hang_board << " _ "
    end
  end

  def check(guess, hang_word)
    @hang_word.each_with_index do |c, i|
      if @hang_word.at(i) == (@guess)
        @hang_board.delete_at(i)
        @hang_board.insert(i, @guess + " ")
      end
    end
  end

  def results
      @hang_board.join
  end

  def turn
     puts "Insert guess:"
     user_input
     puts ""
     check(@guess, @hang_word)
     puts results
     @turn += 1
  end

  def play
    puts random_word
    hangman_board
    5.times{turn}
  end

end

test = Game.new
test.play

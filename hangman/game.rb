class Game
  def initialize(word_list = Array.new)
    @word_list = word_list
    @words = File.readlines "5desk.txt"
    @guess = ""
    @hang_board = Array.new
    @turn = 0
    @game_over = false
  end

  def create_word_list
    @words.each do |word|
      word.strip!
      if word.length >=5 && word.length <= 12
        @word_list << word
      end
    end
  end

  def random_word
    c = Random.new
    choice = c.rand(0..52453).to_int
    @hang_word = @word_list[choice].split('')
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
    hang_word.each_index do |i|
      if hang_word.at(i).casecmp(guess) == 0
        @hang_board.delete_at(i)
        @hang_board.insert(i, hang_word.at(i) + " ")
      end
    end
  end

  def results
    @hang_board.join
  end

  def turn
    puts "Insert guess:"
    user_input
    check(@guess, @hang_word)
    puts results
    @turn += 1
    puts "You have #{10-@turn} turns left."
  end

  def game_over
    win if winner?
    lose if loser?
  end

  def win
    puts "Congratulations! You guessed the word! Want to play again? [Y/n]"
    play_again
  end

  def lose
    puts "Ouch, it looks like you're out of turns. Want to play again? [Y/n]"
    play_again
  end

  def play_again
      answer = gets.chomp
      if answer.casecmp("y") == 0
        play
      elsif answer.cas("n") == 0
        puts "Well, maybe later!"
    end
  end

  def strip_hang_board
    @strip_board = @hang_board.collect{|c| c.strip}.to_s
  end

  def play
    create_word_list
    random_word
    hangman_board
    puts @hang_word.join
    10.times do
      if @hang_word == @strip_board
        win
      else
        turn
        strip_hang_board
      end
      #lose
      puts "board: " + @strip_board
      puts "word: " + @hang_word.to_s
      puts @strip_board === @hang_word
      #puts @hang_word.casecmp(@hang_board)
    end
  end

  def winner?
    return @game_over = true if @hang_word == @hang_board
  end

  def loser?
    return @game_over = true if @turn == 12
  end

end

test = Game.new
test.play

class Game
  def initialize(word_list = Array.new, message = Message.new)
    @word_list = word_list
    @words = File.readlines "5desk.txt"
    @guess = ""
    @hang_board = Array.new
    @turn = 0
    @turn_num = 13
    @game_over = false
    @message = message
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
      @message.user_input
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
    @message.turn
    user_input
    check(@guess, @hang_word)
    @message.line
    puts "Your results: " + results
    @turn += 1
    puts "You have #{@turn_num-@turn} turns left."
    @message.line
  end

  def win
    @message.win
    play_again
  end

  def lose
    @message.lose
    play_again
  end

  def play_again
      answer = gets.chomp
      if answer.casecmp("y") == 0
        new_game
      else
        puts "Well, maybe later!"
    end
  end

  def strip_hang_board
    @strip_board = @hang_board.collect{|c| c.strip}
  end

  def new_game
    @hang_board = Array.new
    @strip_board = Array.new
    play
  end

  def in_game
    @turn_num.times do
      if @hang_word == @strip_board
        win
        break
      elsif @turn_num == 0
        lose
        break
      else
        turn
        strip_hang_board
      end
    end

  end

  def play
    @message.welcome_message
    create_word_list
    random_word
    hangman_board
    #puts @hang_word.join
    in_game
  end
end

class Message
  def initialize
    @message = Array.new
  end

  def line
    puts "---------------------------------------------"
  end

  def welcome_message
      line
      puts "Are you ready to play Hangman?"
      puts "You have 13 tries to guess the right word."
      puts "The computer will randomly choose a word between 5 - 12 characters."
      #insert save message
      line
  end

  def user_input
    line
    puts "Sorry, you can only input one letter."
    puts "Try again: "
  end

  def turn
    puts "Insert guess:"
  end

  def win
    line
    puts "Congratulations! You guessed the word! Want to play again? [Y/n]"
  end

  def lose
    line
    puts "Ouch, it looks like you're out of turns. Want to play again? [Y/n]"
  end

end


test = Game.new
test.play

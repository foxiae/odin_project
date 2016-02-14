require 'yaml'

class Game

  def initialize
    @message = Message.new
    @board = Board.new
    @save = Save.new
    @incr_turn = true #turns false if letter is guessed
  end

  def user_input
    @save.guess = gets.chomp
    @save.guess_collection << @save.guess + ", "
    if @save.guess.casecmp('save') == 0
      @save.save_game
      @message.save
      answer = gets.chomp
      if answer.casecmp('n') == 0
        puts "Your current progress is below."
        puts "See you next time!"
        @game_over = true
      end
    elsif @save.guess.casecmp('stats') == 0
      @board.stats
    elsif @save.guess.length >= 2
      @message.user_input
      @save.guess = gets.chomp
      @save.guess_collection << @save.guess + ", "
    end
  end

  def check(guess, hang_word)
    puts "Guess: #{guess}"
    puts "hang word: #{hang_word}"
    puts "hang board: #{@save.hang_board}"
    hang_word.each_index do |i|
      if hang_word.at(i).casecmp(guess) == 0
        @save.hang_board.delete_at(i)
        @save.hang_board.insert(i, hang_word.at(i) + " ")
        @incr_turn = false
      end
    end
  end

  def turn
    @message.turn
    user_input
    check(@save.guess, @save.hang_word)
    incr_turn
    turn_result
  end

  def turn_result
    @message.line
    puts "     Your results: " + @board.results
    puts "     Letters guessed: #{@save.guess_collection.join}"
    puts "     You have #{@save.turns_left} turns left."
    @message.line
  end

  def incr_turn
    if @incr_turn
      @save.turns_left = @save.turns_left - 1
    end
    puts @incr_turn
    @incr_turn = true
  end

  def win
    @message.win
    @save.wins += 1
    stats
    play_again
  end

  def lose
    stats
    @message.lose
    puts "The correct word was #{@save.hang_word.join}"
    play_again
  end

  def play_again
    @message.play_again
      answer = gets.chomp
      if answer.casecmp("y") == 0
        new_game
      elsif answer.casecmp("n") == 0
        puts "Well, maybe later!"
      else
        puts "Enter only y or n."
    end
  end


  def new_game
    @save.guess_collection = Array.new
    @game_over = false
    @save.turns_left = 6
    @save.game_count += 1
    @board.create_board
    in_game
  end

  def word_match
     if @save.hang_word == @board.strip_board
       @game_over = true
       win
     end
  end

  def out_of_turns
    if @save.turns_left == 0
      @game_over = true
      lose
    end
  end

  def in_game
    until @game_over
      turn
      @board.strip_hang_board
      word_match
      out_of_turns
    end
  end

  def start
    @message.welcome_message
    #@save.game_count += 1
    puts @save.game_count.inspect
    choose_game
    in_game
  end

  def choose_game
    answer = gets.chomp
    if answer.casecmp('y') == 0
      @save.load_game
    elsif answer.casecmp('n') == 0
      @board.initial_board
    end
  end
end

class Save
  attr_accessor :guess, :guess_collection, :turns_left, :game_count, :wins, :hang_word, :hang_board

  def initialize
    @guess = ""
    @guess_collection = Array.new
    @turns_left = 6
    @game_count = 0
    @wins = 0
    @hang_word = Array.new
    @hang_board = Array.new
  end

  def load_game
    content = File.open("games/saved.yaml", "r") {|file| file.read}
    y = YAML.load(content)
    puts yhang_board
  end

  def save_game
      Dir.mkdir("games") unless Dir.exist? "games"
      @filename = "games/saved.yaml"
      File.open(filename, "w") do |file|
          file.puts YAML::dump(self)
          puts YAML.dump(self)
      end
  end
end

class Board
  attr_accessor :hang_board, :strip_board, :hang_word
  def initialize
    @save = Save.new
    @message = Message.new
    @words = File.readlines "5desk.txt"
    @word_list = Array.new
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
    @save.hang_word = @word_list[choice].split('')
  end

  def hangman_board
    @save.hang_word.each do |c|
      @save.hang_board << " _ "
    end
  end

  def results
    @save.hang_board.join
  end

  def strip_hang_board
    @strip_board = @save.hang_board.collect{|c| c.strip}
  end

  def initial_board
    create_word_list
    random_word
    hangman_board
  end

  def create_board
    @save.hang_board = Array.new
    @strip_board = Array.new
    random_word
    hangman_board
  end

  def stats
    @message.line
    puts "You have won #{@save.wins} out of #{@save.game_count} games."
    @message.line
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
      puts "You have 6 turns to guess the right word."
      puts "Should you correctly guess the letter, you don't lose a turn."
      puts "The computer will randomly choose a word between 5 - 12 characters."
      puts "Type 'SAVE' to save your progress at the beginning of a turn."
      puts "Type 'STATS' to see your current wins!"
      line
      puts "Would you like to load a previous game? [Y/n]"
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
    puts "Congratulations! You guessed the word!"
  end

  def lose
    line
    puts "Ouch, it looks like you're out of turns."
  end

  def play_again
    puts "Want to play again? [Y/n]"
  end

  def save
    puts "Your progress has been saved. Do you wish to continue? [Y/n]"
  end
end

class Save
  def initialize
    #@game = Game.new
  end

  def vartest
    puts @game.wins
    puts @save.hang_word
  end

end

test = Game.new
test.start

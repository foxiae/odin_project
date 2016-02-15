require 'yaml'
words = File.readlines "5desk.txt"


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

  def input_error_mes
    line
    puts "Sorry, you can only input one letter."
    puts "Try again: "
  end

  def turn_mes
    puts "Insert guess:"
  end

  def win_mes
    line
    puts "Congratulations! You guessed the word!"
  end

  def lose_mes
    line
    puts "Ouch, it looks like you're out of turns."
  end

  def play_again_mes
    puts "Want to play again? [Y/n]"
  end

  def save_mes
    puts "Your progress has been saved. Do you wish to continue? [Y/n]"
  end

  def game_save_mes
    puts "Your current progress is below."
    puts "See you next time!"
  end
end

class Save < Message
  attr_accessor :guess, :guess_collection, :turns_left, :game_count, :wins, :hang_word, :hang_board

  def initialize
    @word_list = Array.new
    @hang_word = Array.new
    @hang_board = Array.new
    @guess_collection = Array.new
    @incr_turn = true #returns false if letter is guessed
    @game_over = false
    @turns_left = 6
    @game_count = 0
    @wins = 0
  end

  def load_game
    content = File.open("save/past_game.yaml", "r") {|file| file.read}
    d = YAML.load(content)
    @hang_word = d.hang_word
    @hang_board = d.hang_board
    @game_count = d.game_count
    @turns_left = d.turns_left
    @wins = d.wins
    @guess_collection = d.guess_collection
  end

  def save_game
    Dir.mkdir("save") unless Dir.exist? "save"
    filename = "save/past_game.yaml"
    File.open(filename, "w") do |file|
        file.puts YAML::dump(self)
    end
  end
end

class Board < Save
  attr_accessor :hang_board, :strip_board, :hang_word
  def initialize
    @words = File.readlines "5desk.txt"
    super
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

  def hangman_board
    @hang_word.each do |c|
      @hang_board << " _ "
    end
  end

  def results
    @hang_board.join
  end

  def strip_hang_board
    @strip_board = @hang_board.collect{|c| c.strip}
  end

  def initial_board
    create_word_list
    random_word
    hangman_board
  end

  def create_board
    @hang_board = Array.new
    @strip_board = Array.new
    #random_word
    #hangman_board
    initial_board
  end

  def stats
    line
    puts "You have won #{@wins} out of #{@game_count} games."
    line
  end
end

class Turn < Board

  def initialize
    super
  end

  def user_input
    @guess = gets.chomp
    @guess_collection << @guess + ", " if @guess.length == 1
    check_input
  end

  def check_input
    if @guess.casecmp('save') == 0
      save_game
      save_mes
      answer = gets.chomp
      if answer.casecmp('n') == 0
        game_save_mes
        @game_over = true
      end
    elsif @guess.casecmp('stats') == 0
      stats
    elsif @guess.length >= 2
      input_error_mes
      user_input
    end
  end

  def check(guess, hang_word)
    puts "Guess: #{guess}"
    puts "hang word: #{hang_word}"
    puts "hang board: #{@hang_board}"
    hang_word.each_index do |i|
      if hang_word.at(i).casecmp(guess) == 0
        @hang_board.delete_at(i)
        @hang_board.insert(i, hang_word.at(i) + " ")
        @incr_turn = false
      end
    end
  end

  def turn_result
    line
    puts "     Your results: " + results
    puts "     Letters guessed: #{@guess_collection.join}" if @guess.length == 1
    puts "     You have #{@turns_left} turns left."
    line
  end

  def incr_turn
    if @incr_turn
      @turns_left = @turns_left - 1
    end
    @incr_turn = true
  end

  def turn
    turn_mes
    user_input
    check(@guess, @hang_word)
    incr_turn
    turn_result
  end
end

class Play < Turn

  def initialize
    super
  end

  def start
    welcome_message
    @game_count += 1
    choose_game
    in_game
  end

  def choose_game
    answer = gets.chomp
    if answer.casecmp('y') == 0
      load_game
    elsif answer.casecmp('n') == 0
      initial_board
    end
  end

  def in_game
    until @game_over
      turn
      strip_hang_board
      word_match
      out_of_turns
    end
  end

  def word_match
    if @hang_word == strip_board
      @game_over = true
      win
    end
  end

  def out_of_turns
    if @turns_left == 0
      @game_over = true
      lose
    end
  end

  def play_again
    play_again_mes
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
    @guess_collection = Array.new
    @game_over = false
    @turns_left = 6
    @game_count += 1
    create_board
    in_game
  end

  def win
    win_mes
    @wins += 1
    stats
    play_again
  end

  def lose
    stats
    lose_mes
    puts "The correct word was #{@hang_word.join}"
    play_again
  end
end

test = Play.new
test.start

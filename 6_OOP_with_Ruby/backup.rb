module Game
	class Start
		#prints instructions
		#may place this in Mastermind as it pertains more to it
		#asks user if wants to make/break code
		def initialize
			#get input from user once AI is built
			@instructions = "WELCOME TO MASTERMIND!"
		end

	end

	class Move
		#checks input from player/computer
		#prints boardbut 
		#tracks turns
		attr_reader :result
		attr_accessor :turn_num

		def initialize (turn_num = 0)
			@turn_num = turn_num
		end

		def check_input(code, input)
			@result = Array.new
			code.each_index do |x| 
				if code[x] == input[x] 
					@result << "R"
				else
					@result << "W"
				end
			end
    	end

		def turn
		    @turn_num += 1
		    @turns_left = 12 - @turn_num
		    message
		end
		
		def message
		    puts "Guess results: #{@result}."
			puts "You have #{@turns_left} turns left."
			puts "-----------------------------"
		end
		
		def game_over
			return :winner if winner?
			return :loser if loser?
			false
		end

		private

		def winner?
			return true if @result == ["R", "R", "R", "R"]
			false
		end

		def loser?
			return true if @turn_num == 12
			false
		end
	end

	class Status
		#ends after 12 turns
		#terminates if input is successful
		#prints results
		def game_over_message
			return "Congratulations! You cracked the code!" if move.game_over == :winner
			return "Looks like you're out of turns. Try again!" if move.game_over == :loser
		end
	end
end

module Mastermind
	#from viewpoint of player
	class Game
		#checks input from player/computer
		#prints boardbut 
		#tracks turns
		attr_accessor :turn_num, :result

		def initialize (turn_num = 0, result = Array.new)
			@turn_num = turn_num
			@result = result
		end

		def check_input(code, input)
			code.each_index do |x| 
				if code[x] == input[x] 
					@result << "R"
				else
					@result << "W"
				end
			end
			return @result
    	end

		def turn
		    @turn_num += 1
		    @turns_left = 12 - @turn_num
		    turn_message
		end
		
		def turn_message
		    puts "Guess results: #{@result}."
			puts "You have #{@turns_left} turns left."
			puts "-----------------------------"
		end
		
		def game_over_message
			return "Congratulations! You cracked the code!" if game_over == :winner
			return "Looks like you're out of turns. Try again!" if game_over == :loser
		end
		
		def game_over
			return :winner if winner?
			return :loser if loser?
			false
		end

		private

		def winner?
			return true if @result == ["R", "R", "R", "R"]
			false
		end

		def loser?
			return true if @turn_num == 12
			false
		end
	end

	class CodeBreaker
	    attr_reader :comp_code, :user_code, :game
	    
		def initialize(user_code = Array.new, game = Game.new)
			@comp_code = comp_code
			@user_code = user_code
			@game = game
		end

		def assign
			block = ("A".."F").to_a
			@comp_code = [block.sample, block.sample, block.sample, block.sample] 
		end

		def user_input
			y = ""
			4.times do
			    puts "Enter guess:"
				y = gets.upcase.chomp
				@user_code << y
			end
			@user_code.compact
		end

		def check
			game.check_input(@comp_code, @user_code)
			game.turn
		end
		
		def play
		    assign
		    while true do
		        user_input
                check
                if game.game_over ==true
                    puts game_over_message
                end
		    end
		end
	end
end

test = Mastermind::CodeBreaker.new
test.play
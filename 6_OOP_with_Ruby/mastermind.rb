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
		#prints board
		#tracks turns
		attr_reader :turn, :result

		def initialize
			@turn = 0
		end

		def check_input(code, input)
			@result = Array.new
			code.each_index do |x| 
				if code[x] == input[x] 
					result << "R"
				else
					result << "W"
				end
			end
			turn += 1
			turns_left = 12 - turn
			puts "Your guess results: #{result}. You have #{turns_left} "
		end

		def game_over
			return :winner if winner?
			return :loser if loser?
			false
		end

		private

		def winner?
			return true if result == ["R", "R", "R", "R"]
			false
		end

		def loser?
			return true if turn == 11
			false
		end
	end

	class GameOver
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
	class CodeBreaker
		def initialize
			@code = code
		end

		def assign
			@block = ("A".."F").to_a
			@code = [block.sample, block.sample, block.sample, block.sample] 
		end

		def user_input
			codebreak = Array.new
			y = ""

			4.times do
				y = gets.chomp
				codebreak << y
			end

			codebreak.compact
		end

		def check

		end
	end

	class CodeMaker
		#to make AI
	end
end
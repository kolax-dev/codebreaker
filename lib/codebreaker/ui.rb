require_relative 'codebreaker'
require_relative 'helpers'

module Codebreaker
  game = Start.new.start_game
  puts 'Start game. Enter 4 numbers from 1 to 6  (**for the hint, enter 7)'
  i = 0
  while i <= game.max_attempt
    result = game.input_code(gets.chomp)
    if result == true
      puts 'You win. Type your name'
      game.save_result(gets.chomp, i)
      i = game.max_attempt
      puts 'Start again? [y/n]'
      if gets.chomp == 'y'
        game = start_game
        i = 0
      else
        exit
      end
    elsif result == false
      puts 'You loose. Start again? [y/n]'
      if gets.chomp == 'y'
        game = start_game
        i = 0
      else
        exit
      end
    else
      puts result
      i += 1
    end
  end
end

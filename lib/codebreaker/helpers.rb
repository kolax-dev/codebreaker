module Codebreaker
  class Start
    def start_game
      game = Game.new
      game.start
      p game.secret_code
      game
    end
  end
end

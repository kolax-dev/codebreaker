module Codebreaker
  class Helpers
    def self.start_game
      game = Game.new
      game.start
      p game.secret_code
      game
    end
  end
end

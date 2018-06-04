def start_game
  game = Codebreaker::Game.new
  game.start
  p game.secret_code
  game
end

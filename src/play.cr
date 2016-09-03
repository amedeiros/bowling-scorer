require "./bowling-scorer"

games = ["X-/X5-8/9-X811-4/X", "9/8/9/8/9/8/9/8/9/81", "9/8/9/8/9/8/9/8/9/8/9",
  "XXXXXXXXXX9/", "XXXXXXXXXXXX"]

games.each do |game|
  BowlingScorer::Game.play(game)
end

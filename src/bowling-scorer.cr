require "./bowling-scorer/*"

module BowlingScorer
  class Game
    def self.play(game, display = true)
      lexer = BowlingScorer::Lexer.new(game)
      parser = BowlingScorer::Parser.new(lexer)
      parser.parse

      if display
        puts "Scoring game: #{game}\n\n"

        parser.frames.each do |frame|
          puts "Frame: #{frame.frame} Score: #{frame.score} Frame:| #{frame.roll_one?} | #{frame.roll_two?} | #{frame.roll_three?}"
        end

        puts "\nGame Total: #{parser.score}\n\n"
      end
    end
  end
end

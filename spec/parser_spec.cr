require "./spec_helper"

describe BowlingScorer::Parser do
  describe "parser" do
    it "should parse a frame with a strike correctly" do
      lexer  = BowlingScorer::Lexer.new("X")
      parser = BowlingScorer::Parser.new(lexer)
      parser.parse

      parser.score.should eq(10)
    end

    it "should parse a frame with a number in the first roll and spare in the second" do
      lexer  = BowlingScorer::Lexer.new("1/")
      parser = BowlingScorer::Parser.new(lexer)
      parser.parse

      parser.score.should eq(10)
    end

    it "should parse a frame with a spare when the following roll is a number" do
      # Frame one should be 10 for spare + 1 for the following roll being 1
      lexer  = BowlingScorer::Lexer.new("-/1-")
      parser = BowlingScorer::Parser.new(lexer)
      parser.parse

      parser.frames[0].score.should eq(11)
    end

    it "should parse a frame with a spare when the following roll is a strike" do
      # Frame one should be 10 for spare + 20 for the following roll being a strike
      lexer  = BowlingScorer::Lexer.new("-/X")
      parser = BowlingScorer::Parser.new(lexer)
      parser.parse

      parser.frames[0].score.should eq(20)
    end

    it "should parse a frame with a spare when the following roll is a spare" do
      # Frame one should be 10 for spare + 20 for the following roll being a spare
      lexer  = BowlingScorer::Lexer.new("-//")
      parser = BowlingScorer::Parser.new(lexer)
      parser.parse

      parser.frames[0].score.should eq(20)
    end

    it "should parse a frame with three strikes in a row correctly" do
      # Frame one should be 30 because frame two and three are also strikes
      lexer  = BowlingScorer::Lexer.new("XXX")
      parser = BowlingScorer::Parser.new(lexer)
      parser.parse

      parser.frames[0].score.should eq(30)
    end

    it "should parse a frame with just numbers correctly" do
      lexer  = BowlingScorer::Lexer.new("12")
      parser = BowlingScorer::Parser.new(lexer)
      parser.parse

      parser.frames[0].score.should eq(3)
    end

    it "should parse a full game correctly" do
      lexer  = BowlingScorer::Lexer.new("X-/X5-8/9-X811-4/X")
      parser = BowlingScorer::Parser.new(lexer)
      parser.parse

      # Total score
      parser.score.should eq(137)

      # Frames
      parser.frames[0].score.should eq(20)
      parser.frames[1].score.should eq(40)
      parser.frames[2].score.should eq(55)
      parser.frames[3].score.should eq(60)
      parser.frames[4].score.should eq(79)
      parser.frames[5].score.should eq(88)
      parser.frames[6].score.should eq(107)
      parser.frames[7].score.should eq(116)
      parser.frames[8].score.should eq(117)
      parser.frames[9].score.should eq(137)
    end
  end
end

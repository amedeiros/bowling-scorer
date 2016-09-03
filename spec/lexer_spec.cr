require "./spec_helper"

describe BowlingScorer::Lexer do
  describe "next_token" do
    it "will lex a strike" do
      lexer = BowlingScorer::Lexer.new("X")
      lexer.next_token.token_type.should eq(BowlingScorer::TokenType::STRIKE)
    end

    it "will lex a spare" do
      lexer = BowlingScorer::Lexer.new("/")
      lexer.next_token.token_type.should eq(BowlingScorer::TokenType::SPARE)
    end

    it "will lex a number" do
      lexer = BowlingScorer::Lexer.new("1")
      lexer.next_token.token_type.should eq(BowlingScorer::TokenType::NUMBER)
    end

    it "will lex a gutter" do
      lexer = BowlingScorer::Lexer.new("-")
      lexer.next_token.token_type.should eq(BowlingScorer::TokenType::GUTTER)
    end

    it "will lex EOF" do
      lexer = BowlingScorer::Lexer.new("")
      lexer.next_token.token_type.should eq(BowlingScorer::TokenType::EOF)
    end

    it "will raise an exception for an unknown char" do
      lexer = BowlingScorer::Lexer.new("A")

      expect_raises(Exception, "Unkown char: A") do
        lexer.next_token
      end
    end
  end
end

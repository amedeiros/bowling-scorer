require "./spec_helper"

describe BowlingScorer::Frame do
  describe "complete?" do
    describe "not the 10th frame" do
      it "should not be completed when no rolls are set" do
        frame = BowlingScorer::Frame.new(1)

        frame.completed?.should eq(false)
      end

      it "should not be completed when roll one is set and roll two is not set" do
        frame = BowlingScorer::Frame.new(1)
        token = BowlingScorer::Token.new(BowlingScorer::TokenType::NUMBER, "1")
        frame.set_roll(token)

        frame.completed?.should eq(false)
      end

      it "should be completed when the first roll is a strike" do
        frame = BowlingScorer::Frame.new(1)
        token = BowlingScorer::Token.new(BowlingScorer::TokenType::STRIKE, "X")
        frame.set_roll(token)

        frame.completed?.should eq(true)
      end

      it "should be completed when both rolls are set" do
        frame = BowlingScorer::Frame.new(1)
        token = BowlingScorer::Token.new(BowlingScorer::TokenType::NUMBER, "1")
        2.times { frame.set_roll(token) }

        frame.completed?.should eq(true)
      end
    end

    describe "10th frame" do
      it "should not be completed when no rolls are set" do
        frame = BowlingScorer::Frame.new(10)

        frame.completed?.should eq(false)
      end

      it "should not be completed when roll one is set and roll two is not set" do
        frame = BowlingScorer::Frame.new(10)
        token = BowlingScorer::Token.new(BowlingScorer::TokenType::NUMBER, "1")
        frame.set_roll(token)

        frame.completed?.should eq(false)
      end

      it "should not be completed when roll one is a strike" do
        frame = BowlingScorer::Frame.new(10)
        token = BowlingScorer::Token.new(BowlingScorer::TokenType::STRIKE, "X")
        frame.set_roll(token)

        frame.completed?.should eq(false)
      end

      it "should not be completed when roll two is a strike" do
        frame = BowlingScorer::Frame.new(10)
        token = BowlingScorer::Token.new(BowlingScorer::TokenType::STRIKE, "X")
        2.times { frame.set_roll(token) }

        frame.completed?.should eq(false)
      end

      it "should be completed when both rolls are set and the second frame is not a spare or strike" do
        frame = BowlingScorer::Frame.new(10)
        token = BowlingScorer::Token.new(BowlingScorer::TokenType::NUMBER, "1")
        2.times { frame.set_roll(token) }

        frame.completed?.should eq(true)
      end

      it "should be completed when roll one is a number and roll two is a spare and roll three is a strike" do
        frame = BowlingScorer::Frame.new(10)
        number = BowlingScorer::Token.new(BowlingScorer::TokenType::NUMBER, "1")
        spare = BowlingScorer::Token.new(BowlingScorer::TokenType::SPARE, "/")
        strike = BowlingScorer::Token.new(BowlingScorer::TokenType::STRIKE, "X")
        frame.set_roll(number)
        frame.set_roll(spare)
        frame.set_roll(strike)

        frame.completed?.should eq(true)
      end
    end
  end
end

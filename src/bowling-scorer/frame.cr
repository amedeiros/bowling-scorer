module BowlingScorer
  # Frame holds our rolls for a single frame.
  # This can allow us to set rolls as we parse the game.
  # We can also check the frame forwards and backwards during parsing
  # by checking what rolls have been set. This allows us to know
  # where we are in the current frame during the parsing process.
  class Frame
    property! roll_one : Token
    property! roll_two : Token
    property! roll_three : Token # 10th frame.
    property! score : Int32      # Running score of the game at this frame.

    getter frame : Int32 # What frame is this?


    def initialize(@frame = frame)
    end

    # completed? helps us know if the frame has been completed.
    # The parser uses this to know when to make a new frame.
    # Special case for frame 10 with three rolls.
    # If not frame 10 a frame is complete if its either a strike or
    # roll one and roll two are present.
    def completed? : Bool
      return false if !roll_one?

      if frame == 10
        if !roll_two? ||
           (roll_two.token_type == TokenType::SPARE ||
           roll_two.token_type == TokenType::STRIKE) &&
           !roll_three?
          return false
        end

        return true
      end

      # Every frame below 10
      roll_one.token_type == TokenType::STRIKE || roll_two? != nil
    end

    # set_roll helps us set the next roll in the frame.
    # Special case for frame 10 with three rolls.
    # Checks which roll starting with one is empty.
    def set_roll(token : Token) : Void
      if roll_one? == nil
        self.roll_one = token
      elsif roll_two? == nil
        self.roll_two = token
      elsif frame == 10 && roll_three? == nil
        self.roll_three = token
      end
    end
  end
end

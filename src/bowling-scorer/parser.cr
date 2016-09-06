module BowlingScorer
  # LL(K) Parser where our K is 3.
  # Our lookahead is three because of a strike is calculated differently
  # when you have three in a row.
  # Our parser is reading tokens off our lexer and building a list of frames.
  # The resulted list repesents a complete game with each frame having the
  # correct score for that frame.
  class Parser
    getter lexer : Lexer
    getter frames : Array(Frame)
    getter tokens : Array(Token)
    getter lookahead : Int32

    property score : Int32
    property index : Int32
    property frame : Int32
    property current_frame : Frame

    def initialize(@lexer = lexer, @lookahead : Int32 = 3)
      @frames = [] of Frame
      @tokens = [] of Token
      @index = 0
      @score = 0
      @frame = 1
      @current_frame = Frame.new(frame)
      prime
    end

    # Public API
    def parse : Void
      while current.token_type != TokenType::EOF
        if current.token_type == TokenType::STRIKE
          self.score += calculate_strike
        elsif current.token_type == TokenType::SPARE
          self.score += calculate_spare
        elsif current.token_type == TokenType::NUMBER
          self.score += calculate_number
        end

        current_frame.set_roll(current)
        process_frame if current_frame.completed?
        consume
      end
    end

    private def process_frame : Void
      self.current_frame.score = score # Running score
      frames << current_frame          # Collect the frames
      self.frame += 1                  # Advance one frame

      # Next frame
      self.current_frame = Frame.new(frame)
    end

    private def current : Token
      tokens[index]
    end

    private def match?(ahead : Int32, type : TokenType) : Bool
      peek(ahead).token_type == type
    end

    private def peek(ahead : Int32 = 1) : Token
      tokens[(index + ahead) % lookahead]
    end

    private def calculate_number : Int32
      if !current_frame.roll_one? && match?(1, TokenType::SPARE) ||
         frame == 10 && !current_frame.roll_two? && match?(1, TokenType::SPARE)
        return 0
      end

      return current.token.to_i
    end

    private def calculate_spare : Int32
      # Set the spare
      score = 10

      # Now check ahead if this is not frame 10.
      if frame < 10 && !current_frame.roll_two?
        if match?(1, TokenType::STRIKE) || match?(1, TokenType::SPARE)
          score += 10
          # If its a number add it to the running score.
        elsif match?(1, TokenType::NUMBER)
          score += peek.token.to_i
        end
      end

      score
    end

    private def calculate_strike : Int32
      score = 0

      if frame < 10 && match?(1, TokenType::STRIKE) && match?(2, TokenType::STRIKE)
        score += 30 # three strikes in a row is 30
      else
        score += 10 # Strike is 10

        # Find out how much we rolled in the next two turns
        if frame < 10
          (1..2).each do |n|
            if match?(n, TokenType::NUMBER)
              score += peek(n).token.to_i
            elsif match?(n, TokenType::SPARE) || match?(n, TokenType::STRIKE)
              score += 10
            end
          end
        end
      end

      score
    end

    # Consume will take another token from our lexer.
    # This is a circular reference to our tokens for lookahead.
    private def consume : Void
      tokens[index] = lexer.next_token
      self.index = (index + 1) % lookahead
    end

    # Why not call consume in the block you ask?
    # Because apparently in Cystal when you have an empty array
    # and you try and assign to 0 it says its out of bounds.
    # So instead we prime in this method
    # calculating the index and using the shuvel.
    private def prime : Void
      lookahead.times do
        tokens << lexer.next_token
        self.index = (index + 1) % lookahead
      end
    end
  end
end

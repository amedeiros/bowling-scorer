module BowlingScorer
  class Lexer
    getter game    : String
    property index : Int32
    property char  : Char | TokenType

    # String representation of our tokens.
    STRIKE  = "X"
    SPARE   = "/"
    GUTTER  = "-"
    NUMBERS = "0123456789"

    # Char representation of our tokens.
    STRIKE_C = 'X'
    SPARE_C  = '/'
    GUTTER_C = '-'

    def initialize(@game = game)
      @index = 0

      if game.size > 0
        @char = game[index]
      else
        @char = TokenType::EOF
      end
    end

    def next_token : Token
      if char != TokenType::EOF
        case char
        when STRIKE_C
          consume
          return Token.new(TokenType::STRIKE, STRIKE)
        when SPARE_C
          consume
          return Token.new(TokenType::SPARE, SPARE)
        when GUTTER_C
          consume
          return Token.new(TokenType::GUTTER, GUTTER)
        else
          if number?
            number = char
            consume
            return Token.new(TokenType::NUMBER, number.to_s)
          end

          raise Exception.new("Unkown char: #{char}")
        end
      end

      return Token.new(TokenType::EOF, "!")
    end

    private def number? : Bool
      NUMBERS.includes?(char.to_s)
    end

    private def consume : Void
      self.index += 1

      if index >= game.size
        self.char = TokenType::EOF
      else
        self.char = game[index]
      end
    end
  end
end

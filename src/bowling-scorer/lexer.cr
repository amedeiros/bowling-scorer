module BowlingScorer
  class Lexer
    getter game : String
    property index : Int32
    property char : Char | TokenType

    def initialize(@game = game)
      @index = 0

      if game.size > 0
        @char = game[index]
      else
        @char = TokenType::EOF
      end
    end

    def next_token
      if char != TokenType::EOF
        case char
        when 'X'
          consume
          return Token.new(TokenType::STRIKE, "X")
        when '/'
          consume
          return Token.new(TokenType::SPARE, "/")
        when '-'
          consume
          return Token.new(TokenType::GUTTER, "-")
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

    private def number?
      "0123456789".includes?(char.to_s)
    end

    private def consume
      self.index += 1

      if index >= game.size
        self.char = TokenType::EOF
      else
        self.char = game[index]
      end
    end
  end
end

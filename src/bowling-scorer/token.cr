module BowlingScorer
  class Token
    getter token_type : TokenType
    getter token : String

    def initialize(@token_type = token_type, @token = token)
    end

    def to_s(io)
      io << token_type << ", " << token
    end
  end
end

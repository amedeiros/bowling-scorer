# bowling-scorer

Solution to the bowling scorer problem on reddit found [here](https://m.reddit.com/r/ProgrammingPrompts/comments/3oxidq/medium_bowling_scores/?utm_source=mweb_redirect&compact=true).

Gave me an excuse to write a lexer/parser.

## Installation

Add it to your shard.yml:

```
dependencies:
  bowling-scorer:
    github: amedeiros/bowling-scorer
    version: ~> 0.1.0
```

`$ crystal deps`


## Usage

```crystal
# Run the games from the reddit challenge.
crystal src/play.cr

# Or require the library and play your own.
require 'bowling-scorer'
BowlingScorer::Game.play("X-/X5-8/9-X811-4/X")

# Or use the lexer/parser
lexer  = BowlingScorer::Lexer.new("X-/X5-8/9-X811-4/X")
parser = BowlingScorer::Parser.new(lexer)

parser.parse
```

## Development

`$ crystal spec`

`$ crystal tool format`

## Contributing

1. Fork it ( https://github.com/amedeiros/bowling-scorer/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [amedeiros](https://github.com/amedeiros) Andrew Medeiros - creator, maintainer

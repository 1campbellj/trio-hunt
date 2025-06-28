class Card
  attr_accessor :shape, :color, :texture, :number

  def initialize
    @shape = [ "diamond", "oval", "squiggle" ].sample
    @color = [ "red", "green", "purple" ].sample
    @texture = [ "solid", "striped", "open" ].sample
    @number = rand(1..3)
  end

  def self.set?(a, b, c)
    shapes = [ a.shape, b.shape, c.shape ]
    colors = [ a.color, b.color, c.color ]
    textures = [ a.texture, b.texture, c.texture ]
    numbers = [ a.number, b.number, c.number ]

    (shapes.uniq.size == 1 || shapes.uniq.size == 3) &&
      (colors.uniq.size == 1 || colors.uniq.size == 3) &&
      (textures.uniq.size == 1 || textures.uniq.size == 3) &&
      (numbers.uniq.size == 1 || numbers.uniq.size == 3)
  end
end

zero_sets = 0
total_boards = 100000

total_boards.times do
  cards = Array.new(12) { Card.new }
  sets = cards.combination(3).select { |a, b, c| Card.set?(a, b, c) }
  zero_sets += 1 if sets.empty?
end

probability = zero_sets.to_f / total_boards
puts "Probability of no sets in a board of 12 cards: #{probability}"

class SetProbability
  def self.random_probability
    c = SetCard.new
    zero_sets = 0
    total_boards = 100000

    total_boards.times do
      cards = []
      12.times { cards << SetCard.new }
      sets = cards.combination(3).select { |a, b, c| SetCard.set?(a, b, c) }
      zero_sets += 1 if sets.empty?
    end

    probability = zero_sets.to_f / total_boards
    puts "Probability of no sets in a board of 12 cards: #{probability}"
  end

  def self.deck_probability
    deck = Deck.new
    zero_deck_sets = 0

    total_boards.times do
      cards = deck.cards.sample(12)
      sets = cards.combination(3).select { |a, b, c| SetCard.set?(a, b, c) }
      zero_deck_sets += 1 if sets.empty?
    end

    puts "Probability of no sets in a board of 12 cards from a deck: #{zero_deck_sets.to_f / total_boards}"
  end
end

class SetCard
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

  def == (other)
    self.shape == other.shape &&
      self.color == other.color &&
      self.texture == other.texture &&
      self.number == other.number
  end

  def to_s
    "#{number} #{color} #{texture} #{shape}"
  end
end

class Deck
  attr_accessor :cards

  def initialize
    @cards = []
    until @cards.size == 81 do
      card = SetCard.new
      if !@cards.include?(card)
        @cards << card
      end
    end
  end

  def remove(set)
    @cards.delete(card)
  end
end

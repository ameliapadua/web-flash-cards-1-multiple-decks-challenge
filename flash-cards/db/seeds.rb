class DeckImporter
  def self.import(deck_name, filename)
    new_deck = Deck.create(title: deck_name)
    csv = CSV.new(File.open(filename), :headers => true)
    csv.each do |row|
      card_hash = {answer: nil, clue: nil}
      row.each do |field, value|
        if field == "answer"
          card_hash[answer: value]
        else
          card_hash[clue: value]
        end
      end
      new_deck.cards << Card.create(card_hash)
    end
  end
end

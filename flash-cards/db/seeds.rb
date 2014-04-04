class DeckImporter
  def self.import(deck_name, filename)
    new_deck = Deck.create(name: deck_name)
    csv = CSV.new(File.open(filename), :headers => true)
    csv.each do |row|
      card_hash = {term: nil, definition: nil, deck_id: new_deck.id}
      row.each do |field, value|
        if field == "term"
          card_hash[:term] = value
        else
          card_hash[:definition] = value
        end
      end
      new_deck.cards << Card.create(card_hash)
    end
  end
end

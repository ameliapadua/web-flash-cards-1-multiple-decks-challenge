require "faker"

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


4.times do
  User.create(name: Faker::Name.name,
              email: Faker::Internet.email,
              password: Faker::Internet.password)
end

Round.create(user_id: 1, deck_id: 3)

Guess.create(correct: 1,
             selected_term: 'Zombie',
             card_id: 23,
             round_id: 1)
Guess.create(correct: 0,
             selected_term: 'Basilisk',
             card_id: 24,
             round_id: 1)
Guess.create(correct: 1,
             selected_term: 'Gorgon',
             card_id: 25,
             round_id: 1)
Guess.create(correct: 1,
             selected_term: 'Cupacabra',
             card_id: 26,
             round_id: 1)
Guess.create(correct: 0,
             selected_term: 'Siren',
             card_id: 27,
             round_id: 1)
Guess.create(correct: 0,
             selected_term: 'Phoenix',
             card_id: 28,
             round_id: 1)
Guess.create(correct: 1,
             selected_term: 'Cockatrice',
             card_id: 29,
             round_id: 1)


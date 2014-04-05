class Round < ActiveRecord::Base
  belongs_to :user
  belongs_to :deck
  has_many :guesses

  def self.round_setup(deck_name)
    deck = Deck.where(name: deck_name).first
    deck_cards = deck.cards

    if PlayingCard.all.count == 0
      deck_cards.each do |card|
        PlayingCard.create(card_id: card.id)
      end

      @card_in_play = generate_card_in_play(deck_cards)
      remove_card_in_play_from_card_queue
    else
      @card_in_play = generate_card_in_play(cards_left_to_play)
      remove_card_in_play_from_card_queue
    end
  end

  def self.generate_card_in_play(deck)
    deck.sample
  end

  def self.cards_left_to_play
    card_queue_ids = PlayingCard.all

    card_queue_ids.inject([]) do |arr, id|
      arr << Card.find(id.card_id)
    end
  end

  def self.remove_card_in_play_from_card_queue
    PlayingCard.destroy_all(card_id: card_in_play.id)
  end

  def self.check_guess(guess, answer)
    guess == answer ? true : false
  end

  def self.card_in_play
    @card_in_play
  end
end

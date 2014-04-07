class Round < ActiveRecord::Base
  belongs_to :user
  belongs_to :deck
  has_many :guesses

  def self.round_setup(user_id, deck_name)
    deck = Deck.where(name: deck_name).first
    Round.create(user_id: user_id, deck_id: deck.id)
  end

  def self.game_setup(user_id, deck_name)
    deck = Deck.where(name: deck_name).first
    deck_cards = deck.cards

    if PlayingCard.all.count == 0
      deck_cards.each do |card|
        PlayingCard.create(card_id: card.id)
      end
      @card_in_play = generate_card_in_play(deck_cards)
      remove_card_in_play_from_card_queue
      puts "=================================="
      puts "Round id: #{Round.last.id}"
      puts "Current card: #{@card_in_play.id}"
      cards_left_to_play.each {|e| puts e.id}
      puts "=================================="
    else
      @card_in_play = generate_card_in_play(cards_left_to_play)
      remove_card_in_play_from_card_queue
      puts "=================================="
      puts "Round id: #{Round.last.id}"
      puts "Current card: #{@card_in_play.id}"
      cards_left_to_play.each {|e| puts e.id}
      puts "=================================="
    end
  end

  def self.round_verify
    current_round = Round.last
    # puts "=================================="
    # puts "Current round is: #{current_round.guesses.count}"
    # puts "=================================="
    if (current_round != nil) && (current_round.guesses.count == 0)
      current_round.destroy
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
    current_card_id = Card.where(term: answer).first.id
    current_round = Round.last.id

    if guess == answer
      Guess.create(correct: true, selected_term: guess, card_id: current_card_id, round_id: current_round)
      'CORRECT'
    else
      Guess.create(correct: false, selected_term: guess, card_id: current_card_id, round_id: current_round)
      'Incorrect'
    end
  end

  def self.card_in_play
    @card_in_play
  end
end

class Card < ActiveRecord::Base
  belongs_to :deck
  belongs_to :playing_card
  has_many :guesses
end

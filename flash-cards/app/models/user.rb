class User < ActiveRecord::Base
  validates :name, presence: true
  validates :email, format: {:with => /[-0-9a-zA-Z.+_]+@[-0-9a-zA-Z.+_]+\.[a-zA-Z]{2,4}/}, uniqueness: true
  validates :password, presence: true
  has_many :rounds
  has_many :decks, through: :rounds
  has_many :guesses, through: :rounds

  def self.authenticate(email, password)
    User.where(email: email, password: password).first
  end
end

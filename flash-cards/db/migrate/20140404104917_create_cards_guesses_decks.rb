class CreateCardsGuessesDecks < ActiveRecord::Migration
  def change
    create_table :decks do |t|
      t.string                  :title

      t.timestamps
    end

    create_table :cards do |t|
      t.text                    :clue
      t.text                    :answer
      t.integer                 :deck_id  # Foreign key to id field from decks table

      t.timestamps
    end

    create_table :guesses do |t|
      t.integer                 :card_id  # Foreign key to id field from cards table
      t.integer                 :user_id  # Foreign key to id field from users table
      t.integer                 :game_id  # Foreign key to id field from games table

      t.timestamps
    end

  end
end

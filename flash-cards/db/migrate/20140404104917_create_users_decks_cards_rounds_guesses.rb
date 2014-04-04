class CreateUsersDecksCardsRoundsGuesses < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email, null: false, uniqueness: true
      t.string :password, null: false

      t.timestamps
    end

    create_table :decks do |t|
      t.string :name, null: false, uniqueness: true
      t.integer :user_id  # Foreign key to id field from users table

      t.timestamps
    end

    create_table :cards do |t|
      t.text :definition, null: false
      t.text :term, null: false
      t.integer :deck_id  # Foreign key to id field from decks table

      t.timestamps
    end

    create_table :rounds do |t|
      t.integer :user_id  # Foreign key to id field from users table
      t.integer :deck_id  # Foreign key to id field from decks table

      t.timestamps
    end

    create_table :guesses do |t|
      t.boolean :correct
      t.string :selected_term
      t.integer :card_id  # Foreign key to id field from cards table
      t.integer :round_id  # Foreign key to id field from rounds table

      t.timestamps
    end

  end
end

class AddPlayingCards < ActiveRecord::Migration
  def change
    create_table :playing_cards do |t|
      t.integer :card_id

      t.timestamps
    end
  end
end

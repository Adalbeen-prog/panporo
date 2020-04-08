class AddChampionToGame < ActiveRecord::Migration[6.0]
  def change
    add_column :champions, :game_id, :integer
    add_index  :champions, :game_id
  end
end

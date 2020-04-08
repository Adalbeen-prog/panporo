class CreateChampions < ActiveRecord::Migration[6.0]
  def change
    create_table :champions do |t|
      t.string :name
      t.string :title
      t.string :image
      t.string :sprite
      t.text :skins, array: true, default: []
      t.text :lore
      t.string :tags
      t.text :info, array: true, default: []
      t.text :stats, array: true, default: []
      t.text :spells, array: true, default: []
      t.text :recommended, array: true, default: []
      
      t.timestamps
    end
  end
end

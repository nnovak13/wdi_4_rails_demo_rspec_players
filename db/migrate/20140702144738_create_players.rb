class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.text :name
      t.string :job
      t.integer :health
      t.integer :magic
    end
  end
end

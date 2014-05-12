class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.text :name, :job
      t.integer :health, :magic
    end
  end
end

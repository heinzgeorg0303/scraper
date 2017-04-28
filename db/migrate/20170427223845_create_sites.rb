class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites do |t|
      t.string :name
      t.string :url
      t.text :description
      t.integer :rank

      t.timestamps null: false
    end
  end
end

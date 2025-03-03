class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.references :merchant, null: false, foreign_key: true
      t.string :name
      t.string :description
      t.integer :price

      t.timestamps
    end
  end
end

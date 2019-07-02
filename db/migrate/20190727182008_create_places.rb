class CreatePlaces < ActiveRecord::Migration[5.2]
  def change
    create_table :places do |t|
      t.string :name
      t.text :description
      t.string :address
      t.integer :vote
      t.text :cost
      t.string :photo
      t.integer :status
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end

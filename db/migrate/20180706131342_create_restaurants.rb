class CreateRestaurants < ActiveRecord::Migration[5.2]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :weeks
      t.string :hours
      t.string :minutes

      t.timestamps
    end
  end
end

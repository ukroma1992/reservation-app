class ChangeHoursStoreForRestaurant < ActiveRecord::Migration[5.2]
  def change
    add_column :restaurants, :from_hour, :integer
    add_column :restaurants, :from_minutes, :integer
    add_column :restaurants, :to_hour, :integer
    add_column :restaurants, :to_minutes, :integer
    remove_column :restaurants, :minutes
  end
end

class CreateLocationsUsers < ActiveRecord::Migration
  def change
    create_table :locations_users, :id => false do |t|
      t.references :location, :user
    end

    add_index :locations_users, [:location_id, :user_id],
    name: "locations_users_index",
    unique: true
  end
end

class AddLocationToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :location, :st_point, geographic: true
    add_index :users, :location, using: :gist
  end
end

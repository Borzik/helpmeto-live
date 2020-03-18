class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :name, default: ""
      t.string :bio, default: ""
      t.string :sid, null: false
      t.integer :kind, null: false, default: 0
      t.st_point :location, geographic: true

      t.timestamps
    end
    add_index :users, :location, using: :gist
    add_index :users, :email, unique: true
  end
end

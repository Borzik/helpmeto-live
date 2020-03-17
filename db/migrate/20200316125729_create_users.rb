class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :name, default: ""
      t.string :bio, default: ""
      t.string :sid, null: false
      t.string :kind, null: false, default: 0

      t.timestamps
    end

    add_index :users, :email, unique: true
  end
end
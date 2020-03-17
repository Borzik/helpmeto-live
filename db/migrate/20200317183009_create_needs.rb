class CreateNeeds < ActiveRecord::Migration[6.0]
  def change
    create_table :needs do |t|
      t.belongs_to :user, null: false, foreign_key: true, index: true
      t.st_point :location, geographic: true
      t.string :description, null: false

      t.timestamps
    end
    add_index :needs, :location, using: :gist
  end
end

class CreateOffers < ActiveRecord::Migration[6.0]
  def change
    create_table :offers do |t|
      t.belongs_to :user, null: false, foreign_key: true, index: true
      t.belongs_to :need, null: false, foreign_key: true, index: true
      t.string :message, null: false
      t.string :contact_info, null: false

      t.timestamps
    end
  end
end

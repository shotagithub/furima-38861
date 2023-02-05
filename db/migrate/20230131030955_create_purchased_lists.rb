class CreatePurchasedLists < ActiveRecord::Migration[6.0]
  def change
    create_table :purchased_lists do |t|
      t.references  :user, null: false, foreign_key: true
      t.references  :item, null: false, foreign_key: true
      t.timestamps
    end
  end
end

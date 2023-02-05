class CreatePurchasers < ActiveRecord::Migration[6.0]
  def change
    create_table :purchasers do |t|
      t.string     :postal_code,    null: false
      t.string     :city,           null: false
      t.string     :street,         null: false
      t.string     :building
      t.string     :phone_number,   null: false
      t.references :purchased_list, null: false, foreign_key: true
      t.integer    :prefecture_id,  null: false
      t.timestamps
    end
  end
end

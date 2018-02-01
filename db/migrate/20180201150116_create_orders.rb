class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.references :customer, foreign_key: true
      t.references :service, foreign_key: true
      t.date :expiration_date
      t.string :instruction1
      t.string :instruction2
      t.string :instruction3
      t.string :moipid
      t.string :status

      t.timestamps
    end
  end
end

class CreateCustomers < ActiveRecord::Migration[5.0]
  def change
    create_table :customers do |t|
      t.string :fullname
      t.string :email
      t.string :phone
      t.string :cpfcnpj
      t.string :address

      t.timestamps
    end
  end
end

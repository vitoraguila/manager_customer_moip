class CreateServices < ActiveRecord::Migration[5.0]
  def change
    create_table :services do |t|
      t.string :name
      t.string :detail
      t.string :price
      t.string :recurrence

      t.timestamps
    end
  end
end

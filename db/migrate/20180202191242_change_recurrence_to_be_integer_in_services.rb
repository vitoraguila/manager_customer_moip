class ChangeRecurrenceToBeIntegerInServices < ActiveRecord::Migration[5.0]
  def change
    change_column :services, :recurrence, 'integer USING CAST(recurrence AS integer)'
  end
end

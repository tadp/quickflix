class AddStartAndEndTimesToPayments < ActiveRecord::Migration
  def change
    add_column :payments, :period_start, :integer
    add_column :payments, :period_end, :integer
  end
end

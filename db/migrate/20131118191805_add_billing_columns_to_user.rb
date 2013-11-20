class AddBillingColumnsToUser < ActiveRecord::Migration
  def change
    add_column :users, :plan, :string
    add_column :users, :plan_amount, :integer
    add_column :users, :billing_interval, :string
    add_column :users, :delinquent, :boolean, default: false
    add_column :users, :period_start, :integer
    add_column :users, :period_end, :integer
  end
end

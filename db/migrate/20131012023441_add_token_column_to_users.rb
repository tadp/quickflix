class AddTokenColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :token, :string
  end
end
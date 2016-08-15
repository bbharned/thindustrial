class AddBalanceToUsers < ActiveRecord::Migration
  def change
    add_column :users, :balance, :integer, default: 1000
  end
end

class AddRetiredToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :retired, :string
  end
end

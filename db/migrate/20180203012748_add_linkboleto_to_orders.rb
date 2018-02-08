class AddLinkboletoToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :link_boleto, :string
  end
end

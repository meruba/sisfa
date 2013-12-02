class RefernciaClienteFactura < ActiveRecord::Migration
def up
  	change_table :facturas do |t|
  		t.references :cliente, :null => false
  	end
  end
  def down
  	remove_column :facturas, :cliente_id
  end
end

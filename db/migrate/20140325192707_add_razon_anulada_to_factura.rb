class AddRazonAnuladaToFactura < ActiveRecord::Migration
  def change
    add_column :facturas, :razon_anulada, :string
  end
end

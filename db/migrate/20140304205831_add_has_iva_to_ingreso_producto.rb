class AddHasIvaToIngresoProducto < ActiveRecord::Migration
  def change
    add_column :ingreso_productos, :hasiva, :boolean, :default => false
  end
end

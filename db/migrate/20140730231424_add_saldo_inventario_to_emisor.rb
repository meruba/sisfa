class AddSaldoInventarioToEmisor < ActiveRecord::Migration
  def change
  	add_column :emisors, :saldo_inicial_inventario, :float
  end
end

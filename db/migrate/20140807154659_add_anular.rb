class AddAnular < ActiveRecord::Migration
  def change
  	add_column :item_hospitalizacions, :razon_anulada, :string
  	add_column :item_hospitalizacions, :anulado, :boolean, default: false
  	add_column :traspasos, :razon_anulada, :string
  	add_column :traspasos, :anulado, :boolean, default: false
  end
end

class AddFieldsItemHospitalizacion < ActiveRecord::Migration
  def change
  	add_column :item_hospitalizacions, :pedido_por, :string
  	add_column :item_hospitalizacions, :despachado_por, :string
  	add_column :item_hospitalizacions, :despachado, :boolean, default: false	
  end
end

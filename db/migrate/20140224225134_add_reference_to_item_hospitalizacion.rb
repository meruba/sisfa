class AddReferenceToItemHospitalizacion < ActiveRecord::Migration
  def change
  	add_reference :item_hospitalizacions, :hospitalizacion, index: true
  	remove_column :item_hospitalizacions, :producto_id
  	add_reference :item_hospitalizacions, :ingreso_producto, index: true
  end
end

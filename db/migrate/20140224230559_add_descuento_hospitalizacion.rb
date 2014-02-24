class AddDescuentoHospitalizacion < ActiveRecord::Migration
  def change
    add_column :hospitalizacions, :descuento, :float
  end
end

class AddFieldsToHospitalizacionRegistro < ActiveRecord::Migration
  def change
  	add_reference :hospitalizacion_registros, :doctor, index: true
    remove_column :hospitalizacion_registros, :tipo
  end
end

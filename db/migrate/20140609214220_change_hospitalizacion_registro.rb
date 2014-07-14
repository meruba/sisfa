class ChangeHospitalizacionRegistro < ActiveRecord::Migration
	def up
		add_column :hospitalizacion_registros, :alta, :boolean, default: false
	end

	def down
		remove_column :hospitalizacion_registros, :alta
	end
end

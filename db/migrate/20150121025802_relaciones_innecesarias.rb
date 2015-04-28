class RelacionesInnecesarias < ActiveRecord::Migration
	def up
		remove_reference :asignar_horarios, :item_tratamiento
		remove_reference :horarios, :paciente
	end
	def down
		add_reference :asignar_horarios, :item_tratamiento
		add_reference :horarios, :paciente
	end
end

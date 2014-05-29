class DeleteAndAddFields < ActiveRecord::Migration
	def change
		add_column :pacientes, :afiliado, :string
		add_column :pacientes, :discapacidad, :string
		remove_column :consulta_externa_morbilidads, :inicio_atencion
		remove_column :consulta_externa_morbilidads, :fin_atencion
		remove_column :consulta_externa_preventivas, :inicio_atencion
		remove_column :consulta_externa_preventivas, :fin_atencion
	end
end

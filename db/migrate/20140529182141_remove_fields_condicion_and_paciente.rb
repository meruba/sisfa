class RemoveFieldsCondicionAndPaciente < ActiveRecord::Migration
	def up
		remove_column :condicions, :antecedentes_personales
		remove_column :condicions, :antecedentes_familiares
		add_column :pacientes, :antecedentes_personales, :string
		add_column :pacientes, :antecedentes_familiares, :string
		add_column :condicions, :codigo_cie_1, :string
		add_column :condicions, :codigo_cie_2, :string
	end
	def down
		add_column :condicions, :antecedentes_personales, :string
		add_column :condicions, :antecedentes_familiares, :string
		remove_column :pacientes, :antecedentes_personales
		remove_column :pacientes, :antecedentes_familiares
		remove_column :condicions, :codigo_cie_1
		remove_column :condicions, :codigo_cie_2
	end
end

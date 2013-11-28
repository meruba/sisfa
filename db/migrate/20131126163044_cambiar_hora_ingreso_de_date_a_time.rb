class CambiarHoraIngresoDeDateATime < ActiveRecord::Migration
  def up
    remove_column :pacientes, :hora_de_ingreso
    add_column :pacientes, :hora_de_ingreso, :time
  end

  def down
		add_column :pacientes, :hora_de_ingreso, :date
    remove_column :pacientes, :hora_de_ingreso
  end
end

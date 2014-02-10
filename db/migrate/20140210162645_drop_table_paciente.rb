class DropTablePaciente < ActiveRecord::Migration
  def change
  	drop_table :pacientes
  end
end

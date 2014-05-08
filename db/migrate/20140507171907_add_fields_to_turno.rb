class AddFieldsToTurno < ActiveRecord::Migration
  def change
    add_reference :turnos, :doctor, index: true
    add_column :turnos, :numero, :integer, :default => 0
  	rename_column :turnos, :doctor, :doctor_a_cargo
  end
end

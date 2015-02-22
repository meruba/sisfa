class AddFieldsAsignarHorario < ActiveRecord::Migration
  def up
    add_column :asignar_horarios, :numero_factura, :integer
    add_column :asignar_horarios, :total_factura, :float, default: 0
    add_column :asignar_horarios, :diagnostico, :string
  end

  def down
    remove_column :asignar_horarios, :numero_factura
    remove_column :asignar_horarios, :total_factura
    remove_column :asignar_horarios, :diagnostico
  end
end

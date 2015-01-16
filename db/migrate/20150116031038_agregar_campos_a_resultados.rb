class AgregarCamposAResultados < ActiveRecord::Migration
  def change
  	add_column :resultado_tratamientos, :atendido, :boolean, default: false
  	add_column :resultado_tratamientos, :razon_editado, :string
   	add_reference :resultado_tratamientos,:asignar_horario,  index: true
  end
end

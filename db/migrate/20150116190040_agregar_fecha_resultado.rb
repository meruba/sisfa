class AgregarFechaResultado < ActiveRecord::Migration
  def change
  	add_column :resultado_tratamientos, :fecha, :datetime
  end
end

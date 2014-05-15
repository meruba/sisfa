class RenameTableRegistro < ActiveRecord::Migration
  def change
  	rename_table :registros, :hospitalizacion_registros
  end
end

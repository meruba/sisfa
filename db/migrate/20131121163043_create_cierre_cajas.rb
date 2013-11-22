class CreateCierreCajas < ActiveRecord::Migration
  def change
    create_table :cierre_cajas do |t|
    	t.date :fecha, :null => false
    	t.float :total_ingreso_externo, :null => false
    	t.float :total_ingreso_hospitalizacion, :null => false
    	t.integer :nuemero_total_facturas, :null => false

      t.timestamps
    end
  end
end

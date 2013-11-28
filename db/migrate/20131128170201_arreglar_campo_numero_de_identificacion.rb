class ArreglarCampoNumeroDeIdentificacion < ActiveRecord::Migration
  	 def up
    rename_column :proveedors, :numero_de_identifficacion, :numero_de_identificacion
   
  end

  def down
  	rename_column :proveedors, :numero_de_identificacion, :numero_de_identifficacion	
  end
end

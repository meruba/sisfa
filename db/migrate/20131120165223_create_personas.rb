class CreatePersonas < ActiveRecord::Migration
  def change
    create_table :personas do |t|
    	t.string :nombre, :null => false
    	t.string :direccion
    	t.string :numero_identificacion, :null => false
    	t.string :telefono
    	t.string :celular
    	t.string :email
    	t.string :tipo_de_paciente, :null => false
    	t.string :codigo_issfa
      t.timestamps
    end
  end
end

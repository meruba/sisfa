class AddFieldsRegistro < ActiveRecord::Migration
  def change
  	add_column :registros, :diagnostico_ingreso, :string
  	add_column :registros, :diagnostico_salida, :string
  	add_column :registros, :discapacidad, :string
  	add_column :registros, :dias_hospitalizacion, :integer
  end
end

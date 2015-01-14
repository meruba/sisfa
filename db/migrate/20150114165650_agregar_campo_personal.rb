class AgregarCampoPersonal < ActiveRecord::Migration
  def change
  	add_column :personals, :suspendido, :boolean, default: false
  end
end

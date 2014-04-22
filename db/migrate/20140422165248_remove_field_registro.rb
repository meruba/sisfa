class RemoveFieldRegistro < ActiveRecord::Migration
  def change
  	remove_column :registros, :cliente_id
  	remove_column :registros, :n_hclinica
  end
end

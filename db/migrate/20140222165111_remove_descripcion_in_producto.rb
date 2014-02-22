class RemoveDescripcionInProducto < ActiveRecord::Migration
  def change
    remove_column :productos, :descripcion
  end
end

class AddModuloToLineaKardex < ActiveRecord::Migration
  def change
    add_column :lineakardexes, :modulo, :string
  end
end

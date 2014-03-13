class AddEntregadoAToTraspaso < ActiveRecord::Migration
  def up
    add_column :traspasos, :entregado_a, :string, nil => false
  end

  def down
    remove_column :traspasos, :entregado_a
  end
end

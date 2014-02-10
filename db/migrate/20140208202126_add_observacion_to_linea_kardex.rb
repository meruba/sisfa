class AddObservacionToLineaKardex < ActiveRecord::Migration
  def change
    add_column :lineakardexes, :observaciones, :string
  end
end

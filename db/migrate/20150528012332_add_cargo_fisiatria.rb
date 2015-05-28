class AddCargoFisiatria < ActiveRecord::Migration
  def up
    add_column :fisiatria_configuracions, :cargo_fisiatria, :string
  end

  def down
    remove_column :fisiatria_configuracions, :cargo_fisiatria
  end
end

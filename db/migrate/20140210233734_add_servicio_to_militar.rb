class AddServicioToMilitar < ActiveRecord::Migration
  def change
    add_column :militars, :servicio, :string
  end
end

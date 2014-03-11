class AddTipoCanje < ActiveRecord::Migration
  def change
    add_column :canjes, :tipo, :string
  end
end

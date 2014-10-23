class AddFacturadoToProforma < ActiveRecord::Migration
  def up
  	add_column :proformas, :facturado, :boolean, default: false
  end
  def down
  	remove_column :proformas, :facturado
  end
end

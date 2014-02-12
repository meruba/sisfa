class RenameTableitemTransferenciaToitemTraspaso < ActiveRecord::Migration
  def change
  	rename_table :item_transferencia, :item_traspaso
  end
end

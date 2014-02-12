class RenameTableTransferenciaToTraspaso < ActiveRecord::Migration
  def change
  	rename_table :transferencia, :traspaso
  end
end

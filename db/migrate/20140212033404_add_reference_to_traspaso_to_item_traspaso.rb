class AddReferenceToTraspasoToItemTraspaso < ActiveRecord::Migration
  def change
  	add_reference :item_traspasos, :traspaso, :index => true
  end
end

class RemoveReferenceItemTransferenciaInTransferencia < ActiveRecord::Migration
  def change
  	remove_reference :transferencia, :item_transferencia
  	add_reference :item_transferencia, :transferencia, :index => true
  end
end

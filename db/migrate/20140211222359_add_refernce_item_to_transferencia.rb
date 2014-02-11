class AddRefernceItemToTransferencia < ActiveRecord::Migration
  def change
  	add_reference :transferencia, :item_transferencia, :index => true
  end
end

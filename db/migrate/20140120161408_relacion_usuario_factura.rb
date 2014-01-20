class RelacionUsuarioFactura < ActiveRecord::Migration
  def change
  	add_reference :facturas, :user, index: true
  end
end

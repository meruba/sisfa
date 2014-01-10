class ArreglandoClienteIdEnProformasAInteger < ActiveRecord::Migration
  def up
  	change_table :proformas do |t|
      t.change :cliente_id, :integer
    end
  end
  def dowm
  	change_table :proformas do |t|
      t.change :cliente_id, :float
    end
  end
end

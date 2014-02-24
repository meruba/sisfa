class CreateHospitalizacions < ActiveRecord::Migration
  def change
    create_table :hospitalizacions do |t|
    	t.date :fecha_emision, :null =>false
    	t.integer :numero, :null => false
    	t.float :subtotal, :null => false
    	t.float :iva, :null => false
    	t.float :total, :null => false
    	t.references :user, :index => true
    	t.references :cliente, :index => true
      t.timestamps
    end
  end
end

class CreateTraspasos < ActiveRecord::Migration
  def change
    create_table :traspasos do |t|
    	t.string :servicio
    	t.date :fecha_emision, :null =>false
    	t.integer :numero, :null => false
    	t.float :iva, :null => false
    	t.float :total, :null => false
    	t.references :user, :index => true
      t.timestamps
    end
  end
end

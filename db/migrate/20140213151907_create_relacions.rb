class CreateRelacions < ActiveRecord::Migration
  def change
    create_table :relacions do |t|
    	t.references :cliente, index: true
    	t.references :militar, index: true
    	t.string :relacion
      t.timestamps
    end
  end
end

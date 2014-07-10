class CreateCuartos < ActiveRecord::Migration
  def change
    create_table :cuartos do |t|
    	t.string :nombre
      t.timestamps
    end
  end
end

class CreateHorarios < ActiveRecord::Migration
  def change
    create_table :horarios do |t|
    	t.string :hora
    	t.references :paciente, index: true	
      t.timestamps
    end
  end
end

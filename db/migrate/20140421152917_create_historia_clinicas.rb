class CreateHistoriaClinicas < ActiveRecord::Migration
  def change
    create_table :historia_clinicas do |t|
    	t.integer :numero
    	t.date :fecha
    	t.references :paciente, :index => true
      t.timestamps
    end
  end
end

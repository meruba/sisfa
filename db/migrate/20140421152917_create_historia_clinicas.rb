class CreateHistoriaClinicas < ActiveRecord::Migration
  def change
    create_table :historia_clinicas do |t|

      t.timestamps
    end
  end
end

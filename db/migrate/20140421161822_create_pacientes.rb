class CreatePacientes < ActiveRecord::Migration
  def change
    create_table :pacientes do |t|

      t.timestamps
    end
  end
end

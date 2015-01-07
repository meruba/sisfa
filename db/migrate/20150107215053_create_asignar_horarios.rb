class CreateAsignarHorarios < ActiveRecord::Migration
  def change
    create_table :asignar_horarios do |t|

      t.timestamps
    end
  end
end

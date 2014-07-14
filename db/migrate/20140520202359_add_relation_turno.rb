class AddRelationTurno < ActiveRecord::Migration
  def change
  	add_reference :consulta_externa_morbilidads, :turno, index: true
  	add_reference :consulta_externa_preventivas, :turno, index: true  	
  end
end

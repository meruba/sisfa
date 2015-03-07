# == Schema Information
#
# Table name: resultado_tratamientos
#
#  id                 :integer          not null, primary key
#  personal_id        :integer
#  resultado          :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  atendido           :boolean          default(FALSE)
#  razon_editado      :string(255)
#  asignar_horario_id :integer
#  fecha              :datetime
#  horario_id         :integer
#

class ResultadoTratamiento < ActiveRecord::Base
	belongs_to :asignar_horario
	belongs_to :personal
	belongs_to :horario
	has_one :disponibilidad_horario

	#validations
	validates :resultado, :personal_id, :presence => true, :on => :update
	validates :fecha, :horario_id, :presence => true, :on => :create
	validate :isfull, :on => :create
	after_create :add_disponiblidad
	# accepts_nested_attributes_for :disponibilidad_horario

	def isfull
		numero_de_turnos = ResultadoTratamiento.where(:fecha => self.fecha.beginning_of_day..self.fecha.end_of_day, :horario_id => self.horario_id ).count() #turnos en ese horario
		if numero_de_turnos == Emisor.last.numero_turnos_fisiatria # configuracion de turnos x hora
			errors.add :asignar_horario_id, "Turnos llenos para la fecha: " + self.fecha.strftime("%Y-%m-%d")
		end
	end

	def add_disponiblidad
		turnos_config = Emisor.last.numero_turnos_fisiatria
		numero_de_horarios = Horario.where(:anulado => false).count()
		turnos_por_dia = numero_de_horarios * turnos_config
		turnos_emitidos_dia = ResultadoTratamiento.where(:fecha => self.fecha.beginning_of_day..self.fecha.end_of_day).count() #turnos de todo el dia
		dia_turno = DisponiblidadHorario.where(:dia => self.fecha).last
		unless dia_turno.nil? # no existe ese registro en ese dia
			if turnos_emitidos_dia == turnos_por_dia
				dia_turno.lleno = true
				dia_turno.save #actualiza el dia a lleno
			end
		else
			horario = DisponiblidadHorario.new
			horario.dia = self.fecha
			horario.save # crea un nuevo dia
		end
	end

end

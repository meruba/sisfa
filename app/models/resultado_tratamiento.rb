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
#

class ResultadoTratamiento < ActiveRecord::Base
	belongs_to :asignar_horario
	has_one :disponibilidad_horario
	validates :resultado, :personal_id, :presence => true, :on => :update
	validate :isfull
	after_create :add_disponiblidad
	accepts_nested_attributes_for :disponibilidad_horario

	def isfull
		numero_de_turnos = DisponiblidadHorario.where(:dia => self.fecha.beginning_of_day..self.fecha.end_of_day).count()
		if numero_de_turnos == 4
			errors.add :asignar_horario_id, "Turnos llenos para:" + self.asignar_horario.horario.hora
		end
	end

	def add_disponiblidad
		unless DisponiblidadHorario.last.nil?
			numero_de_turnos = DisponiblidadHorario.where(:dia => self.fecha.beginning_of_day..self.fecha.end_of_day).count()
			 #raise
			if numero_de_turnos == 2
			raise
				horario = DisponiblidadHorario.where(:dia => self.fecha.beginning_of_day..self.fecha.end_of_day).last
				horario.lleno = true
				horario.save
			else
				# raise
				# horario = DisponiblidadHorario.new
				# horario.dia = self.fecha
				# horario.resultado_tratamiento = self
				# horario.save
			end
		else
			raise
			horario = DisponiblidadHorario.new
			horario.dia = self.fecha
			horario.resultado_tratamiento = self
			horario.save
		end
	end
end

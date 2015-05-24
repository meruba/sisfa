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
#  paciente_id        :integer
#

class ResultadoTratamiento < ActiveRecord::Base
	belongs_to :asignar_horario
	belongs_to :personal
	belongs_to :horario
	belongs_to :paciente
	has_one :disponibilidad_horario

	#validations
	validates :resultado, :personal_id, :presence => true, :on => :update
	validates :fecha, :horario_id, :presence => true, :on => :create
	validate :isfull, :not_create_before_current_day, :on => :create
	validate :save_only_current_day, :on => :edit

	after_create :add_disponiblidad
	before_create :set_values
	after_destroy :update_disponibilidad
	# accepts_nested_attributes_for :disponibilidad_horario

	def set_values
		self.paciente =  self.asignar_horario.paciente
	end

	def isfull
		unless self.fecha.nil?
			numero_de_turnos = ResultadoTratamiento.where(:fecha => self.fecha.beginning_of_day..self.fecha.end_of_day, :horario_id => self.horario_id ).count() #turnos en ese horario
			if numero_de_turnos == FisiatriaConfiguracion.last.numero_turnos # configuracion de turnos x hora
				errors.add :asignar_horario_id, "Turnos llenos horario: " + self.horario.hora + " Fecha: " + self.fecha.strftime("%Y-%m-%d")
			end
		end
	end

	def save_only_current_day
		unless self.fecha.to_time.beginning_of_day == Time.now.beginning_of_day
			errors.add :fecha, "No puedes ingresar resultados de dias pasados o futuro"
		end
	end

	def not_create_before_current_day
		if self.fecha.to_time.beginning_of_day < Time.now.beginning_of_day
			errors.add :fecha, "No puedes registrar dias anteriores a la fecha"
		end
	end

	def update_disponibilidad
		if self.personal.nil?
			dia_turno = DisponiblidadHorario.where(:dia => self.fecha).last
			dia_turno.numero_actual_turnos = dia_turno.numero_actual_turnos - 1
      #recalcular numero de turnos
      turnos_por_dia = dia_turno.numero_horarios * dia_turno.numero_actual_turnos
      #actualizar a lleno
      if turnos_por_dia == 0
      	dia_turno.destroy
      else
	      if dia_turno.numero_actual_turnos == turnos_por_dia
	        dia_turno.lleno = true
	      else
	        dia_turno.lleno = false
	      end
	      dia_turno.save
      end
		end
	end

	def add_disponiblidad
		#primero buscar si existe algun registro del dia
		dia_turno = DisponiblidadHorario.where(:dia => self.fecha).last
		#condicion si existe
		unless dia_turno.nil?
			#saber cuantos turnos quedan
			if dia_turno.numero_actual_turnos + 1 == dia_turno.turnos_por_dia
				#actualizar a lleno
				dia_turno.lleno = true
				dia_turno.numero_actual_turnos = dia_turno.numero_actual_turnos + 1
				dia_turno.save
			else
				#actualizar solo el numero actual de turnos
				dia_turno.numero_actual_turnos = dia_turno.numero_actual_turnos + 1
				dia_turno.save
			end
		else
			#crear el dia por primera vez
			horario = DisponiblidadHorario.new
			horario.dia = self.fecha
			horario.numero_horarios = Horario.where(:anulado => false).count()
			horario.config_turnos = FisiatriaConfiguracion.last.numero_turnos
			horario.turnos_por_dia = horario.numero_horarios * horario.config_turnos
			horario.numero_actual_turnos = 1
			if horario.turnos_por_dia == 1
				horario.lleno = true
			end
			horario.save # crea un nuevo dia
		end
	end

end

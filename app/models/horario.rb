# == Schema Information
#
# Table name: horarios
#
#  id          :integer          not null, primary key
#  hora        :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  hora_inicio :string(255)
#  hora_final  :string(255)
#  anulado     :boolean          default(FALSE)
#

class Horario < ActiveRecord::Base
	has_many :resultado_tratamientos
	belongs_to :asignar_horario
	validates :hora_inicio, :hora_final, :presence =>true
  validates_format_of :hora_inicio, :hora_final, :with => /\A([0-9]|0[0-9]|1[0-9]|2[0-3]):[0-5][0-9]\Z/i
  validate :uniqueness_hour, on: :create
  validate :less_hour
  validate :not_anulado

  after_save :update_disponibilidad

  #validations
  def uniqueness_hour
    self.hora = self.hora_inicio + " - " + self.hora_final
    Horario.all.each do |h|
      if self.hora == h.hora
        errors.add :hora, "Ya existe este horario"
      end
    end
  end

  def less_hour
    if self.hora_inicio.nil? || self.hora_final.nil?
      if self.hora_inicio.to_time > self.hora_final.to_time
        errors.add :hora_inicio, "Hora de inicio incorrecta"
      end
    end
  end

  def not_anulado
    if self.anulado
      dias = ResultadoTratamiento.where(['fecha >= ?', Time.now.beginning_of_day])
      unless dias.empty?
        dias.each do |d|
          if d.horario == self
            return errors.add :hora, "No se puede anular hay turnos asignados"
          end
        end
      end
    end
  end

  #methods
  def update_disponibilidad
    if self.anulado
      horario_anulado()
    else
      add_horario()
    end
  end

  private

  def add_horario
    #obtener los dias de la fecha actual en adelante
    dias = DisponiblidadHorario.where(['dia >= ?', Time.now.beginning_of_day])
    #actualizar horarios
    unless dias.empty?
      dias.each do |d|
        d.lleno = false
        d.numero_horarios = d.numero_horarios + 1
        d.turnos_por_dia = d.numero_horarios * d.config_turnos
        d.save
      end
    end
  end

  def horario_anulado
    #obtener los dias de la fecha actual en adelante
    dias = DisponiblidadHorario.where(['dia >= ?', Time.now.beginning_of_day])
    #actualizar horarios
    unless dias.empty?
      dias.each do |d|
        #recalcular numero de turnos
        numero_horarios = d.numero_horarios - 1
        turnos_por_dia = numero_horarios * d.config_turnos
        #actualizar a lleno
        if d.numero_actual_turnos == turnos_por_dia
          d.lleno = true
        end
        #actualizar
        d.numero_horarios = numero_horarios
        d.turnos_por_dia = turnos_por_dia
        d.save
      end
    end
  end

end

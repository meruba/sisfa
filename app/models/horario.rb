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
  validate :uniqueness_hour
  validate :less_hour

  # before_create :set_values
  # after_update :update_disponibilidad

  def uniqueness_hour
    self.hora = self.hora_inicio + " - " + self.hora_final
    Horario.all.each do |h|
      if self.hora == h.hora
        errors.add :hora, "Ya existe este horario"
      end
    end
  end

  def less_hour
    if self.hora_inicio.to_time > self.hora_final.to_time
        errors.add :hora_inicio, "Hora de inicio incorrecta"
    end
  end

  def update_disponibilidad
    if self.anulado
    dias = DisponiblidadHorario.where(:dia => self.updated_at.beginning_of_day..self.updated_at.end_of_year)
      dias.each do |dia|
        dia.lleno = check_is_full(dia.dia)
        dia.save
      end
    else
    dias = DisponiblidadHorario.where(:dia => self.updated_at.beginning_of_day..self.updated_at.end_of_month)
      dias.each do |d|
        d.lleno = false
        d.save
      end
    end
  end

  private

  def check_is_full(day)
    is_full = false
    turnos_config = Emisor.last.numero_turnos_fisiatria
    numero_de_horarios = Horario.where(:anulado => false).count()
    turnos_por_dia = numero_de_horarios * turnos_config
    turnos_emitidos_dia = ResultadoTratamiento.where(:fecha => day.beginning_of_day..day.end_of_day).count() #turnos de todo el dia
    if turnos_emitidos_dia == turnos_por_dia
      is_full = true
    else
      is_full = false
    end
    return is_full
  end

end

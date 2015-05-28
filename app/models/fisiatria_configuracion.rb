# == Schema Information
#
# Table name: fisiatria_configuracions
#
#  id                     :integer          not null, primary key
#  numero_turnos          :integer
#  encargado_departamento :string(255)
#  grado_director         :string(255)
#  respuesta_tratamiento  :text
#  created_at             :datetime
#  updated_at             :datetime
#  cargo_fisiatria        :string(255)
#

class FisiatriaConfiguracion < ActiveRecord::Base

  validates :numero_turnos, :numericality => { :greater_than => 0 }
  validate :numero_de_turnos, on: :update
  after_update :update_disponibilidad

  def numero_de_turnos
    if numero_turnos_changed?
      dias = DisponiblidadHorario.where(['dia >= ?', Time.now.beginning_of_day])
      unless dias.empty?
        dias.each do |d|
          #recalcular numero de turnos
          turnos_por_dia = d.numero_horarios * self.numero_turnos
          if d.numero_actual_turnos > turnos_por_dia
            return errors.add :numero_turnos, "El número actual de turnos es menor a lo configurado"
          end
        end
      end
    end
  end

  #methods
  def update_disponibilidad
    if numero_turnos_changed?
      #obtener los dias de la fecha actual en adelante
      dias = DisponiblidadHorario.where(['dia >= ?', Time.now.beginning_of_day])
      #actualizar horarios
      unless dias.empty?
        dias.each do |d|
          #recalcular numero de turnos
          turnos_por_dia = d.numero_horarios * self.numero_turnos
          #actualizar a lleno
          if d.numero_actual_turnos == turnos_por_dia
            d.lleno = true
          else
            d.lleno = false
          end
          d.config_turnos = self.numero_turnos
          d.turnos_por_dia = turnos_por_dia
          d.save
        end
      end
    end
  end
end

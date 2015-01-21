# == Schema Information
#
# Table name: tratamiento_registros
#
#  id                 :integer          not null, primary key
#  nombre_tratamiento :string(255)
#  asignar_horario_id :integer
#  tratamiento_id     :integer
#  created_at         :datetime
#  updated_at         :datetime
#

class TratamientoRegistro < ActiveRecord::Base
end

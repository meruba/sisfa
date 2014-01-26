# == Schema Information
#
# Table name: pacientes
#
#  id                  :integer          not null, primary key
#  n_hclinica          :integer
#  fecha_de_ingreso    :date
#  pertenece           :string(255)
#  sexo                :string(255)
#  fecha_de_nacimiento :date
#  estado_civil        :string(255)
#  grado               :string(255)
#  familiar            :string(255)
#  brigada             :string(255)
#  tipo_de_paciente    :string(255)
#  created_at          :datetime
#  updated_at          :datetime
#  hora_de_ingreso     :time
#  cliente_id          :integer          not null
#

class Paciente < ActiveRecord::Base
belongs_to :cliente
accepts_nested_attributes_for :cliente

#validations
	validates :n_hclinica, :fecha_de_nacimiento, :hora_de_ingreso, :pertenece, :fecha_de_ingreso, :sexo, :estado_civil, :tipo_de_paciente, :presence => true
end

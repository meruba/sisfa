# == Schema Information
#
# Table name: hospitalizacion_registros
#
#  id                      :integer          not null, primary key
#  fecha_de_ingreso        :datetime         not null
#  fecha_de_salida         :datetime
#  especialidad            :string(255)      not null
#  medico_asignado         :string(255)
#  created_at              :datetime
#  updated_at              :datetime
#  diagnostico_ingreso     :string(255)
#  diagnostico_salida      :string(255)
#  discapacidad            :string(255)
#  dias_hospitalizacion    :integer
#  paciente_id             :integer
#  condicion_egreso        :string(255)
#  diagnostico_sec_egreso1 :string(255)
#  diagnostico_sec_egreso2 :string(255)
#  codigo_cie              :string(255)
#  especialidad_egreso     :string(255)
#  doctor_id               :integer
#  alta                    :boolean          default(FALSE)
#  alta_enfermeria         :boolean          default(FALSE)
#

class HospitalizacionRegistro < ActiveRecord::Base
	#relations
	belongs_to :paciente
	belongs_to :doctor
	has_one :nota_enfermera
	has_one :signo_vital
	has_one :asignacion_cama
	has_one :hospitalizacion
	has_many :item_entrega_turnos

	#callbacks	
	before_update :set_values
	before_create :build_relations

  #validations
	validates :doctor_id, :presence => { :message => "Debe elejir al doctor de la lista de resultados" }
  validates :fecha_de_ingreso, :medico_asignado, :presence => true
  validates :fecha_de_salida, :diagnostico_ingreso, :diagnostico_salida, :presence => true, :on => :update
  validate :already_hostipalizado, :on => :create
  validate :validate_fecha_salida, :on => :update
  validate :doctor_not_have_account, :on => :create

  def already_hostipalizado
  	paciente = HospitalizacionRegistro.where(:paciente_id => self.paciente_id, :alta => false).last
  	unless paciente.nil?
  		errors.add :paciente_id, "El paciente ya esta hospitalizado"	
  	end		
  end

  def validate_fecha_salida
  	unless self.fecha_de_salida.nil?
  		if self.fecha_de_salida < self.fecha_de_ingreso
  			errors.add :fecha_de_salida, "Fecha de salida no válida"			
  		end
  	end
  end

  def doctor_not_have_account
    if self.doctor.cliente.user.nil?
      errors.add :doctor_id, "El doctor no tiene una cuenta de usuario"
    end
  end

	#methods
	def set_values
		self.discapacidad = self.paciente.discapacidad
		unless self.fecha_de_salida.nil?
			self.dias_hospitalizacion = (self.fecha_de_salida.to_date - self.fecha_de_ingreso.to_date).to_i
		end
		# cama disponible una vez dado de alta
		self.asignacion_cama.cama.update(:ocupada => false)
	end

	def build_relations
		build_nota_enfermera
		true #validations
		build_signo_vital
		true #validations
		build_hospitalizacion
		true #validations
	end

	#class methods
	def self.autocomplete(params)
		pacientes = HospitalizacionRegistro.includes(paciente: [:cliente]).where(alta: false).where("clientes.nombre like ?", "%#{params}%").references(paciente: [:cliente])
		pacientes = pacientes.map do |hospitalizado|
			{
				:id => hospitalizado.id,
				:label => hospitalizado.paciente.cliente.nombre + " / " + "H.C:" + hospitalizado.paciente.n_hclinica.to_s,
				:value => hospitalizado.paciente.cliente.nombre
			}
		end
		pacientes
	end

	def self.reporte(fecha)
		registros = HospitalizacionRegistro.includes(:paciente).where(fecha_de_salida: fecha).references(:paciente)
	end

	def self.ingresados
		consultas = HospitalizacionRegistro.includes(paciente: [:informacion_adicional_paciente,:cliente]).where(:alta => false).references(paciente: [:informacion_adicional_paciente,:cliente])
	end
end

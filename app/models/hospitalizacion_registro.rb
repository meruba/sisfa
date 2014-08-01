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
#

class HospitalizacionRegistro < ActiveRecord::Base
	#relations
	belongs_to :paciente
	belongs_to :doctor
	has_one :nota_enfermera
	has_one :signo_vital
	has_one :asignacion_cama
	has_many :item_entrega_turnos

	#callbacks	
	before_update :set_values
	before_create :build_notas_and_signos
	after_save :build_comprobante

  #validations
  validates :fecha_de_ingreso, :medico_asignado, :presence => true
  validates :fecha_de_salida, :diagnostico_ingreso, :diagnostico_salida, :presence => true, :on => :update
  validate :already_hostipalizado, :on => :create
  validate :validate_fecha_salida, :on => :update

  def already_hostipalizado
  	paciente = HospitalizacionRegistro.where(:paciente_id => self.paciente_id, :alta => false).last
  	unless paciente.nil?
  		errors.add :paciente_id, "El paciente ya esta hospitalizado"	
  	end		
  end

  def validate_fecha_salida
  	if self.fecha_de_salida < self.fecha_de_ingreso
  		errors.add :fecha_de_salida, "Fecha de salida no válida"			
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

	def build_notas_and_signos
		build_nota_enfermera
		true #validations
		build_signo_vital
		true #validations
	end

	def build_comprobante
   	h = Hospitalizacion.new(
			:fecha_emision => Time.now,
			:numero => Hospitalizacion.last ? Hospitalizacion.last.numero + 1 : 1,
			:cliente_id => self.paciente.cliente.id,
			:user_id => self.doctor.cliente.user.id,
			:iva => 0,
			:subtotal => 0,
			:subtotal_12 => 0,
			:total => 0,
			:descuento => 0
		)
		h.save
	end

	#class methods
	def self.autocomplete(params)
    pacientes = HospitalizacionRegistro.includes(paciente: [:cliente]).where(alta: false).where("pacientes.n_hclinica like ?", "%#{params}%").references(paciente: [:cliente])
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

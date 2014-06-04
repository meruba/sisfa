# == Schema Information
#
# Table name: jornada_preventivas
#
#  id                               :integer          not null, primary key
#  inicio_atencion                  :datetime
#  fin_atencion                     :datetime
#  horas_trabajadas                 :datetime
#  doctor_id                        :integer
#  total_discapacitados             :integer          default(0)
#  total_hombre                     :integer          default(0)
#  total_mujer                      :integer          default(0)
#  total_blanco                     :integer          default(0)
#  total_mestizo                    :integer          default(0)
#  total_afroecuatoriano            :integer          default(0)
#  total_indigena                   :integer          default(0)
#  total_montubio                   :integer          default(0)
#  total_colombiano                 :integer          default(0)
#  total_peruano                    :integer          default(0)
#  total_otra_nacionalidad          :integer          default(0)
#  total_iess                       :integer          default(0)
#  total_issfa                      :integer          default(0)
#  total_ispol                      :integer          default(0)
#  total_otros_seguros              :integer          default(0)
#  total_aerea                      :integer          default(0)
#  total_naval                      :integer          default(0)
#  total_terrestre                  :integer          default(0)
#  total_activo                     :integer          default(0)
#  total_pasivo                     :integer          default(0)
#  total_aspirante                  :integer          default(0)
#  total_conscripto                 :integer          default(0)
#  total_activo_familiar            :integer          default(0)
#  total_pasivo_familiar            :integer          default(0)
#  total_derecho_hab                :integer          default(0)
#  total_civilies                   :integer          default(0)
#  total_prenatal_primera_10_19     :integer          default(0)
#  total_prenatal_primera_20_49     :integer          default(0)
#  total_prenatal_subsecuente_10_19 :integer          default(0)
#  total_prenatal_subsecuente_20_49 :integer          default(0)
#  total_partos                     :integer          default(0)
#  total_post_parto                 :integer          default(0)
#  total_primera_diu                :integer          default(0)
#  total_primera_go                 :integer          default(0)
#  total_primera_otros              :integer          default(0)
#  total_subsecuente_diu            :integer          default(0)
#  total_subsecuente_go             :integer          default(0)
#  total_subsecuente_otros          :integer          default(0)
#  total_cervico_uterino            :integer          default(0)
#  total_mamario                    :integer          default(0)
#  total_1_anio_primera             :integer          default(0)
#  total_1_4_anio_primera           :integer          default(0)
#  total_1_anio_subsecuente         :integer          default(0)
#  total_1_4_anio_subsecuente       :integer          default(0)
#  total_nino_consulta_p            :integer          default(0)
#  total_nino_consulta_s            :integer          default(0)
#  total_5_9_anios                  :integer          default(0)
#  total_10_14_anios                :integer          default(0)
#  total_15_19_anios                :integer          default(0)
#  total_20_49_anios                :integer          default(0)
#  total_50_64_anios                :integer          default(0)
#  total_65_anios                   :integer          default(0)
#  total_trabajadora_sexual         :integer          default(0)
#  total_certificado_medico         :integer          default(0)
#  created_at                       :datetime
#  updated_at                       :datetime
#

class JornadaPreventiva < ActiveRecord::Base

	belongs_to :doctor
	before_create :set_values

	#class methods
	def self.reporte(fecha)
		registros = JornadaPreventiva.includes(doctor: [:cliente]).where(:created_at => fecha).references(doctor: [:cliente])
	end

	def self.was_send
		jornada = JornadaPreventiva.where(:created_at => Time.now.beginning_of_day..Time.now.end_of_day).last
		if jornada.nil?
			enviado = false
		else
			enviado = true
		end			
		enviado
	end

	def set_values
		horas = self.fin_atencion - self.inicio_atencion
		self.horas_trabajadas = Time.now.beginning_of_day + horas.to_i #config local zone -5
		consultas = ConsultaExternaPreventiva.where(:doctor_id => self.doctor, :created_at => Time.now.beginning_of_day..Time.zone.now)
		valores = calculate(consultas)
		self.total_discapacitados 				= valores[0]
		self.total_hombre 								= valores[1]
		self.total_mujer 									= valores[2]
		self.total_blanco 								= valores[3]
		self.total_mestizo 								= valores[4]
		self.total_afroecuatoriano 				= valores[5]
		self.total_indigena 							= valores[6]
		self.total_montubio 							= valores[7]
		self.total_colombiano 						= valores[8]
		self.total_peruano 								= valores[9]
		self.total_otra_nacionalidad 			= valores[10]
		self.total_issfa 									= valores[11]
		self.total_iess 									= valores[12]
		self.total_ispol 									= valores[13]
		self.total_otros_seguros 					= valores[14]
		self.total_terrestre              = valores[15]		
		self.total_aerea                  = valores[16]
		self.total_naval                  = valores[17]
		self.total_civilies               = valores[18]
		self.total_activo                 = valores[19]
		self.total_pasivo                 = valores[20]
		self.total_aspirante              = valores[21]
		self.total_conscripto             = valores[22]
		self.total_activo_familiar        = valores[23]
		self.total_pasivo_familiar        = valores[24]
		self.total_derecho_hab            = valores[25]
		self.total_prenatal_primera_10_19 = valores[26]
		self.total_prenatal_primera_20_49 = valores[27]
		self.total_primera_diu 						= valores[28]
		self.total_primera_go           	= valores[29]
		self.total_primera_otros         	= valores[30]
		self.total_1_anio_primera         = valores[31]
		self.total_1_4_anio_primera       = valores[32]
		self.total_nino_consulta_p            = valores[33]
		self.total_prenatal_subsecuente_10_19 = valores[34]
		self.total_prenatal_subsecuente_20_49 = valores[35]
		self.total_subsecuente_diu       			= valores[36]
		self.total_subsecuente_go             = valores[37]
		self.total_subsecuente_otros          = valores[38]
		self.total_1_anio_subsecuente         = valores[39]
		self.total_1_4_anio_subsecuente       = valores[40]
		self.total_nino_consulta_s         		= valores[41]
		self.total_5_9_anios            			= valores[42]
		self.total_10_14_anios            		= valores[43]
		self.total_15_19_anios           			= valores[44]
		self.total_20_49_anios            		= valores[45]
		self.total_50_64_anios            		= valores[46]
		self.total_65_anios           				= valores[47]
		self.total_trabajadora_sexual         = valores[48]
		self.total_certificado_medico         = valores[49]
		self.total_partos          						= valores[50]
		self.total_post_parto         				= valores[51]
		self.total_cervico_uterino         		= valores[52]
		self.total_mamario         						= valores[53]
	end
	private
	def calculate(consultas)
		discpd, m, f = 0,0,0
		blanco, mestz, afro, indg, montb = 0,0,0,0,0
		colbn, prn, otro_ncl = 0,0,0
		issfa,iess,isspol,otros_seguro = 0,0,0,0
		ejerct, avcn, marn = 0,0,0
		civil, mil_activo, mil_pasivo, mil_aspirante, mil_conscripto, fam_activo, fam_pasivo, fam_der = 0,0,0,0,0,0,0,0
		prenatal_10_19_p, prenatal_20_49_p, primera_diu, primera_go, primera_otros = 0,0,0,0,0
		edad_1_primera,edad_1_4_primera,nino_consulta_p,prenatal_10_19_s,prenatal_20_49_s,subsecuente_diu,subsecuente_go,subsecuente_otros,edad_1_subsecuente,edad_1_4_subsecuente,nino_consulta_s = 0,0,0,0,0,0,0,0,0,0,0
		edad_5_9,edad_10_14,edad_15_19,edad_20_49,edad_50_64,edad_65 = 0,0,0,0,0,0
		trabajadora,certificado,parto,post_parto,cervico,mamario = 0,0,0,0,0,0
		consultas.each do |c|
			#total discapacidad
			if c.paciente.discapacidad == "SI"
				discpd += 1
			end
			#total sexo
			if c.paciente.cliente.sexo == "Masculino"
				m = m + 1
			else
				f = f + 1
			end
			#total raza
			case c.paciente.informacion_adicional_paciente.raza
			when "Blanco"
				blanco += 1
			when "Mestizo"
				mestz += 1
			when "Afroecuatoriano/Afrodesenciende"
				afro += 1
			when "Indigena"
				indg += 1
			when "Montubio"
				montb += 1
			end
			#total nacionalidad
			case c.paciente.informacion_adicional_paciente.nacionalidad
			when "Colombiano"
				colbn += 1
			when "Peruano"
				prn += 1
			when "Otro"
				otro_ncl += 1
			end
			#total afiliado
			case c.paciente.afiliado
			when "ISSFA"
				issfa += 1
			when "IESS"
				iess += 1
			when "ISSPOL"
				isspol += 1
			when "OTROS"
				otros_seguro += 1
			end
			#total fuerza
			case c.paciente.pertenece_a
			when "Ejercito"
				ejerct += 1
			when "Aviacion"
				avcn += 1
			when "Marina"
				marn += 1
			end
			#total tipo paciente
			case c.paciente.tipo
			when "civil"
				civil += 1
			when "militar"
				case c.paciente.estado
				when "Activo"
					mil_activo += 1
				when "Pasivo"
					mil_pasivo += 1
				when "Aspirante"
					mil_aspirante += 1
				when "Conscripto"
					mil_conscripto += 1
				end
			when "familiar"
				case c.paciente.estado
				when "Activo"
					fam_activo += 1
				when "Pasivo"
					fam_pasivo += 1
				when "Derecho Hab"
					fam_der += 1
				end
			end
			#total atencion
			case c.tipo_de_atencion
			when "Primera"
				case c.atencion_preventiva
				when "Mujeres"
					if c.prenatal == "10-19 años"
						prenatal_10_19_p += 1						
					else
						prenatal_20_49_p += 1
					end
					case c.planificacion_familiar
					when "DIU"
						primera_diu += 1
					when "G.O"
						primera_go += 1
					when "OTROS"
						primera_otros += 1
					end
				when "Niños"
					case c.grupos_de_edad
					when "1-11 MESES"
						edad_1_primera += 1
					when "1-4 AÑOS"
						edad_1_4_primera += 1
					end
				when "Niños adolecentes y Adultos"
					nino_consulta_p += 1					
				end
			when "Subsecuente"
				case c.atencion_preventiva
				when "Mujeres"
					if c.prenatal == "10-19 años"
						prenatal_10_19_s += 1
					else
						prenatal_20_49_s += 1
					end
					case c.planificacion_familiar
					when "DIU"
						subsecuente_diu += 1						
					when "G.O"
						subsecuente_go += 1
					when "OTROS"
						subsecuente_otros += 1
					end
				when "Niños"
					case c.grupos_de_edad
					when "1-11 MESES"
						edad_1_subsecuente += 1
					when "1-4 AÑOS"
						edad_1_4_subsecuente += 1
					end
				when "Niños adolecentes y Adultos"
					nino_consulta_s += 1
				end
			end
			#total edad
			if c.atencion_preventiva == "Niños adolecentes y Adultos"
				case c.grupos_de_edad
				when "5-9 AÑOS"
					edad_5_9 += 1
				when "10-14 AÑOS"
					edad_10_14 += 1
				when "15-19 AÑOS"
					edad_15_19 += 1
				when "20-49 AÑOS"
					edad_20_49 += 1
				when "50-64 AÑOS"
					edad_50_64 += 1
				when "65 AÑOS +"
					edad_65 += 1
				end
			end
			#total certificado
			if c.trabajadora_sexual == true
				trabajadora += 1
			end
			#total certificado
			if c.certificado_medico == true
				certificado += 1
			end
			#total parto
			if c.partos == true
				parto += 1
			end
			#total post_parto
			if c.post_partos == true
				post_parto += 1
			end
			#total doc
			if c.doc == "Cervico Uterino"
				cervico += 1
			else if c.doc == "Mamario"
				mamario += 1
			end
			end
		end
		valores = [discpd,m,f,blanco,mestz,afro,indg,montb,colbn,prn,otro_ncl,issfa,iess,isspol,otros_seguro,ejerct,avcn,marn,civil, mil_activo, mil_pasivo, mil_aspirante,mil_conscripto,fam_activo,fam_pasivo,fam_der,prenatal_10_19_p, prenatal_20_49_p, primera_diu, primera_go, primera_otros,edad_1_primera,edad_1_4_primera,nino_consulta_p,prenatal_10_19_s,prenatal_20_49_s,subsecuente_diu,subsecuente_go,subsecuente_otros,edad_1_subsecuente,edad_1_4_subsecuente,nino_consulta_s,edad_5_9, edad_10_14, edad_15_19, edad_20_49, edad_50_64, edad_65,trabajadora,certificado,parto,post_parto,cervico,mamario]
	end
end

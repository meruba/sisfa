# == Schema Information
#
# Table name: emergencia_parte_mensuals
#
#  id                           :integer          not null, primary key
#  doctor_id                    :integer
#  total_hombre                 :integer          default(0)
#  total_mujer                  :integer          default(0)
#  total_aerea                  :integer          default(0)
#  total_naval                  :integer          default(0)
#  total_terrestre              :integer          default(0)
#  total_militar_sa             :integer          default(0)
#  total_militar_sp             :integer          default(0)
#  total_militar_asp            :integer          default(0)
#  total_militar_cpto           :integer          default(0)
#  total_familiar_sa            :integer          default(0)
#  total_familiar_sp            :integer          default(0)
#  total_familiar_hab           :integer          default(0)
#  total_civil_convenio         :integer          default(0)
#  total_civil_particular       :integer          default(0)
#  total_memor_1_anio           :integer          default(0)
#  total_1_4_anios              :integer          default(0)
#  total_5_9_anios              :integer          default(0)
#  total_10_44_anios            :integer          default(0)
#  total_15_19_anios            :integer          default(0)
#  total_20_49_anios            :integer          default(0)
#  total_50_64_anios            :integer          default(0)
#  total_65_anios               :integer          default(0)
#  total_atencion_clinico       :integer          default(0)
#  total_atencion_quirurjico    :integer          default(0)
#  total_atencion_obstetrico    :integer          default(0)
#  total_atencion_traumatologia :integer          default(0)
#  total_accidente              :integer          default(0)
#  total_envenenamiento         :integer          default(0)
#  total_violencia              :integer          default(0)
#  total_otras                  :integer          default(0)
#  total_destino_alta           :integer          default(0)
#  total_destino_consulta       :integer          default(0)
#  total_destino_observacion    :integer          default(0)
#  total_destino_internamiento  :integer          default(0)
#  total_destino_tr_sal         :integer          default(0)
#  total_destino_tr_nom         :integer          default(0)
#  created_at                   :datetime
#  updated_at                   :datetime
#

class EmergenciaParteMensual < ActiveRecord::Base
	belongs_to :doctor
	
	def self.add_emergencia(emergencia)
		valores = valores(emergencia)
		self.create(
			:doctor_id => emergencia.doctor_id,
			:total_hombre => valores[0],
			:total_mujer => valores[1],
			:total_terrestre => valores[2],
			:total_aerea => valores[3],
			:total_naval => valores[4],
			:total_civil_convenio => valores[5],
			:total_civil_particular => valores[6],
			:total_militar_sa => valores[7],
			:total_militar_sp => valores[8],
			:total_militar_asp => valores[9],
			:total_militar_cpto => valores[10],
			:total_familiar_sa => valores[11],
			:total_familiar_sp => valores[12],
			:total_familiar_hab => valores[13],
			:total_memor_1_anio => valores[14],
			:total_1_4_anios => valores[15],
			:total_5_9_anios => valores[16],
			:total_10_44_anios => valores[17],
			:total_15_19_anios => valores[18],
			:total_20_49_anios => valores[19],
			:total_50_64_anios => valores[20],
			:total_65_anios => valores[21],
			:total_atencion_clinico => valores[22],
			:total_atencion_quirurjico => valores[23],
			:total_atencion_obstetrico => valores[24],
			:total_atencion_traumatologia => valores[25],
			:total_accidente => valores[26],
			:total_envenenamiento => valores[27],
			:total_violencia => valores[28],
			:total_otras => valores[29],
			:total_destino_alta => valores[30],
			:total_destino_consulta => valores[31],
			:total_destino_observacion => valores[32],
			:total_destino_internamiento => valores[33],
			:total_destino_tr_sal => valores[34],
			:total_destino_tr_nom => valores[35]
		)	
	end
	
	#class methods
	def self.reporte(fecha)
		registros = EmergenciaParteMensual.includes(doctor: [:cliente]).where(:created_at => fecha).references(doctor: [:cliente])
	end

	private

	def self.valores(emergencia)
		c = emergencia
		m, f = 0,0
		ejerct, avcn, marn = 0,0,0
		convenio,particular,mil_activo, mil_pasivo, mil_aspirante, mil_conscripto, fam_activo, fam_pasivo, fam_der = 0,0,0,0,0,0,0,0,0
		edad_1_11_meses,edad_1_4, edad_5_9, edad_10_14, edad_15_19, edad_20_49, edad_50_64, edad_65 = 0,0,0,0,0,0,0,0,0
		clinico,quirurjico,obstetrico,traumatologia = 0,0,0,0
		accidente,envenenamiento,violencia,otros = 0,0,0,0
		alta,consulta,observacion,internamiento,sal,nom = 0,0,0,0,0,0
			#total sexo
			if c.paciente.cliente.sexo == "Masculino"
				m = 1
			else
				f = 1
			end
			#total fuerza
			case c.paciente.pertenece_a
			when "Ejercito"
				ejerct = 1
			when "Aviacion"
				avcn = 1
			when "Marina"
				marn = 1
			end
			#total tipo paciente
			case c.paciente.tipo
			when "civil"
				if c.tipo_usuario == "CONVENIO"
					convenio = 1
				else if c.tipo_usuario == "PARTICULAR"
					particular = 1
					end
				end
			when "militar"
				case c.paciente.estado
				when "Activo"
					mil_activo = 1
				when "Pasivo"
					mil_pasivo = 1
				when "Aspirante"
					mil_aspirante = 1
				when "Conscripto"
					mil_conscripto = 1
				end
			when "familiar"
				case c.paciente.estado
				when "Activo"
					fam_activo = 1
				when "Pasivo"
					fam_pasivo = 1
				when "Derecho Hab"
					fam_der = 1
				end
			end
			#total edad
			case c.grupos_etareos
			when "1-11 MESES"
				edad_1_11_meses = 1
			when "1-4 AÑOS"
				edad_1_4 = 1
			when "5-9 AÑOS"
				edad_5_9 = 1
			when "10-14 AÑOS"
				edad_10_14 = 1
			when "15-19 AÑOS"
				edad_15_19 = 1
			when "20-49 AÑOS"
				edad_20_49 = 1
			when "50-64 AÑOS"
				edad_50_64 = 1
			when "65 AÑOS +"
				edad_65 = 1
			end
			#total atencion
			case c.atencion
			when "CLINICO"
				clinico = 1
			when "QUIRURJICO"
				quirurjico = 1
			when "OBSTETRICO"
				obstetrico = 1
			when "TRAUMATOLOGIA"
				traumatologia = 1
			end
			#total condicion_diagnostico
			case c.causa
			when "ACCIDENTE"
				accidente = 1
			when "ENVENENAMIENTO"
				envenenamiento= 1
			when "VIOLENCIA"
				violencia = 1
			when "OTRAS"
				otros = 1
			end
			#total destino
			case c.destino
			when "ALTA"
				alta = 1
			when "CONSULTA EXTERNA"
				consulta = 1
			when "OBSERVACION"
				observacion = 1
			when "INTERNAMIENTO"
				internamiento = 1
			when "TR. OTR. INST. SAL."
				sal = 1
			when "TR. OTR. INST. NO M"
				nom = 1
			end
		valores = [m,f,ejerct,avcn,marn,convenio,particular,mil_activo, mil_pasivo, mil_aspirante, mil_conscripto, fam_activo, fam_pasivo, fam_der,edad_1_11_meses,edad_1_4, edad_5_9, edad_10_14, edad_15_19, edad_20_49, edad_50_64, edad_65,clinico,quirurjico,obstetrico,traumatologia,accidente,envenenamiento,violencia,otros,alta,consulta,observacion,internamiento,sal,nom]
	end
end

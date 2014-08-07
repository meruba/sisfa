# == Schema Information
#
# Table name: item_nota_enfermeras
#
#  id                :integer          not null, primary key
#  nota_enfermera_id :integer
#  fecha             :datetime
#  hora              :datetime
#  nota              :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#

class ItemNotaEnfermera < ActiveRecord::Base
	#relation
	belongs_to :nota_enfermera
	belongs_to :user
	# after_create :validate_time
	#validation
	validates :fecha, :hora, :nota, :presence => true
	validate :validate_hour

	def validate_hour
		unless self.hora.nil?
			t = self.hora.to_s.scan(/\d\d/)
			if t.empty?
				errors.add :hora, "Formato de hora no valida" 
			end
		end
	end
end

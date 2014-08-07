# == Schema Information
#
# Table name: nota_enfermeras
#
#  id                 :integer          not null, primary key
#  hospitalizacion_id :integer
#  created_at         :datetime
#  updated_at         :datetime
#

class NotaEnfermera < ActiveRecord::Base
	#relations
	belongs_to :hospitalizacion_registro
	has_many :item_nota_enfermeras, :order => 'created_at DESC'
end

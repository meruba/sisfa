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
end

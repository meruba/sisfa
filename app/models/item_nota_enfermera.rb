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
end

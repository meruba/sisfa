# == Schema Information
#
# Table name: personals
#
#  id         :integer          not null, primary key
#  cliente_id :integer
#  created_at :datetime
#  updated_at :datetime
#  suspendido :boolean          default(FALSE)
#

class Personal < ActiveRecord::Base
	belongs_to :cliente
  has_many :resultado_tratamientos
  validates :cliente_id, :uniqueness => { :message => "Esta persona ya ha sido registrada" }
	accepts_nested_attributes_for :cliente

  #methods
  def cliente_attributes=(attributes)
    if attributes['id'].present?
      self.cliente = Cliente.find(attributes['id'])
    end
    super
  end

end

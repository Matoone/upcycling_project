class Maker < ApplicationRecord


  belongs_to :user
  has_one :address, dependent: :destroy
  has_one :shop, dependent: :destroy

  def is_own_identity(maker_id)
    if maker_id != self.id
      return false
    else
      return true
    end
  end
  
end

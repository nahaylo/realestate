class AdPrice < ActiveRecord::Base
  belongs_to :ad

  def price_to_s
    0 == self.price.to_i ? "договірна" : self.price.to_i
  end

  def price_type_to_s
    Ad::PRICE_TYPE[self.price_type.to_i]
  end
end

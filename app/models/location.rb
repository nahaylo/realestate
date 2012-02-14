# encoding: utf-8
class Location < ActiveRecord::Base
  has_many :ads

  def page_link
    if self.page_id.nil?
      "item_name=#{self.title}&rubs=0&logic=logic_and&item_price1=від&item_price2=до"
    else
      "rub=#{self.page_id}&subrub=#{self.page_sub_id}&item_price1=&item_price2="
    end
  end
end

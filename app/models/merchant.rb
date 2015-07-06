class Merchant < ActiveRecord::Base

  has_many :order_items
  has_many :items

end

class Item < ActiveRecord::Base
  has_many :purchases
  has_many :merchants, through: :purchases
end
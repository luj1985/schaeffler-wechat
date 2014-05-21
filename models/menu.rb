class Menu < ActiveRecord::Base
  has_many :relations
  has_many :articles, :through => :relations
end

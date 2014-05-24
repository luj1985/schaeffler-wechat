class Menu < ActiveRecord::Base
  has_many :relations
  has_many :articles, :through => :relations

  validates :name, :presence => true, :uniqueness => true
  validates :title, :presence => true
end

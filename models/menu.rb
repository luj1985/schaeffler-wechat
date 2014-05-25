class Menu < ActiveRecord::Base
  attr_accessor :selected_articles
  
  has_many :relations
  has_many :articles, :through => :relations

  validates :name, :presence => true, :uniqueness => true
  validates :title, :presence => true
end

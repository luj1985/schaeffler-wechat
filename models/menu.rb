class Menu < ActiveRecord::Base
  attr_accessor :selected_articles, :selected_pages
  
  has_many :relations
  has_many :articles, :through => :relations

  has_many :page_relations
  has_many :pages, :through => :page_relations

  validates :name, :presence => true, :uniqueness => true
  validates :title, :presence => true
end

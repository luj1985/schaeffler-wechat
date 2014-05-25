class Page < ActiveRecord::Base

  has_many :page_relations
  has_many :menus, :through => :page_relations
end

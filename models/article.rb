class Article < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :name, uniqueness: true
  validates :title, presence: true
  validates :body, presence: true

  has_many :relations
  has_many :menus, :through => :relations

end

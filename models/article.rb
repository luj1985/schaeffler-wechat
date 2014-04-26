class Article < ActiveRecord::Base
	validates :name, presence: true
	validates :name, uniqueness: true
	validates :title, presence: true
	validates :body, presence: true
end

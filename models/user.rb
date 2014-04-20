class User < ActiveRecord::Base
  validates :tel, presence: true
  validates :name, :workshop, :workshop_address, presence: true
end

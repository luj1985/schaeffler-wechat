class User < ActiveRecord::Base
  validates :tel, presence: true
  validates :name, :workshop, :workshop_address, presence: true

  def can_join_match?
  	not self.join_match
  end
end

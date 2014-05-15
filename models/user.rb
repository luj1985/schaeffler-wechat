class User < ActiveRecord::Base
  validates :tel, :presence => true
  validates :name, :presence => true
  validates :workshop, :presence => true
  validates :province, :presence => true
  validates :city, :presence => true
  validates :workshop_address, :presence => true

  after_initialize :init

  def can_join_match?
  	not self.join_match
  end

  def init
  	self.apply_attemped ||= false
  	self.join_match ||= false
  	self.granted ||= false
    self.blocked ||= false
    self.lasttime ||= Time.now
    self.count ||= 0
  end
end

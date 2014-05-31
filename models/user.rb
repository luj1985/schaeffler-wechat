class User < ActiveRecord::Base
  self.per_page = 12
  
  has_one :fence, :foreign_key => :openid, :primary_key => :openid

  validates :tel, :length => {:is => 11, :message => '手机号码不正确'},
                  :numericality => { :only_integer => true,:message => '手机号码不正确' }, 
                  :presence => true

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
  end

  def update_permission
    self.granted = true
    self.save
  end
end

class User < ActiveRecord::Base
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
    self.lasttime ||= Time.now
    self.count ||= 0
  end

  def sameday?
    now = Time.now.strftime '%Y%m%d'
    lasttime = self.lasttime.strftime '%Y%m%d'
    now == lasttime
  end
  
  def update_permission
    if sameday? then
      self.count += 1
    else
      self.count = 1
    end
    self.lasttime = Time.now
    self.granted = true
    self.save
  end

  def exceed_limit?
    now = Time.now
    lasttime = self.lasttime
    sameday? && self.count >= 20
  end
end

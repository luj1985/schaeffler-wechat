class Lottery < ActiveRecord::Base

  self.per_page = 12

  belongs_to :user
  accepts_nested_attributes_for :user

  validates :serial, :presence => true, if: :exchanging?
  validates :tel, :length => {:is => 11, :message => '手机号码不正确'},
                  :numericality => { :only_integer => true,:message => '手机号码不正确' }, 
                  :presence => true, 
                  if: :validate_charge_tel?
  validates :product, :presence => true, if: :validate_product?

  after_initialize :init

  def init
    self.status ||= 'AVAILABLE'
  end

  NAMES = {
    '1' => ["一等奖", "新一代iPhone", "/images/rewards/1.png"],
    '2' => ["二等奖", "iPad Mini", "/images/rewards/2.png"],
    '3' => ["三等奖", "舍弗勒双肩包", "/images/rewards/3.png"],
    '4' => ["四等奖", "开心话费10元"]
  }

  def level_name
    NAMES[self.level][0]
  end

  def display_name
    NAMES[self.level][1]
  end

  def display_image
    NAMES[self.level][2]
  end

  STATUS = {
    'USED' => '已经被使用',
    'AVAILABLE' => '可用',
    'EXCHANGING' => '正在兑奖',
  }

  def display_status
    STATUS[self.status]
  end


  def self.challenge serial
    crypted_serial = Digest::MD5::hexdigest serial
    self.find_by_crypted_serial crypted_serial
  end

  def validate_charge_tel?
    exchanging? && self.level == '4'
  end

  def validate_product?
    exchanging? && ['1','2', '3'].include?(self.level)
  end


  # validate attributes when lottery is in other stages
  def exchanging?
  	self.status != 'AVAILABLE'
  end

  def available?
    self.status == 'AVAILABLE'
  end

  def can_apply_join_match?
    user = self.user
    return user && user.granted && !user.apply_attemped
  end

  def user_attributes=(attributes)
    if attributes['id'].present?
      self.user = User.find(attributes['id'])
    end
    super
  end
end

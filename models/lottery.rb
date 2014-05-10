class Lottery < ActiveRecord::Base
  belongs_to :user
  accepts_nested_attributes_for :user

  validates :serial, presence: true, if: :exchanging?
  validates :tel, presence: true, if: :validate_charge_tel?

  after_initialize :init

  before_save :grant_permission

  def self.challenge serial
    crypted_serial = Digest::MD5::hexdigest serial
    self.find_by_crypted_serial crypted_serial
  end

  def grant_permission()
    if self.user then
      self.user.granted = true
    end
  end

  def validate_charge_tel?
    tel_charge? && exchanging?
  end

  def level_name
    case self.level
    when '1'
      "一等奖"
    when '2'
      "二等奖"
    when '3'
      "三等奖"
    when '4'
      "四等奖"
    else
      raise "Invalid lottery level"
    end
  end

  def display_name
    case self.level
    when '1'
      "新一代iPhone"
    when '2'
      "iPad Mini"
    when '3'
      "舍弗勒双肩包"
    when '4'
      "开心花费10元"
    else
      raise "Invalid lottery level"
    end
  end

  def name
    "level#{self.level}"
  end

  def tel_charge?
    self.level == '4'
  end
  
  # validate attributes when lottery is in other stages
  def exchanging?
  	self.status != 'AVAILABLE'
  end

  def available?
  	self.status == 'AVAILABLE'
  end

  def init
    self.status ||= 'AVAILABLE'
  end

  def can_apply_join_match?
    user = self.user
    return false unless user
    # 一、二、三等奖才有资格申请观赛
    return false if self.level == '4'
    return user.granted && !user.apply_attemped
  end

  def user_attributes=(attributes)
    if attributes['id'].present?
      self.user = User.find(attributes['id'])
    end
    super
  end
end

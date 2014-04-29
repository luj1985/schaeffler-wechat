class Lottery < ActiveRecord::Base
  belongs_to :user
  accepts_nested_attributes_for :user

  validates :serial, presence: true, if: :exchanging?
  validates :tel, presence: true, if: :validate_charge_tel?

  after_initialize :init

  before_save :grant_permission

  def grant_permission()
    if self.user then
      self.user.granted = true
    end
  end

  def validate_charge_tel?
    tel_charge? && exchanging?
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
    return user.granted && !user.apply_attemped
  end

  def user_attributes=(attributes)
    if attributes['id'].present?
      self.user = User.find(attributes['id'])
    end
    super
  end
end

class Lottery < ActiveRecord::Base
  belongs_to :user
  accepts_nested_attributes_for :user

  validates :serial, presence: true, if: :exchanging?
  validates :tel, presence: true, if: :validate_charge_tel?

  after_initialize :init

  def validate_charge_tel?
    tel_charge? && exchanging?
  end

  def tel_charge?
    self.name == 'Level 4'
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

  def user_attributes=(attributes)
    if attributes['id'].present?
      self.user = User.find(attributes['id'])
    end
    super
  end
end

class Lottery < ActiveRecord::Base
  belongs_to :user
  accepts_nested_attributes_for :user

  validates :serial, presence: true, if: :exchanging?
  validates :tel, presence: true, if: :tel_charge?

  after_initialize :init

  def tel_charge?
    self.name == 'Level 4'
  end
  
  def exchanging?
  	self.status == 'EXCHANGING'
  end

  def available?
  	self.status = 'AVAILABLE'
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

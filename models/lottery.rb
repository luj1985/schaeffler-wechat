class Lottery < ActiveRecord::Base
  belongs_to :user
  accepts_nested_attributes_for :user

  validates :serial, presence: true, if: :exchanging?

  after_initialize :init

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

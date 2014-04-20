class Lottery < ActiveRecord::Base
  belongs_to :user
  accepts_nested_attributes_for :user

  def user_attributes=(attributes)
    if attributes['id'].present?
      self.user = User.find(attributes['id'])
    end
    super
  end
end

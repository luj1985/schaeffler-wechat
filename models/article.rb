class Article < ActiveRecord::Base
  validates :name, presence: true
  validates :name, uniqueness: true
  validates :title, presence: true
  validates :body, presence: true

  after_initialize :init

  def init
    self.body ||= '<p>正文内容</p>'
  end
end

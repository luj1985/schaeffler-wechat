class AutoReply < ActiveRecord::Base

  after_initialize :init

  def init
    self.weight ||= 4
  end
end

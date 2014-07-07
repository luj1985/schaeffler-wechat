class RTypeValidator < ActiveModel::Validator
  def validate record
    rtype = record.rtype
    existings = AutoReply.where(:event => record.event, :param => record.param)
    if (existings.any? { |reply| reply.rtype != rtype })
      record.errors[:rtype] << "Invalid reply type \"#{rtype}\""
    end
  end
end

class AutoReply < ActiveRecord::Base
  validates_with RTypeValidator
  after_initialize :init

  def init
    self.weight ||= 4
  end
end
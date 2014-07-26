class Mobile < ActiveRecord::Base

  after_initialize :init
  def init
    self.count ||= 0
  end

  # TODO: use activerecord single table inherit ?
  def link
    if self.os == 'android' then ('/' + self.file)
    elsif self.os == 'ios' then "https://itunes.apple.com/cn/app/she-fu-lei-chan-pin-zhu-shou/id899938848"
    end
  end

  def name
    if self.os == 'android' then self.file
    elsif self.os == 'ios' then 'Apple app store'
    end
  end
end

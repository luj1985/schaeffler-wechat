class Fence < ActiveRecord::Base
  after_initialize :init

  def init
    self.activetime ||= Time.now
    self.success ||= 0
    self.fail ||= 0
  end

  def sameday?
    (Time.now.strftime '%Y%m%d') == (self.activetime.strftime '%Y%m%d')
  end

  def inc_success_counter
  	if sameday? then
  		self.success += 1
  	else
  		self.success = 1
  	end
  end

  def inc_fail_counter
  	if sameday? then
  		self.fail += 1
  	else
  		self.fail = 1
  	end
  end

  def exceed_max_success?
  	sameday? && (self.success >= 20)
  end

  def exceed_max_fail?
  	sameday? && (self.fail >= 3)
  end
end

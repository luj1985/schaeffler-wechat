class Fence < ActiveRecord::Base
  after_initialize :init

  def init
    self.activetime ||= Time.now
    self.success ||= 0
    self.fail ||= 0
  end

  def sameday?
    (Time.now.localtime.strftime '%Y%m%d') == (self.activetime.localtime.strftime '%Y%m%d')
  end

  def inc_success_counter
  	if sameday? then
  		self.success += 1
  	else
      # reset all status when new days come
  		self.success = 1
      self.fail = 0
  	end
    self.activetime = Time.now.utc
  end

  def inc_fail_counter
  	if sameday? then
  		self.fail += 1
  	else
  		self.fail = 1
      self.success = 0
  	end
    self.activetime = Time.now.utc
  end

  def exceed_max_success?
  	sameday? && (self.success >= 20)
  end

  def exceed_max_fail?
  	sameday? && (self.fail >= 3)
  end
end

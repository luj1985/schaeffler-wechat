SchaefflerWechat::App.helpers do

  def page_style hash={}
  	@page_style ||=  { 'data-role' => 'page' }
  	@page_style.merge! hash
  end

  def header_style hash={}
  	@header_style ||= {'data-role' => 'header', 'data-position' => 'fixed'}
  	@header_style.merge! hash
  end

end

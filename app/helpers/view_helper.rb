SchaefflerWechat::App.helpers do

  def page_style hash={}
    @page_style ||=  { 'data-role' => 'page' }
    @page_style.merge! hash
  end

end

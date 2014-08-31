SchaefflerWechat::App.helpers do

  def page_style hash={}
    @page_style ||=  { 'data-role' => 'page' }
    @page_style.merge! hash
  end

  def format_date date
    date = date || Date.now
    date = Date.parse(date) unless date.respond_to?(:strftime)
    date.strftime("%Y-%m-%d")
  end
end

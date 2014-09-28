SchaefflerWechat::Admin.helpers do

  def summary auto_reply
    summary = full_summary(auto_reply)
    summary.length > 40 ? summary[0,40] + '...' : summary
  end

  def full_summary auto_reply

    summary = auto_reply.title if auto_reply.rtype == 'news'
    summary = auto_reply.description if auto_reply.rtype == 'text'
    summary
  end
end

SchaefflerWechat::Wechat.helpers do

  def validate_messages
#   token = ENV["WECHAT_TOKEN"] || 'test'
#    raw = [token, params[:timestamp], params[:nonce]].compact.sort.join
#    Digest::SHA1.hexdigest(raw) == params[:signature]
    true
  end
end

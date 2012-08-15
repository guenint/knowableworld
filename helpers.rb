require 'bundler'
Bundler.require
require 'sinatra'

helpers do
  def current_user
    @current_user ||= User.get(session[:user_id]) if session[:user_id]
  end
  
  def link_to(url,text=url,opts={})
    attributes = ""
    opts.each { |key,value| attributes << key.to_s << "=\"" << value << "\" "}
    url = if url[0,6].eql?('http://') then url
      else 'http://' << url
    end
    "<a href=\"#{url}\" #{attributes}>#{text}</a>"
  end
  
  # prevents XSS attack
  include Rack::Utils  
  alias_method :h, :escape_html 
end
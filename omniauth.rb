require 'bundler'
Bundler.require
require 'sinatra'

configure do
  set :sessions, true
end

use OmniAuth::Builder do
    provider :facebook, '422533567784773','c055a72da78eebeffc6dcf29a3a4ad8b'
    # provider :att, 'client_id', 'client_secret', :callback_url => (ENV['BASE_DOMAIN']
end

# response from Facebook
get '/auth/:provider/callback' do
  auth = request.env["omniauth.auth"]
  user = User.first_or_create({:site_id => auth["uid"], :site => auth["provider"]}, {
    :site_id => auth["uid"],
    :site => auth["provider"], 
    :name => auth["info"]["name"],
    :created_at => Time.now,
    :updated_at => Time.now })
  session[:user_id] = user.id
  flash[:notice] = "Successfully signed in."
  redirect '/'
end

# log out
get '/sign_out' do
  session[:user_id] = nil
  flash[:notice] = "Successfully signed out."
  redirect '/'
end
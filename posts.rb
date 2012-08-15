require 'bundler'
Bundler.require
require 'sinatra'

get '/' do
	@posts = Post.all
	@title = 'Knowlabe World'
	erb :home
end

get '/posts/:id' do
	@post = Post.get(params[:id])

	if @post.nil?
		flash[:error] = "No such post in the Knowable World."
		redirect '/'
	end

	# else
	@title = @post.title
	erb :post
end
require 'bundler'
Bundler.require
require 'sinatra'

get '/' do
	@posts = Post.all
	@title = 'Knowable World'
	erb :home
end

get '/posts/:id' do
	@post = Post.get(params[:id])

	if @post.nil?
		flash[:error] = "No such post in the Knowable World."
		redirect '/'
	end

	@title = @post.title
	erb :post
end

get '/posts/new' do
	@title = "Contribute to the Knowable World"
	if current_user && current_user.admin?
	 	erb :new_post
	else
		redirect '/'
	end
end

post '/posts/new' do
	if current_user && current_user.admin?
		post = Post.create(:title => params[:title], :body => params[:body], 
			:user => current_user, :created_at => Time.now, 
			:updated_at => Time.now)
		flash[:notice] = "Successfully contributed to the Knowable World."
     end
     redirect '/'
 end

get '/posts/:id/edit' do
    @post = Post.get(params[:id])
    if @post.nil?
        redirect '/'
    end

    if current_user && current_user.eql?(@post.user)
        erb :edit_post
        @title = "Editing the Knowable World"
    else
        redirect '/'
    end
end

post '/posts/:id/edit' do
    @post = Post.get(params[:id])
    if @post.nil?
        redirect '/'
    end

    if current_user && current_user.eql?(@post.user)
        @post.update(:title => params[:title], :body => params[:body], 
            :updated_at => Time.now)
        flash[:notice] = "Successfully updated the Knowable World."
    end

    redirect '/'
end

get '/posts/:id/delete' do
    @post = Post.get(params[:id])
    if @post.nil?
        redirect '/'
    end

    if current_user && current_user.eql?(@post.user)
        @post.destroy
        flash[:notice] = "Deleted post."
    end

    redirect '/'
end

get '/users/:id/posts' do
    @user = User.get(params[:id])
    if user && user.admin?
        @posts = Post.all(:user => current_user)
        @title = "#{current_user.name}'s Posts"
        erb :user_posts
    else
        redirect '/'
    end
end
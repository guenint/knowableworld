require 'bundler'
Bundler.require
require 'sinatra'

get '/users' do
	@users = User.all
	@title = 'Knowable World Users'
	erb :userlist
end

get '/users/:id' do
	@user = Users.get(params[:id])

	if @user=nil?
		flash[:error]= "No such user in the Knowable World."
		redirect '/users'
	end
	@title = @user.title
	erb :user
end

#edit a user	
post '/users/:id/edit' do
    @user = User.get(params[:id])
    if @user.nil?
        redirect '/users'
    end

    if current_user
        @user.update(:name => params[:name])
        flash[:notice] = "Successfully updated your Knowable World."
    end

    redirect '/'
end

#delete a user if admin
get '/users/:id/destroy' do
	@user = User.get(params[:id])
   if current_user && current_user.admin?
		@user.destroy
		flash[:notice] = "User deleted."
	end
	redirect '/'
end
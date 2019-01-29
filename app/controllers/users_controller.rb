class UsersController < ApplicationController

	configure do
		set :sessions_secret, "3lklk2ml23-0op;l"
    	enable :sessions
	end

	get '/users/:slug' do
    	@user = User.find_by_slug(params[:slug])
    	
		erb :'/users/show'
  	end
end

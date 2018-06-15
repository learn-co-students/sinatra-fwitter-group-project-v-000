class UsersController < ApplicationController

	get '/users/home' do
  		if logged_in?
  			redirect "/users/#{current_user.slug}"
  		else
  			redirect '/'
  		end
  	end

  get '/users/:slug' do
  		@user = current_user
  		erb :'/users/show'
  end

end